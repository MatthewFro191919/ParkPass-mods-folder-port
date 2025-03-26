local allowSound = false

function onGameOver()
    local substate = 'substates.GameOverSubstate'
    if version <= '0.6.3' then
        substate = 'GameOverSubstate'
    end
    setPropertyFromClass(substate,'deathSoundName','OGN_die')
    setPropertyFromClass(substate,'loopSoundName','OGN_gameover')
    setPropertyFromClass(substate,'endSoundName','OGN_gameoverretry')
end
function onGameOverStart()
    setPropertyFromClass('flixel.FlxG','camera.zoom',0.5)
    setProperty('boyfriend.visible',false)
    makeLuaSprite('ogn','modstuff/gameovers/OGNdeath',0,0)
    setProperty('ogn.alpha',0.001)
    setProperty('ogn.antialiasing',false)
    setScrollFactor('ogn',0,0)
    scaleObject('ogn',2,2)
    addLuaSprite('ogn',true)
    screenCenter('ogn')
    runTimer('OGNAppear',10)
end
function onUpdate()
    if inGameOver and not allowSound and getProperty('boyfriend.animation.curAnim.curFrame') >= 13 then
        setProperty('boyfriend.animation.curAnim.curFrame',13)
    end
end
function onDestroy()
    cancelTween('ognAlpha')
end
function onTimerCompleted(tag)
    if tag == 'OGNAppear' then
        allowSound = true
        doTweenAlpha('ognAlpha','ogn',1,5,'linear')
    end
end
