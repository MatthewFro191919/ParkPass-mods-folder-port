local canFakeMenu = true
local canMoveMenu = false
local songStarted = false
local songStarted = false
-- Variables para navegación
local menuItems = {"Story","Credits", "Options"}
local selectedIndex = 1
local buttonSprites = {} -- Lista para almacenar los sprites individuales
local soulSprite -- Sprite animado del corazón
local nav = false
local story = false
local credits = false

function onMainMenu()
fakeMenu = true
canFakeMenu = false 
nav = true
doTweenAlpha('h','negro', 0, 0.5, 'linear')
    updateSelection()
end
    
function onCreate()
    -- Fondo del menú
    makeAnimatedLuaSprite('menuBG','bg')
            addAnimationByPrefix('menuBG', 'idle', 'bg0', 18, true);
            setObjectCamera('menuBG','Other')
        addLuaSprite('menuBG', false)
        
            -- Crear sprites animados para cada opción del menú
    local startY = -35 -- Posición inicial Y para los botones

setProperty('skipCountdown', true)
   end

function onSongStart()
	songStarted = true
	canFakeMenu = true
	nav = false
	playSound('freakyMenu', 1, 'freakyMenu')
	return Function_Stop
end

-- ====== INTRO ======
function onCreatePost()
nav = false
luaDebugMode = true


makeLuaText('play', 'Play', 1300, 0, 150)
	setTextAlignment('play', 'Center')
	
	setTextSize('play', 100)
	setTextFont('play', 'lefont.ttf')
    setObjectCamera('play', 'other')
    
    
    makeLuaText('op', 'Options', 1300, 0, 350)
	setTextAlignment('op', 'Center')
	
	setTextSize('op', 100)
	setTextFont('op', 'lefont.ttf')
    setObjectCamera('op', 'other')
    
        
        makeLuaText('creditoss', 'Credits', 1300, 0, 550)
	setTextAlignment('creditoss', 'Center')
	
	setTextSize('creditoss', 100)
	setTextFont('creditoss', 'lefont.ttf')
    setObjectCamera('creditoss', 'other')
    addLuaText('creditoss')
addLuaText('play')
addLuaText('op')
    
makeLuaSprite('Black', nil)
makeGraphic('Black', screenWidth,  screenHeight, '000000')
setObjectCamera('Black','Other')
addLuaSprite('Black', true)


makeAnimatedLuaSprite('Logo','logoBumpin', 0, 0)
            addAnimationByPrefix('Logo', 'bump', 'logo bumpin', 24, true);
            setObjectCamera('Logo','Other')
            screenCenter('Logo','x')
        addLuaSprite('Logo', true)
        
        
        setProperty('camGame.visible', false)
        setProperty('camHUD.visible', false)
-- ====== MENÚ PRINCIPAL ======
    makeLuaSprite('menuBG','asbelinUI/mainMenu')
    scaleObject('menuBG', 2, 2)
            
            setObjectCamera('menuBG','Other')
        addLuaSprite('menuBG', false)
        
        
        
        for i, name in ipairs(menuItems) do
        local spriteName = name:gsub(" ", "_"):lower()
        local button = 'button_' .. spriteName
        makeAnimatedLuaSprite(button, 'start_screen')
        addAnimationByPrefix(button, 'idle', spriteName .. '0000', 24, false)
        addAnimationByPrefix(button, 'selected', spriteName .. 'Anim', 24, true)
        setObjectCamera(button,'Other')
        addLuaSprite(button, false)
        setProperty(button..'.alpha', 0)

        -- Guardar botón en la lista
        table.insert(buttonSprites, button)
    end
    
    
     -- Sprite animado del corazón
    makeLuaSprite('soul', 'asbelinUI/s', 340, 140) -- Inicialmente fuera de pantalla
    
    setScrollFactor('soul', 0, 0)
    setObjectCamera('soul','Other')
    scaleObject('soul', 2, 2) -- Ajusta el tamaño del corazón
    addLuaSprite('soul', false)
    
    setProperty('storyMode.alpha', 0)
       setProperty('soul.alpha', 0)
		setProperty('menuBG.alpha', 0)
		setProperty('storyBG.alpha', 0)
		
		makeAnimatedLuaSprite('Accept', 'botones/Accept', 0, 582.5);
	addAnimationByPrefix('Accept', 'nonPress', 'nonPress', 24, false);
	addAnimationByPrefix('Accept', 'Pressed', 'Pressed', 12, false);
	addLuaSprite('Accept', true);
	setObjectCamera('Accept', 'other');
	
	makeLuaSprite('negro', nil)
