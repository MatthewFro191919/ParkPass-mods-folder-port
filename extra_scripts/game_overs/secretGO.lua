local allowEnd = false
function onGameOverStart()
    runTimer('oldFriend',4.5)
    
end
function onUpdate()
    if inGameOver and not allowEnd and getProperty('boyfriend.animation.curAnim.curFrame') >= 12 then
        setProperty('boyfriend.animation.curAnim.curFrame',12)
    end
end
function onGameOverConfirm()
    cancelTimer('playSecretMusic')
    cancelTimer('oldFriend')
end
function onTimerCompleted(tag)
    if tag == 'oldFriend' then
        playAnim('boyfriend','secondDeath',true)
        playSound('SHbullethit')
        allowEnd = true
        runTimer('playSecretMusic',2)
    elseif tag == 'playSecretMusic' then
        playMusic('SHgameover')
    end
end