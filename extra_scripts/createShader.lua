local runningShaders = {}
local shaderTweens = {}
local objectShaders = {}

local changeCharacterEvents = {}--Remove shader before the character changes, this fix the clone of the character
function onCreatePost()
    for events = 0,getProperty('eventNotes.length')-1 do
        if getPropertyFromGroup('eventNotes',events,'event') == 'Change Character' then
            local char = getPropertyFromGroup('eventNotes',events,'value1')
            local strum = getPropertyFromGroup('eventNotes',events,'strumTime') - 100
            if char == '0' or string.lower(char) == 'bf' then
                char = 'boyfriend'
            elseif char == '1' or string.lower(char) == 'dad' then
                char = 'dad'
            elseif char == '2' or string.lower(char) == 'gf' then
                char = 'gf'
            end
            table.insert(objectShaders,{strum,char})
        end
    end
end


function createShader(lua,shader,obrigatory)

    if checkFileExists('shaders/'..shader..'.frag') and (shadersEnabled or obrigatory) then
        makeLuaSprite(lua,nil)
        if obrigatory then
            if version <= '0.6.3' then
                setPropertyFromClass('ClientPrefs','shadersEnabled',true)
            else
                setPropertyFromClass('backend.ClientPrefs','data.shadersEnabled',true)
            end
        end
        runHaxeCode(
            [[
                game.getLuaObject("]]..lua..[[").shader = game.createRuntimeShader("]]..shader..[[");
                return;
            ]]
        )
        if obrigatory then
            if version <= '0.6.3' then
                setPropertyFromClass('ClientPrefs','shadersEnabled',shadersEnabled)
            else
                setPropertyFromClass('backend.ClientPrefs','data.shadersEnabled',shadersEnabled)
            end
        end
        loadShaderVars(lua,shader)
    end
end

function loadShaderVars(lua,shader)
    runningShaders[lua] = shader
    if shader == 'TvEffect' then
        setShaderFloat(lua,'vignetteIntensity',0)
        setShaderFloat(lua,'chromIntensity',0)
        setShaderFloat(lua,'tvIntensity',0.001)
        setShaderFloat(lua,'tvFrequency',0.4)
        setShaderFloat(lua,'tvDistorcion',0.1)
        setShaderBool(lua,'lineTv',true)
        setShaderFloat(lua,'lineFrequency',0.4)
        setShaderFloat(lua,'lineSize',0.01)
        setShaderFloat(lua,'lineOffset',0.005)
        setShaderFloat(lua,'lineSpace',0.7)
        setShaderFloat(lua,'multiply',1)
        setShaderBool(lua,'vignetteFollowAlpha',true)
    elseif shader == "MirrorEffect" then
        setShaderFloat(lua,'zoom',1)
        setShaderFloat(lua,'x',0)
        setShaderFloat(lua,'y',0)
    elseif shader == 'FMV' then
        setShaderFloat(lua,'x',0)
        setShaderFloat(lua,'y',0)
    elseif shader== 'ColorFillShader' then
        setShaderFloat(lua,'red',0)
        setShaderFloat(lua,'blue',0)
        setShaderFloat(lua,'green',0)
        setShaderFloat(lua,'fade',1)
    end
end

function runShader(camera,shader,add)
    local cams = {}
    local s = {}
    if type(camera) == 'table' then
        cams = camera
    elseif type(camera) == 'string' then
        cams = {camera}
    else
        return
    end
    if type(shader) == 'table' then
        s = shader
    elseif type(shader) == 'string' then
        s = {shader}
    else
        return
    end
    for i, cam in pairs(cams) do
        local shaders = {}
        cam = getCamString(cam)
        if objectShaders[cam] == nil then
            objectShaders[cam] = {}
        else
            if add ~= false then
                shaders = objectShaders[cam]
            end
        end

        for i, shad in pairs(s) do
            table.insert(shaders,shad)
        end
        objectShaders[cam] = shaders
    end
    runShaderCamera(cams)
end

function runShaderOnSprite(sprite,shader)--Just Work One Shader!!
    if isShaderRunning(shader) then
        
        if sprite == 'boyfriend' or sprite == 'gf' or sprite == 'dad' then
            sprite = 'game.'..sprite
        else
            if luaSpriteExists(sprite) then
                sprite = 'game.getLuaObject('..sprite..')'
            else
                return
            end
        end

        runHaxeCode(
            [[
                ]]..sprite..[[.shader = game.getLuaObject(']]..shader..[[').shader;
                return;
            ]]
        )
    end
end

