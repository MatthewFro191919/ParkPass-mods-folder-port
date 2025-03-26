function onGameOverStart()
    setProperty('boyfriend.visible',false)
    makeAnimatedLuaSprite('noSignalBG','modstuff/gameovers/YCBU_GameOver_Assets',0,0)
    addAnimationByPrefix('noSignalBG','anim','color screen',0,true)
    setScrollFactor('noSignalBG',0,0)
    screenCenter('noSignalBG')
    addLuaSprite('noSignalBG',true)

    makeAnimatedLuaSprite('noSignalText','modstuff/gameovers/YCBU_GameOver_Assets',0,0)
    addAnimationByPrefix('noSignalText','anim','text',24,true)
    updateHitbox('noSignalText')
    setScrollFactor('noSignalText',0,0)
    addLuaSprite('noSignalText',true)
    screenCenter('noSignalText')
end
function onGameOver()
    local substate = 'substates.GameOverSubstate'
    if version <= '0.6.3' then
        substate = 'GameOverSubstate'
    end
    setPropertyFromClass(substate,'deathSoundName','UBdeath')
    setPropertyFromClass(substate,'loopSoundName','gameOverUB')
    setPropertyFromClass(substate,'endSoundName','gameOverEndUB')
end