function onGameOverStart()
    setProperty('boyfriend.visible',false)



    makeLuaSprite('goldenOver','modstuff/gameovers/golden_land_gameover',0,0)
    --setProperty('goldenOver.alpha',0.001)
    setScrollFactor('goldenOver',0,0)
    setProperty('goldenOver.alpha',0.001)
    addLuaSprite('goldenOver',true)
    runTimer('goldenAppear',2)
    --setProperty('goldenOver.antialiasing',false)
    screenCenter('goldenOver')

    makeAnimatedLuaSprite('gbStatic','modstuff/static',0,0)
    addAnimationByPrefix('gbStatic','anim','static play',24,true)
    setScrollFactor('gbStatic',0,0)
    scaleObject('gbStatic',5,5)
    screenCenter('gbStatic')
    setProperty('gbStatic.alpha',0.05)
    setBlendMode('gbStatic','add')
    addLuaSprite('gbStatic',true)

    setPropertyFromClass('flixel.FlxG','camera.zoom',2)
    runHaxeCode(
        [[
            game.camGame.setFilters([]);
            game.camHUD.setFilters([]);
            return;
        ]]
    )
end
function onTimerCompleted(tag)
    if tag == 'goldenAppear' then
        doTweenAlpha('golden','goldenOver',1,15,'cubeIn')
        doTweenX('goldenX','goldenOver.scale',1.25,12,'sineOut')
        doTweenY('goldenY','goldenOver.scale',1.25,12,'sineOut')
    end
end
function onGameOver()
    local substate = 'substates.GameOverSubstate'
    if version <= '0.6.3' then
        substate = 'GameOverSubstate'
    end
    setPropertyFromClass(substate,'deathSoundName','GBdeath')
    setPropertyFromClass(substate,'loopSoundName','GBgameover')
    setPropertyFromClass(substate,'endSoundName','GBconfirm')
end