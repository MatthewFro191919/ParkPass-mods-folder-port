local bfGameOver = ''
local substate = 'substates.GameOverSubstate'
function onCreate()
    if version <= '0.6.3' then
        substate = 'GameOverSubstate'
    end
end
function onUpdate()
    if curSection <= 67 then
        if gfSection == true then
            bfGameOver = 'gfASdeath'
            setPropertyFromClass(substate,'characterName','gfASdeath')
        else
            if bfGameOver ~= 'bfASdeath' then
                bfGameOver = 'bfASdeath'
                setPropertyFromClass(substate,'characterName','bfASdeath')
            end
        end
    end
end
function onGameOver()
    setPropertyFromClass(substate,'characterName',bfGameOver)
end
function onSectionHit()
    if curSection == 67 then
        callScript('scripts/optimization','removeCharacterFromMemory',{'gfASdeath'})
    end
end