local images = {
    {name = "herobrine_mod_mauriwaka", text = "Main Musician/Director/Charter", nameTxt = "MauriWaka"},
    
    {name = "herobrine_mod_tinny", text = "Musician", nameTxt = "_Tinny_"},
    
    {name = "herobrine_mod_bonettegmc", text = "Main Artist/Coder", nameTxt = "b0nette"},
    
    {name = "herobrine_mod_srwhite", text = "Cutscene animation help", nameTxt = "srwhiterealXD"},
    
    {name = "herobrine_mod_maximo", text = "Song Events n stuff", nameTxt = "MáximoS3ga"},
    
    {name = "herobrine_mod_goma", text = "Coder", nameTxt = "Fnaf_Gumball"},
    
    {name = "herobrine_mod_manuhx", text = "Music Help", nameTxt = "ManuHx"},
    
    {name = "herobrine_mod_gilberto", text = "Porteador", nameTxt = "GilbertoTheCreator"},
    
    
}

local currentIndex = 1
local startX = 335
local startY = 130
local spacing = -70
local moving = false
local credits = true


function onSongStart()

playSound('freakyMenu', 1, 'freakyMenu')
end

function onCreate()
setProperty('skipCountdown', true)

makeLuaSprite('sooul', 'asbelinUI/s', 340, 70) -- Inicialmente fuera de pantalla
    
    setScrollFactor('sooul', 0, 0)
    setObjectCamera('sooul','Other')
    scaleObject('sooul', 2, 1.4) -- Ajusta el tamaño del corazón
    addLuaSprite('sooul', true)
    setProperty('camGame.visible' , false)
    setProperty('camHUD.visible' , false)
    
    
--       ================ CREDITOS PTM ================
    makeLuaSprite('bg', 'credits/creditsMenu', 0, 0)
    scaleObject('bg', 2, 2)
    setObjectCamera('bg', 'other')
    setProperty('bg.alpha', 1)
    addLuaSprite('bg', true)
    
    makeLuaText('jospi', 'Jospi', 1300, 0, 80)
	setTextAlignment('jospi', 'Center')
	addLuaText('jospi')
	setTextSize('jospi', 70)
	setTextFont('jospi', 'lefont.ttf')
    setObjectCamera('jospi', 'other')
    
    makeLuaText('si', 'Coquers', 1300, 0, 150)
	setTextAlignment('si', 'Center')
	addLuaText('si')
	setTextSize('si', 70)
	setTextFont('si', 'lefont.ttf')
    setObjectCamera('si', 'other')
    
    
    makeLuaText('sii', 'MKVB', 1300, 0, 220)
	setTextAlignment('sii', 'Center')
	addLuaText('sii')
	setTextSize('sii', 70)
	setTextFont('sii', 'lefont.ttf')
    setObjectCamera('sii', 'other')
    
    makeLuaText('siii', 'GIGABOOTS', 1300, 0, 290)
	setTextAlignment('siii', 'Center')
	addLuaText('siii')
	setTextSize('siii', 70)
	setTextFont('siii', 'lefont.ttf')
    setObjectCamera('siii', 'other')
    
    makeLuaText('siiii', 'Sirekirb', 1300, 0, 360)
	setTextAlignment('siiii', 'Center')
	addLuaText('siiii')
	setTextSize('siiii', 70)
	setTextFont('siiii', 'lefont.ttf')
    setObjectCamera('siiii', 'other')
    
    
    makeLuaText('siiiii', 'Shadowfi', 1300, 0, 430)
	setTextAlignment('siiiii', 'Center')
	addLuaText('siiiii')
	setTextSize('siiiii', 70)
	setTextFont('siiiii', 'lefont.ttf')
    setObjectCamera('siiiii', 'other')
    
    makeLuaText('ssiiiii', 'Special Thanks:', 500, 0, 500)
	setTextAlignment('ssiiiii', 'Center')
	addLuaText('ssiiiii')
	setTextSize('ssiiiii', 70)
	setTextFont('ssiiiii', 'lefont.ttf')
    setObjectCamera('ssiiiii', 'other')
    
    makeLuaText('sssiiiii', 'Benlands', 1300, 0, 500)
	setTextAlignment('sssiiiii', 'Center')
	addLuaText('sssiiiii')
	setTextSize('sssiiiii', 70)
	setTextFont('sssiiiii', 'lefont.ttf')
    setObjectCamera('sssiiiii', 'other')
    
    
    makeLuaSprite('soul', 'asbelinUI/s', 190, 640) -- Inicialmente fuera de pantalla
    
    setScrollFactor('soul', 0, 0)
    setObjectCamera('soul','Other')
    scaleObject('soul', 3, 2) -- Ajusta el tamaño del corazón
    addLuaSprite('soul', false)
    
    
    makeLuaText('ssssiiiii', 'LiterallyAsbelin', 1300, 0, 573)
	setTextAlignment('ssssiiiii', 'Center')
	addLuaText('ssssiiiii')
	setTextSize('ssssiiiii', 70)
	setTextFont('ssssiiiii', 'lefont.ttf')
    setObjectCamera('ssssiiiii', 'other')
    
    
    

    for i, img in ipairs(images) do
        makeLuaSprite(img.name, 'credits/ocs/' .. img.name, startX + (i - 1) * spacing, startY)
        setObjectCamera(img.name, 'other')
        addLuaSprite(img.name)
        setProperty(img.name..'.alpha', 0)
    end

    makeLuaSprite('page', 'credits/page', 50, 150)
    setObjectCamera('page', 'other')
    setProperty('page.alpha', 0)
    scaleObject('page', 1.35, 1.35)
    addLuaSprite('page')

    setProperty('camGame.visible', false)
        setProperty('camHUD.visible', false)
    makeLuaText('nameText', images[currentIndex].nameTxt, 600, -80, 210)
    setTextAlignment('nameText', 'center')
    setObjectCamera('nameText', 'other')
    setTextFont('nameText', 'lefont.ttf')
    addLuaText('nameText')
    setTextColor('nameText', '000000')
    setTextBorder('nameText', 0, '000000')
    setTextSize('nameText', 60)
    setProperty('nameText.alpha', 1)

    makeLuaText('imageText', images[currentIndex].text, 1350, 0, 650)
    setTextAlignment('imageText', 'center')
    setObjectCamera('imageText', 'other')
    setTextFont('imageText', 'lefont.ttf')
    addLuaText('imageText')
    
    
    setTextSize('imageText', 60)
    setProperty('imageText.alpha', 1)

    
    
    makeLuaSprite('ST', 'credits/SpecialThanks', 0, 0)
    setObjectCamera('ST', 'other')
    addLuaSprite('ST')
    setProperty('ST.alpha', 0)
