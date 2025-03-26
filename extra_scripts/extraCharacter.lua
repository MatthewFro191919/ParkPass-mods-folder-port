
local characters = {}

function onCreate()
    addLuaScript('extra_scripts/extraIcon')
end
function createCharacter(char,json,x,y,isPlayer,addIcon)
    if checkFileExists('characters/'..json..'.json') then
        if isPlayer == nil then
            isPlayer = false
        end
        table.insert(characters,char)
        runHaxeCode(
            [[
                var isPlayer = ]]..tostring(isPlayer)..[[;
                var character = new Character(]]..x..','..y..',"'..json..[[",isPlayer);
                game.modchartSprites.set("]]..char..[[",character);
                
                if(isPlayer){
                    game.insert(game.members.indexOf(game.boyfriendGroup),character);
                }
                else{
                    game.insert(game.members.indexOf(game.dadGroup),character);
                }
                return;
            ]]
        )
        if addIcon then
            callScript('extra_scripts/extraIcon','addExtraIcon',{char..'Icon',getProperty(char..'.healthIcon'),false,isPlayer == true,true})
        end
    end
end

function removeCharacter(char,removeImageFromMemory)
    if luaSpriteExists(char) then
        if removeImageFromMemory then
            local imageFile = runHaxeCode(
                [[
                    var image = game.modchartSprites.get("]]..char..[[").imageFile;
                    game.modchartSprites.get("]]..char..[[").kill();
                    game.modchartSprites.get("]]..char..[[").destroy();
                    game.modchartSprites.remove("]]..char..[[");
                    return image;
                ]]
            )
            --if version >= '0.7' then
                --callOnHScript('removeFromMemory',{imageFile})
            --elseif version == '0.6.3' then
            callScript('scripts/optimization','removeFromMemory',{imageFile})
            --end

        else
            runHaxeCode(
                [[
                    game.modchartSprites.get("]]..char..[[").kill();
                    game.modchartSprites.get("]]..char..[[").destroy();
                    game.modchartSprites.remove("]]..char..[[");
                    return; 
                ]]
            )
        end
        for i, chars in pairs(characters) do
            if char == chars then
                table.remove(characters,i)
                break
            end
        end
    end
end
function resetExtraCharPos(char,whichGroup)
    if luaSpriteExists(char) then
        if whichGroup == nil then
            if getProperty(char..'.isPlayer') then
                whichGroup = 'boyfriendGroup'
            else
                whichGroup = 'dadGroup'
            end
        elseif whichGroup == 'dad' then
            whichGroup = 'dadGroup'
        elseif whichGroup == 'gf' then
            whichGroup = 'gfGroup'
        else
            whichGroup = 'boyfriendGroup'
        end
        setProperty(char..'.x',getProperty(whichGroup..'.x') + getProperty(char..'.positionArray[0]')*(getProperty(char..'isPlayer') and -1 or 1))
        setProperty(char..'.y',getProperty(whichGroup..'.y') + getProperty(char..'.positionArray[1]'))
    end
end
function extraCharacterAnim(char,anim,reset,isSingAnim)
    if luaSpriteExists(char) then
        runHaxeCode(
            [[
                game.modchartSprites.get("]]..char..[[").playAnim("]]..anim..[[",]]..tostring(reset)..[[);
                ]]..(isSingAnim and 'game.modchartSprites.get("'..char..'").holdTimer = 0;' or '')..[[
                return;
            ]]
        )
    end
end

function onBeatHit()
    for i, chars in pairs(characters) do
        if luaSpriteExists(chars) and not getProperty(chars..'.stunned') and not getProperty(chars..'.specialAnim')  and curBeat % getProperty(chars..'.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty(chars..'.animation.curAnim.name'),'sing') then
            extraCharacterAnim(chars,'idle',true)
        end
    end
end