makeGraphic('negro', screenWidth,  screenHeight, '000000')
setObjectCamera('negro','Other')
addLuaSprite('negro', true)
setProperty('negro.alpha', 0)
	end

-- ====== MANEJO DE EVENTOS ======
function onUpdatePost()
	if getPropertyFromClass('states.PlayState', 'chartingMode') == false then
if (getMouseX('camHUD') > 0 and getMouseX('camHUD') < 1500) and (getMouseY('camHUD') > 582.5 and getMouseY('camHUD') < 1200 and mouseClicked('left')) or keyJustPressed('accept') and fakeMenu == false and canFakeMenu == true then
doTweenAlpha('Logo','Logo', 0, 0.5, 'linear')
doTweenAlpha('Accept','Accept', 0, 0.5, 'linear')


runTimer('intro', 0.8)
end
if keyJustPressed('right') and story == true then

doTweenY('startsoul', 'soulStart', -1000, 1, 'quadIn')
onStartStory()
	end
end

function onUpdate()
    -- Navegación con flechas arriba y abajo
    if keyJustPressed('up') and nav == true then
        selectedIndex = selectedIndex - 1
        if selectedIndex < 1 then
            selectedIndex = #menuItems
        end
        updateSelection()
    elseif keyJustPressed('down') and nav == true then
        selectedIndex = selectedIndex + 1
        if selectedIndex > #menuItems then
            selectedIndex = 1
        end
        updateSelection()
    end

    -- Confirmar selección con Right
    if keyJustPressed('right') and nav == true then
        handleSelection()
    end
       if keyJustPressed('left') and credits == true then
       doTweenAlpha('h','negro', 1, 0.5, 'linear')
       runTimer('back', 0.5)
       elseif keyJustPressed('left') and story == true then
       doTweenAlpha('h','negro', 1, 0.5, 'linear')
       runTimer('back1', 0.5)
    end
    end
end

-- Función para actualizar el estado visual del botón seleccionado
function updateSelection()
    for i, button in ipairs(buttonSprites) do
        if i == selectedIndex then
            playAnim(button, 'selected', false) -- Animación seleccionada
        else
            playAnim(button, 'idle', false) -- Animación en reposo
        end
    end

        -- Mover el corazón al botón seleccionado

    if menuItems[selectedIndex] == "Story" then
    doTweenY('eldelostamales','soul',140, 0.5,'quadIn')


elseif menuItems[selectedIndex] == "Freeplay" then
        setProperty('soul.y', screenWidth / 2 - 500)
    elseif menuItems[selectedIndex] == "Options" then
        doTweenY('eldelostamales','soul',340, 0.5 ,'quadIn')


    elseif menuItems[selectedIndex] == "Credits" then
        doTweenY('eldelostamales','soul',540, 0.5 ,'quadIn')

    end
    
end
    
function onStoryMode()
nav = false
doTweenAlpha('h','negro', 1, 0.5, 'linear')
runTimer('StoryMode', 0.5)
end
-- Función para manejar la acción según la selección
function handleSelection()
    if menuItems[selectedIndex] == "Story" then
    loadSong('parkpass')
    elseif menuItems[selectedIndex] == "Freeplay" then
    loadSong('Freeplay')
    elseif menuItems[selectedIndex] == "Options" then
    runHaxeCode([[
        import backend.MusicBeatState;
        import options.OptionsState;
        var pauseMusic = new flixel.sound.FlxSound();
        try {
            var pauseSong:String = getPauseSong();
            if(pauseSong != null) pauseMusic.loadEmbedded(Paths.music(pauseSong), true, true);
        }
        catch(e:Dynamic) {}
        pauseMusic.volume = 0;
        pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));
        MusicBeatState.switchState(new options.OptionsState());
            if(ClientPrefs.data.pauseMusic != 'None')
            {
                FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)),pauseMusic.volume);
                FlxTween.tween(FlxG.sound.music,{volume: 1}, 0.8);
                FlxG.sound.music.time = pauseMusic.time;
            }
            OptionsState.onPlayState = true;
    ]])
    elseif menuItems[selectedIndex] == "Credits" then
    loadSong('credits')
    end
