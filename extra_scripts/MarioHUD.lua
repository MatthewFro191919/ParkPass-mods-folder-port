
local timeStyle = ''
function onCreate()
    if curStage == 'hatebg' or curStage == 'forest' then
        timeStyle = 'world'
    end
end
function onCreatePost()
    if timeStyle == 'world' then
        makeLuaText('timeTxtWorld','TIME',screenWidth,0,15)
        setObjectCamera('timeTxtWorld','hud')
        setProperty('timeTxtWorld.antialiasing',false)
        setTextFont('timeTxtWorld','super-mario-bros-nes.ttf')
        addLuaText('timeTxtWorld',false)
        setProperty('timeTxtWorld.color',getColorFromHex('F0D88D'))
        setTextSize('timeTxtWorld',24)
        setProperty('timeTxt.visible',false)
        setProperty('timeBar.visible',false)
        
    end

    if curStage ~= 'piracy' then
        setTextFont('timeTxt','super-mario-bros-nes.ttf')
        setTextSize('timeTxt',17)

        setTextFont('scoreTxt','super-mario-bros-nes.ttf')
        setTextSize('scoreTxt',15)
    end


    if curStage ~= 'landstage' and curStage ~= 'piracy' then
        setProperty('scoreTxt.color',getColorFromHex('FF0000'))
        setProperty('timeTxt.color',getColorFromHex('FF0000'))
        if version >= '0.7' then
            setProperty('timeBar.leftBar.color',getColorFromHex('FF0000'))
        else
            setProperty('timeBar.color',getColorFromHex('FF0000'))

        end
        
    end
    local healthImage = 'healthBarNEW'
    local barAntialiasing = true
    if curStage == 'landstage' then
        healthImage = 'GBhealthBarNEW'
        barAntialiasing = false
    end
    if version >= '0.7' then
        runHaxeCode(
            [[
                game.healthBar.bg.loadGraphic(Paths.image(']]..healthImage..[['));
                game.healthBar.bg.antialiasing = ]]..tostring(barAntialiasing)..[[;
                game.healthBar.bg.offset.set(45,5);
                return;
            ]]
        )
    else
        runHaxeCode(
            [[
                game.healthBarBG.loadGraphic(Paths.image("]]..healthImage..[["));
                game.healthBarBG.offset.set(50,6);
                game.remove(game.healthBarBG);
                game.insert(game.members.indexOf(game.healthBar)+1,game.healthBarBG);
                game.healthBarBG.antialiasing = ]]..tostring(barAntialiasing)..[[;
                return;
            ]]
        )
    end
end
function onUpdateScore()
    local rating = "RATING: "
    local percent = getProperty('ratingPercent')
    if  percent > 0 then
        if percent >= 1 then
            rating = 'RATING: SS+'
        elseif percent > 0.95 then
            rating = 'RATING: S+'
        elseif percent > 0.90 then
            rating = 'RATING: S'
        elseif percent > 0.85 then
            rating = 'RATING: A+'
        elseif percent > 0.80 then
            rating = 'RATING: A'
        elseif percent > 0.70 then
            rating = 'RATING: B'
        elseif percent > 0.60 then
            rating = 'RATING: C'
        elseif percent > 0.50 then
            rating = 'RATING: D'
        elseif percent > 0.30 then
            rating = 'RATING: E'
        else
            rating = 'RATING: F'
        end
        rating = rating.."("..(math.floor(getProperty('ratingPercent') * 10000)/100)..'%)'
    else
        rating = rating..'?'
    end
    if curStage ~= 'piracy' then
        setTextString('scoreTxt','SCORE: '..getProperty('songScore')..'    MISSES: '..getProperty('songMisses')..'    '..rating)
    else
        setTextString('scoreTxt','SCORE: '..getProperty('songScore')..'  MISSES: '..getProperty('songMisses')..'  '..rating)
    end
end
function onUpdate()
    if timeStyle == 'world' then
        setTextString('timeTxtWorld','TIME\n'..tostring(math.floor((getProperty('songLength') - getSongPosition())/1000)))
    end
end