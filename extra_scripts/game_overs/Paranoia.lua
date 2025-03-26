local time = 0
local continueTime = 0
local enableCount = false
local line = 0
local enableShake = false

local shakeIntensity = 0
function onGameOverStart()
    precacheMusic('mrvover')
    line = getRandomInt(1,5)
    precacheSound('virtual/line'..line)
    time = 24
    enableCount = true
    setProperty('boyfriend.visible',false)
    makeLuaSprite('headVirtual','mario/virtual/MrVGameover2',0,0)
    setProperty('headVirtual.offset.x',-400)
    setScrollFactor('headVirtual',0,0)
    setProperty('headVirtual.alpha',0.001)
    screenCenter('headVirtual')
    addLuaSprite('headVirtual',true)

    makeLuaSprite('handVirtual','mario/virtual/MrVGameover3',0,0)
    setProperty('handVirtual.offset.x',400)
    setScrollFactor('handVirtual',0,0)
    screenCenter('handVirtual')
    setProperty('handVirtual.alpha',0.001)
    addLuaSprite('handVirtual',true)

    makeLuaSprite('bfVirtual','mario/virtual/MrVGameover1',0,0)
    setScrollFactor('bfVirtual',0,0)
    screenCenter('bfVirtual')
    setProperty('bfVirtual.alpha',0.001)
    addLuaSprite('bfVirtual',true)


    makeLuaText('continueText','CONTINUE\n>     0     <',screenWidth,0,screenHeight-50)
    setTextSize('continueText',50)
    setTextBorder('continueText',1,'000000')
    setProperty('continueText.color',getColorFromHex('FF0000'))
    setProperty('continueText.alpha',0.001)
    screenCenter('continueText','x')
    addLuaText('continueText',true)

    runHaxeCode(
        [[
            game.modchartTexts.get('continueText').cameras = [FlxG.camera];
            return;
            
        ]]
    )
    setPropertyFromClass('flixel.FlxG','camera.zoom',0.8)

end
function onUpdate()
    if inGameOver and getProperty('boyfriend.animation.curAnim.curFrame') > 0 then
        setProperty('boyfriend.animation.curAnim.curFrame',0)
    end
end
function onGameOverConfirm()
    enableCount = false
    enableShake = false
    setTextString('continueText','CONTINUE\n>           <')
    stopSound('virtualLine')
end

function onUpdate(el)
    if enableCount then
        time = time - el
        if math.floor(time) ~= continueTime then

            continueTime = math.floor(time)
            if continueTime == 20 then
                playMusic('mrvover')
                setProperty('continueText.alpha',1)
            elseif continueTime == 18 then
                playSound('virtual/line'..line,1,'virtualLine')
                doTweenAlpha('handVirtual','handVirtual',1,5)
                doTweenAlpha('headVirtual','headVirtual',1,5)
            elseif continueTime == 4 then
                doTweenAlpha('bfVirtual','bfVirtual',1,3)
                enableShake = true
            elseif continueTime == 1 then
                runHaxeCode(
                    [[
                        FlxTween.tween(FlxG.camera,{zoom: 1.5},0.5,{ease: FlxEase.expoIn});
                        return;
                    ]]
                )
            elseif continueTime == 0 then
                os.exit(false,true)
            end
            --playSound('')
            setTextString('continueText','CONTINUE\n>     '..continueTime..'     <')
        end
        if enableShake then
            if shakeIntensity < 0.05 then
                shakeIntensity = shakeIntensity + (el*0.005)
            end
            cameraShake('game',shakeIntensity,0.1)
        end
    end
end
function onGameOver()
    local substate = 'substates.GameOverSubstate'
    if version <= '0.6.3' then
        substate = 'GameOverSubstate'
    end
    setPropertyFromClass(substate,'deathSoundName','GBdeath')
    setPropertyFromClass(substate,'endSoundName','GBconfirm')
end