end

function onCredits()
credits = true
nav = false

makeLuaSprite('credits', 'credits/credits')
setObjectCamera('credits','Other')
scaleObject('credits', 1, 1)
addLuaSprite('credits', false)
setProperty('soul.visible', false)
end

function onStartStory()
doTweenAlpha('h','negro', 1, 1, 'linear')
runTimer('Start', 1.4)
end

function onTimerCompleted(tag)
if tag == 'back' then
nav = true
credits = false
setProperty('soul.visible', true)
setProperty('credits.visible', false)
runTimer('byebyebye', 0.5)
end
if tag == 'back1' then
nav = true
story = false
setProperty('storyMode.alpha', 0)
setProperty('arrow left.alpha', 0)
setProperty('arrow right.alpha', 0)
setProperty('mad_time.alpha', 0)
setProperty('mode.alpha', 0)
setProperty('soulStart.alpha', 0)
setProperty('soul.visible', true)
runTimer('byebyebye', 0.5)
end
if tag == 'byebyebye' then
onMainMenu()
end
if tag == 'credits' then
doTweenAlpha('h','negro', 0, 0.5, 'linear')
onCredits()
end
if tag == 'StoryMode' then
makeAnimatedLuaSprite('arrow right', 'Arrow', 850, 450) -- Inicialmente fuera de pantalla
    addAnimationByPrefix('arrow right', 'right', 'arrow rightarrow', 24, false)
    setScrollFactor('arrow right', 0, 0)
    setObjectCamera('arrow right','Other')
    scaleObject('arrow right', 1, 1) -- Ajusta el tamaño del corazón
    addLuaSprite('arrow right', true)
    
    makeAnimatedLuaSprite('arrow left', 'Arrow', 400, 450) -- Inicialmente fuera de pantalla
    addAnimationByPrefix('arrow left', 'left', 'arrow leftarrow', 24, false)
    setScrollFactor('arrow left', 0, 0)
    setObjectCamera('arrow left','Other')
    scaleObject('arrow left', 1, 1) -- Ajusta el tamaño del corazón
    addLuaSprite('arrow left', true)
    
    makeAnimatedLuaSprite('mad_time', 'mad_time', 350, 50) -- Inicialmente fuera de pantalla
    addAnimationByPrefix('mad_time', 'idle', 'title0', 24, true)
    setScrollFactor('mad_time', 0, 0)
    setObjectCamera('mad_time','Other')
    scaleObject('mad_time', 0.8, 0.8) -- Ajusta el tamaño del corazón
    addLuaSprite('mad_time', true)
    
    makeAnimatedLuaSprite('mode', 'story_mode', 200, 200) -- Inicialmente fuera de pantalla
    addAnimationByPrefix('mode', 'mad0000', 'hard', 24, true)
    setScrollFactor('mode', 0, 0)
    setObjectCamera('mode','Other')
    scaleObject('mode', 0.8, 0.8) -- Ajusta el tamaño del corazón
    addLuaSprite('mode', true)
    
    makeAnimatedLuaSprite('soulStart', 'start_soul', -200, 150) -- Inicialmente fuera de pantalla
    addAnimationByPrefix('soulStart', 'idle', 'soul', 24, true)
    setScrollFactor('soulStart', 0, 0)
    setObjectCamera('soulStart','Other')
    scaleObject('soulStart', 1, 1) -- Ajusta el tamaño del corazón
    addLuaSprite('soulStart', true)
    
setProperty('storyMode.alpha', 1)
setProperty('soul.visible', false)
doTweenAlpha('h','negro', 0, 1, 'linear')
story = true
end
if tag == 'intro' then
setProperty('soul.alpha', 1)
		setProperty('menuBG.alpha', 1)
		setProperty('storyBG.alpha', 1)
doTweenAlpha('black','Black', 0, 0.5, 'linear')
onMainMenu()    
end
if tag == 'Start' then
setProperty('storyMode.alpha', 0)
setProperty('arrow left.alpha', 0)
setProperty('arrow right.alpha', 0)
setProperty('mad_time.alpha', 0)
setProperty('mode.alpha', 0)
startVideo('themurderer')
pauseSound('MenuSong')
runTimer('Song', 112)
end
if tag == 'Song' then
loadSong('the-murderer', difficulty)
	end
end