local setted = false
function onGameOver()
    if not setted then
        setProperty('generatedMusic',false)
        doTweenAlpha('hudAlpha','camHUD',0,1,'cubeIn')
        playAnim('boyfriend','firstDeath',true)
        setProperty('boyfriend.specialAnim',true)
        setProperty('boyfriend.heyTimer',50)
        runTimer('bowserHohoho',2)

        callScript('scripts/cameraMoviment','setCamPos',{'bfX','bfY'})
        runHaxeCode(
            [[
                FlxG.sound.music.volume = 0;
                game.vocals.volume = 0;
                return;
            ]]
        )
        setted = true
    end
    return Function_Stop;
end
function onTimerCompleted(tag)
    if tag == 'bowserHohoho' then
        makeLuaSprite('bowserDeath','modstuff/gameovers/lisreal_bowserlogo',0,0)
        setObjectCamera('bowserDeath','other')
        scaleObject('bowserDeath',6,6)
        screenCenter('bowserDeath')
        doTweenAlpha('gameAlpha','camGame',0,2,'expoIn')
        doTweenX('bowserX','bowserDeath.scale',0.4,2,'cubeIn')
        doTweenY('bowserY','bowserDeath.scale',0.4,2,'cubeIn')
        playMusic('bowlaugh')
        addLuaSprite('bowserDeath',true)
    end
end
function onTweenCompleted(tag)
    if tag == 'bowserX' then
        setProperty('camGame.visible',false)
        loadSong(songName,difficulty)
    end
end