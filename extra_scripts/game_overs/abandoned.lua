local time = 0
function onGameOverStart()
    setProperty('boyfriend.visible',false)
    makeAnimatedLuaSprite('mario','mario/promo/Greenio_GameOver_Assets')
    addAnimationByPrefix('mario','hang','faceless hang',24,true)
    addAnimationByPrefix('mario','scare','faceless scare',24,true)
    addOffset('mario','hang',-120,0)
    addOffset('mario','scare',-80,-90)
    
    scaleObject('mario',0.8,0.8)
    playAnim('mario','hang')
    setScrollFactor('mario',0,0)
    screenCenter('mario')
    setProperty('mario.alpha',0.001)
    addLuaSprite('mario',true)
    time = 34
    setPropertyFromClass('flixel.FlxG','camera.zoom',1)
end

local timeInt = 34
function onUpdate(el)
    if inGameOver then
        time = time - el
        debugPrint(timeInt)
        if timeInt ~= math.floor(time) then
            timeInt = math.floor(time)
            if timeInt == 30 then
    
                doTweenAlpha('marioAlpha','mario',0.75,25)
                doTweenX('marioX','mario.scale',1,25)
                doTweenY('marioY','mario.scale',1,25)
            elseif timeInt == 1 then
                playAnim('mario','scare')
                cancelTween('marioX')
                cancelTween('marioY')
                scaleObject('mario',0.8,0.8)
                runTimer('byeMario',0.35)
            end
        end
    end
end
function onTimerCompleted(tag)
    if tag == 'byeMario' then
        setProperty('mario.alpha',0)
        loadSong(songName,difficulty)
    end
end
function onGameOver()
    local substate = 'substates.GameOverSubstate'
    if version <= '0.6.3' then
        substate = 'GameOverSubstate'
    end
    setPropertyFromClass(substate,'deathSoundName','fnf_loss_sfx2')
    setPropertyFromClass(substate,'loopSoundName','greenioover')
    setPropertyFromClass(substate,'endSoundName','CDconfirm')
end