end

function onUpdate()
--       ================ CODIGO CREDITS ================
    if credits then
    if not moving then
        if keyJustPressed('down') and currentIndex < #images then
            moving = true
            currentIndex = currentIndex + 1
            updatePositions(-spacing)
            updateText()
        end

        if keyJustPressed('up') and currentIndex > 1 then
            moving = true
            currentIndex = currentIndex - 1
            updatePositions(spacing)
            updateText()
        end
        
        if keyJustPressed('left') then
        
        loadSong('menu')
        end
    end

    if isMouseOverText('hoverText') then
        setTextColor('hoverText', 'FFFFFF')
        if mouseClicked('left') then
            onHoverTextClick()
        end
    else
        setTextColor('hoverText', '555555')
    end
    end
end

function updatePositions(offset)
    for i, img in ipairs(images) do
        local targetX = getProperty('sooul.y') + offset
        doTweenY('move' .. i, 'sooul', targetX, 0.3, 'linear')
    end
    runTimer('unlockMovement', 0.2)
end

function updateText()
    setTextString('imageText', images[currentIndex].text)
    setTextString('nameText', images[currentIndex].nameTxt)
end

function onTimerCompleted(tag)
    if tag == 'unlockMovement' then
        moving = false
    end
end

function onHoverTextClick()
setProperty('bg.alpha', 0)
for i, img in ipairs(images) do
setProperty(img.name .. '.alpha', 0)
end
setProperty('page.alpha', 0)
setProperty('cre.alpha', 0)
setProperty('nameTxt.alpha', 0)
setProperty('imageText.alpha', 0)
setProperty('hoverText.alpha', 0)
setProperty('ST.alpha', 0)
credits = false
end

function isMouseOverText(textName)
    local mouseX, mouseY = getMouseX('other'), getMouseY('other')
    local textX, textY = getProperty(textName .. '.x'), getProperty(textName .. '.y')
    local textWidth = getProperty(textName .. '.width')
    local textHeight = getProperty(textName .. '.height')

    return mouseX >= textX and mouseX <= textX + textWidth and mouseY >= textY and mouseY <= textY + textHeight
end