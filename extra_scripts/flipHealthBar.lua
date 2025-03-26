local flipHPBar = false
function setFlip(flip)
    setProperty('iconP1.flipX',flip)
    setProperty('iconP2.flipX',flip)
    setProperty('healthBar.flipX',flip)
    flipHPBar = flip
end
function onUpdatePost()
    if flipHPBar then
        local health = math.min(1,getHealth()/2)
        local healtPos = 0
        if version > '0.6.3' then
            healtPos = getProperty('healthBar.x') + ((getProperty('healthBar.bg.width')-95)*health)
        else
            healtPos = getProperty('healthBar.x') + ((getProperty('healthBarBG.width')-95)*health)
        end
        setProperty('iconP1.x',healtPos - 120 - (50*(getProperty('iconP1.scale.x')- 1)))
        setProperty('iconP2.x',healtPos - 30 + (50*(getProperty('iconP1.scale.x')-1)))
    end
end