function removeShaderCamera(shader,camera)
    local cams = {}

    local shaders ={}
    if type(camera) == 'table' then
        cams = camera
    elseif type(camera) == 'string' then
        cams = {camera}
    else
        for cam, filters in pairs(objectShaders) do
            table.insert(cams,cam)
        end
    end

    if type(shader) == 'table' then
        shaders = shader
    elseif type(shader) == 'string' then
        shaders = {shader}
    end
    for i, cam in pairs(cams) do
        cam = getCamString(cam)
        if #shaders == 0 then
            objectShaders[cam] = {}
        else
            for i, filters in pairs(objectShaders[cam]) do
                for i, shader in pairs(shaders) do
                    if (filters == shader) then
                        table.remove(objectShaders[cam],i)
                        break
                    end
                end
                if objectShaders[cam][i] == nil then
                    break
                end
            end
        end
    end
    for i, shad in pairs(shaders) do
        table.remove(runningShaders,shad)
    end
    
    runShaderCamera(cams)
end

function onDestroy()
    removeShaderCamera()-- Prevents crashes
end

function getCamString(cam)
    if cam == 'game' then
        return 'camGame'
    elseif cam == 'hud' then
        return 'camHUD'
    elseif cam == 'other' then
        return 'camOther'
    end
    return cam
end

function runShaderCamera(camera)
    local cams = {}
    local s = {}
    local code = ''
    if type(camera) == 'table' then
        cams = camera
    elseif type(camera) == 'string' then
        cams = {camera}
    end
    for i, cam in pairs(cams) do
        cam = getCamString(cam)
        if objectShaders[cam] ~= nil  then
            if cam == 'camGame' then
                code = code..'game.camGame'
            elseif cam == 'hud' or cam == 'camHUD' then
                code = code..'game.camHUD'
            elseif cam == 'other' or cam == 'camOther' then
                code = code..'game.camOther'
            elseif luaSpriteExists(cam) then
                code = code..'game.getLuaObject("'..cam..'")'
            else
                if version > '0.6.3' and getVar(cam) ~= nil or version == '0.6.3' and runHaxeCode([[return getVar("]]..cam..[[") != null;]]) then
                    code = code..'getVar('..cam..')'
                else
                    goto continue
                end
            end
            local shaders = ''
            for i, shader in pairs(objectShaders[cam]) do
                shaders = shaders..'new ShaderFilter(game.getLuaObject("'..shader..'").shader)'
                if i < #objectShaders[cam] then
                    shaders = shaders..','
                end
            end
            code = code..'.setFilters(['..shaders..']);'
        end
        --runHaxeCode(code)
        
        code = code..'\n'
        ::continue::
    end

    if code ~= '' then
        code = code..'return;'
        runHaxeCode(code)
    end
end

local elapTime = 0
function onUpdate(el)

    elapTime = elapTime + el
    for lua, shader in pairs(runningShaders) do
        if shader == 'TvEffect' then
            setShaderFloat(lua,'uTime',elapTime)
        end
    end
    for i, shaders in pairs(shaderTweens) do
        if luaSpriteExists(shaders[1]) then
            setShaderFloat(shaders[1],shaders[2],getProperty(shaders[4]..'.x'))
        end
    end
end

function cancelShaderTween(tween)
    if shaderTweens[tween] ~= nil then
        cancelTween(tween)
        table.remove(shaderTweens,tween)
    end
end

function isShaderRunning(shader)
    if runningShaders[shader] ~= nil then
        return true
    end
    return false
end

function doShaderTween(shader,variable,target,duration,easing,tag)
    local function startShaderTween(shaderLua)
        
        if isShaderRunning(shaderLua) then
            local tagTween = tag
            if tagTween == nil then
                tagTween = shaderLua..variable
            end


            local tween = 'shaderTween'..tagTween
            if duration == nil then
                duration = 1
            end
            if easing == nil then
                easing = 'quintOut'
            end
            --cancelShaderTween(tween)
            makeLuaSprite(tagTween,nil,getShaderFloat(shaderLua,variable))
            doTweenX(tween,tagTween,target,duration,easing)
            shaderTweens[tween] = {shaderLua,variable,target,tagTween}
        end
    end
    if type(shader) == 'table' then
       for i, filter in pairs(shader) do
            startShaderTween(filter)
       end
    elseif type(shader) == 'string' then
        startShaderTween(shader)
    end
end

function endTweenShader(tween)
    if shaderTweens[tween] ~= nil then
        
        setShaderFloat(shaderTweens[tween][1],shaderTweens[tween][2],shaderTweens[tween][3])
        removeLuaSprite(shaderTweens[tween][4],true)
        shaderTweens[tween] = nil
    end
end
function onTweenCompleted(tag)
    if string.find(tag,'shaderTween',0,true) then
        endTweenShader(tag)
    end
end
