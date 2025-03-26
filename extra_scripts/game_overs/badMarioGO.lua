local started = false
local state = 0
local enableKick = false
function onGameOverStart()
    --makeAnimatedLuaSprite('badMario','mario/BadMario/HUD_Mario_Blue',getProperty('boyfriend.x')-450,getProperty('boyfriend.y') - 70)
    makeAnimatedLuaSprite('badMario','mario/BadMario/HUD_Mario_Blue',getProperty('boyfriend.x')-270,getProperty('boyfriend.y') + 70)
    addAnimationByPrefix('badMario','idle','mario walk',0,false)
    addAnimationByPrefix('badMario','walk','mario walk',12,true)
    addAnimationByPrefix('badMario','jump','jump',12,false)
    addAnimationByPrefix('badMario','fall','fall',12,false)
    addAnimationByPrefix('badMario','spin','mario spin jump',18,true)
    addAnimationByPrefix('badMario','peace','peace',0,false)
    setProperty('badMario.antialiasing',false)
    scaleObject('badMario',4,4)
    updateHitbox('badMario')
    playAnim('badMario','idle',true)
    addLuaSprite('badMario',true)

    makeAnimatedLuaSprite('badFlash','mario/BadMario/HUD_Mario_Blue',getProperty('boyfriend.x')-270,getProperty('boyfriend.y') + 70)
    addAnimationByPrefix('badFlash','anim','dust cloud',12,false)
    setProperty('badFlash.antialiasing',false)
    scaleObject('badFlash',6,6)
    updateHitbox('badFlash')
    playAnim('badFlash','idle',true)
    setProperty('badFlash.alpha',0.001)
    addLuaSprite('badFlash',true)
end
function onGameOver()
    local gameOverState = 'substates.GameOverSubstate'
    if version <= '0.6.3' then
        gameOverState = 'GameOverSubstate'
    end
    setPropertyFromClass(gameOverState,'characterName','bfbaddeath')
    setPropertyFromClass(gameOverState,'deathSoundName','fnf_loss_sfx2')
end
function onGameOverConfirm()
    enableKick = false
end
function onUpdate()
    if inGameOver then
        if getProperty('boyfriend.animation.curAnim.curFrame') >= 13 and state ~= 4 then
            setProperty('boyfriend.animation.curAnim.curFrame',13)
            if not started then
                doTweenX('marioX','badMario',getProperty('badMario.x')+100,0.6,'linear')
                playAnim('badMario','walk')
                started = true
            end
        end
    end
end
function onDestroy()
    cancelTween('marioX')
    cancelTween('marioJump')
    cancelTween('marioFall')
end
function doMarioShell()
    setProperty('badFlash.alpha',1)
    setProperty('badFlash.x',getProperty('badMario.x')+70)
    setProperty('badFlash.y',getProperty('badMario.y')+130)
    playAnim('badFlash','anim',true)
    playSound('bad-day/smw_shell_kick')
end
function onTweenCompleted(tag)
    if inGameOver then
        if tag == 'marioX' and state == 0 then
            doTweenX('marioX','badMario',getProperty('badMario.x')+650,2,'linear')
            doTweenY('marioJump','badMario',getProperty('badMario.y')-100,0.25,'quadOut')
            playSound('bad-day/smw_spinjump')
            playAnim('badMario','spin')
            state = 1
            
        elseif tag == 'marioJump' then
            if state == 1 then
                doTweenY('marioFall','badMario',getProperty('badMario.y')+150,0.35,'quadIn')
            elseif state == 2 then
                doTweenY('marioFall','badMario',getProperty('badMario.y')+180,0.35,'quadIn')
            elseif state == 3 then
                doTweenY('marioFall','badMario',getProperty('badMario.y')+240,0.5,'quadIn')
            end
            
        elseif tag == 'marioFall' then
            if state == 1 then
 
                playSound('bad-day/fnf_loss_sfx3',0.4)
                playAnim('boyfriend','secondDeath')
                doTweenY('marioJump','badMario',getProperty('badMario.y')-100,0.25,'quadOut')
                doMarioShell()
                state = 2
            elseif state == 2 then
                playAnim('boyfriend','thirdDeath')
                doTweenY('marioJump','badMario',getProperty('badMario.y')-100,0.25,'quadOut')
                state = 3
                
                doMarioShell()
            elseif state == 3 then
                playAnim('badMario','idle')
                runTimer('marioHey',0.5)
                state = 4
            end
            
        end
    end
end
function onTimerCompleted(tag)
    if tag == 'marioHey' then
        playAnim('badMario','peace')
        playSound('bad-day/line'..getRandomInt(1,4))
        runTimer('marioWalk',1.2)
        
    elseif tag == 'marioWalk' then
        doTweenX('marioX','badMario',getProperty('badMario.x')+600,3,'linear')
        playAnim('badMario','walk')
        playAnim('boyfriend','firstDeath')
        setProperty('boyfriend.animation.curAnim.curFrame',30)
    end
end