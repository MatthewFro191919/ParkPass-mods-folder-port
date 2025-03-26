local state = -1
function onUpdatePost()
    if inGameOver and state ~= -1 then
        if state == 0 then
            if getProperty('boyfriend.animation.curAnim.name') == 'deathLoop' then
                setProperty('boyfriend.alpha',false)
                runTimer('goombaGameOver',2)
                runHaxeCode(
                    [[
                        FlxG.sound.music.stop();
                        return;
                    ]]
                )
                state = 1
            end
        end
    end
end
function onGameOver()
    local substate = 'substates.GameOverSubstate'
    if version <= '0.6.3' then
        substate = 'GameOverSubstate'
    end
    if getProperty('boyfriend.curCharacter') == 'bf-goomba' then
        setPropertyFromClass(substate,'characterName','bf-goomba')
        setPropertyFromClass(substate,'deathSoundName','turmoil_death1')
        setPropertyFromClass(substate,'loopSoundName','gameOverNew')
        setPropertyFromClass(substate,'endSoundName','gameOverEndNew')
        state = 0
    end
end
function onTimerCompleted(tag)
    if tag == 'goombaGameOver' then
        setScrollFactor('boyfriend',0,0)
        screenCenter('boyfriend')
        setProperty('boyfriend.y',getProperty('boyfriend.y')+100)
        doTweenAlpha('bfAlpha','boyfriend',1,3,'cubeOut')
        runHaxeCode(
            [[
                FlxG.sound.playMusic(Paths.music('gameOverNew'),1);
                FlxG.sound.music.fadeIn(2,0,1);
                return;
            ]]
        )
    end
end