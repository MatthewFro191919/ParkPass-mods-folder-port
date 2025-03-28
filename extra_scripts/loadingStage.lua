local enableLoading = true
function startLoading(time)
    if not enableLoading then
        return
    end
    if time == nil then
        time = 0.1
    end
    runTimer('LoadedStage',time)
    runHaxeCode(
        [[
            game.generatedMusic = false;
            game.vocals.pause();
            FlxG.sound.music.pause();
            return;
        ]]
    )
end
function onStepHit()
    if enableLoading and (
        songName == 'All-Stars' and (curStep == 1071 or curStep == 2237 or curStep == 3503) or
        songName == 'Overdue' and (curStep == 1074)) then
        addLoadingText()
    end
end
function addLoadingText()
    makeLuaText('loadingTxt','Loading Stage, please wait.',screenWidth,0,0)
    setTextFont('loadingTxt','arial-rounded-mt-bold.ttf')
    setTextSize('loadingTxt',100)
    screenCenter('loadingTxt')
    setProperty('loadingTxt.alpha',0.5)
    setObjectCamera('loadingTxt','other')
    doTweenAlpha('loadingTxtAlpha','loadingTxt',0,0.5,'expoIn')
    addLuaText('loadingTxt',true)
end
function onTweenCompleted(tag)
    if tag == 'loadingTxtAlpha' then
        removeLuaText('loadingTxt',true)
    end
end
function onTimerCompleted(tag)
    if tag == 'LoadedStage' then
        runHaxeCode(
            [[
                FlxG.sound.music.play();
                game.vocals.play();
                game.generatedMusic = true;
                return;
            ]]
        )
    end
end