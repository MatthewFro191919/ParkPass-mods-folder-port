local time = 0
local bpm = 100
local partyLine = 0
function onGameOverStart()

    partyLine = getRandomInt(1,6)
    precacheSound('piracy/line'..partyLine)
    for piracy = 0,3 do
        local name = 'noPartyBG'..piracy

        if piracy == 0 then
            makeLuaSprite(name,'mario/piracy/HallyBG4',0,getPropertyFromClass('flixel.FlxG','height')/2)
        elseif piracy == 1 then
            makeLuaSprite(name,'mario/piracy/HallyBG4',getProperty('noPartyBG0.x') + getProperty('noPartyBG0.width'),getProperty('noPartyBG0.y'))
        elseif piracy == 2 then
            makeLuaSprite(name,'mario/piracy/HallyBG4',getProperty('noPartyBG0.x'),getProperty('noPartyBG0.y') + getProperty('noPartyBG0.height'))
        elseif piracy == 3 then
            makeLuaSprite(name,'mario/piracy/HallyBG4',getProperty('noPartyBG0.x') + getProperty('noPartyBG0.width'),getProperty('noPartyBG0.y') + getProperty('noPartyBG0.height'))
        end
        setScrollFactor(name,0,0)
        scaleObject(name,1.2,1.2)
        setObjectCamera(name,'game')
        addLuaSprite(name,false)
        setProperty(name..'.velocity.x',-50)
        setProperty(name..'.velocity.y',-30)
        setProperty(name..'.color',getColorFromHex('808080'))

    end



    setProperty('boyfriend.visible',false)
    setProperty('boyfriend.animation.curAnim.frameRate',20)

    makeLuaSprite('prision','modstuff/gameovers/hallyboodeath',0,0)
    setScrollFactor('prision',0,0)
    setObjectCamera('prision','game')
    scaleObject('prision',0.3,0.3)
    addLuaSprite('prision',false)


    makeLuaSprite('noPartyText','modstuff/gameovers/hallyboodeath2',0,0)
    setObjectCamera('noPartyText','game')
    setScrollFactor('noPartyText',0,0)
    screenCenter('noPartyText','y')
    updateHitbox('noPartyText')
    setProperty('noPartyText.offset.x',0)
    setProperty('noPartyText.y',getProperty('noPartyText.y')+200)
    setProperty('noPartyText.antialiasing',false)
    addLuaSprite('noPartyText',false)

    runTimer('partyAppear',2)
    runTimer('partyLine',5)
    makeLuaSprite('blackFront',nil)
    makeGraphic('blackFront',screenWidth,screenHeight,'000000')
    setScrollFactor('blackFront',0,0)
    addLuaSprite('blackFront',true)
end
local beat = 0
function onUpdate(el)
    if inGameOver then
        time = time + el
        local cur = math.floor((bpm/60)*(time))
        if math.floor(cur) ~= beat then
            beat = cur
            partyBeat()
        end
        if getProperty('noPartyBG0.y') <= 15 then
            for piracy = 0,3 do
                setProperty('noPartyBG'..piracy..'.x',getProperty('noPartyBG'..piracy..'.x') + getProperty('noPartyBG'..piracy..'.width'))
                setProperty('noPartyBG'..piracy..'.y',getProperty('noPartyBG'..piracy..'.y') + getProperty('noPartyBG'..piracy..'.height'))
            end
        end
    end
end
function onGameOverConfirm()
    cancelTimer('partyAppear')
    cancelTimer('partyLine')
end
function onTimerCompleted(tag)
    if tag == 'partyAppear' then
        doTweenAlpha('black','blackFront',0,4)
    elseif tag == 'partyLine' then
        playSound('piracy/line'..partyLine)
    end
end
function partyBeat()
    setProperty('noPartyText.scale.x',1.05)
    setProperty('noPartyText.scale.y',1.05)
    doTweenX('partyX','noPartyText.scale',1,1,'cubeOut')
    doTweenY('partyY','noPartyText.scale',1,1,'cubeOut')
end
function onGameOver()
    local substate = 'substates.GameOverSubstate'
    if version <= '0.6.3' then
        substate = 'GameOverSubstate'
    end
    setPropertyFromClass(substate,'deathSoundName','hallyboostart')
    setPropertyFromClass(substate,'loopSoundName','hallyboogameover')
    setPropertyFromClass(substate,'endSoundName','hallybooretry')
end