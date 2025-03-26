function onGameOverStart()
    setProperty('boyfriend.visible',false)
    local x = getProperty('boyfriend.x') - 300
    local y = getProperty('boyfriend.y') - 100
    makeAnimatedLuaSprite('wario','mario/Wario/Apparition_Game_Over',-150,-100)
    setScrollFactor('wario',0,0)
    scaleObject('wario',2.2,2.2)
    addAnimationByPrefix('wario','open','wario open mouth',24,false)
    addAnimationByPrefix('wario','month','wario bite',24,false)
    playAnim('wario','open')
    addLuaSprite('wario',false)

    makeAnimatedLuaSprite('bfFall','mario/Wario/Apparition_Game_Over',x + 300,y + 100)
    scaleObject('bfFall', 2.0, 2.0);
    addAnimationByPrefix('bfFall','fall','bf fall anim',24,false)
    addLuaSprite('bfFall',false)

    runTimer('closeMounth',2)
end
function onTimerCompleted(tag)
    if tag == 'closeMounth' then
        removeLuaSprite('wario',false)
        setProperty('wario.y',-200)
        addLuaSprite('wario',true)
        playAnim('wario','month',true)
    end
end
function onGameOver()
    local substate = 'substates.GameOverSubstate'
    if version <= '0.6.3' then
        substate = 'GameOverSubstate'
    end
    setPropertyFromClass(substate,'deathSoundName','Wario/APPdeath')
    setPropertyFromClass(substate,'loopSoundName','Wario/APPgameover')
    setPropertyFromClass(substate,'endSoundName','Wario/APPconfirm')
end