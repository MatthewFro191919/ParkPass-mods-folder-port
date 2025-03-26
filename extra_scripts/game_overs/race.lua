function onGameOverStart()
    setProperty('boyfriend.visible',false)
    setProperty('boyfriend.animation.curAnim.frameRate',44)
    makeLuaSprite('gfDead','modstuff/gameovers/gfsosboluda',0,0)
    setScrollFactor('gfDead',0,0)
    setProperty('gfDead.alpha',0.001)
    doTweenAlpha("gfDead",'gfDead',1,1,'circIn')
    screenCenter('gfDead')
    addLuaSprite('gfDead',true)
    setPropertyFromClass('flixel.FlxG','camera.zoom',1.6)
end
function onGameOver()
    local substate = 'substates.GameOverSubstate'
    if version <= '0.6.3' then
        substate = 'GameOverSubstate'
    end
    setPropertyFromClass(substate,'deathSoundName','racelose')
    setPropertyFromClass(substate,'loopSoundName','mario_gameovernew')
    setPropertyFromClass(substate,'endSoundName','mario_retry')
end