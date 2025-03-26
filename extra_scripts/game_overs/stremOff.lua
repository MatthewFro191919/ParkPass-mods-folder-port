function onGameOverStart()
    setProperty('boyfriend.visible',false)
    makeLuaSprite('stream','modstuff/gameovers/so_cool_gameover',0,0)
    setScrollFactor('stream',0,0)
    addLuaSprite('stream',true)
    setProperty('stream.alpha',0.001)
    runTimer('streamError',2)
    setPropertyFromClass('flixel.FlxG','camera.zoom',1)
end

function onTimerCompleted(tag)
    if tag == 'streamError' then
        doTweenAlpha('streamAlpha','stream',1,4)
    end
end
function onGameOver()
    local substate = 'substates.GameOverSubstate'
    if version <= '0.6.3' then
        substate = 'GameOverSubstate'
    end
    setPropertyFromClass(substate,'deathSoundName','fnf_loss_sfx2')
    setPropertyFromClass(substate,'loopSoundName','SCgameover')
    setPropertyFromClass(substate,'endSoundName','gameOverEndUB')
end