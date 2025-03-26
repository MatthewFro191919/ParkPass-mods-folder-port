
function onSongStart()
doTweenAlpha('permfade','fade', 0, 3, 'cubeIn')

end

function onCreatePost()
    precacheImage('lyric/spritemap1')
    addCharacterToList("i'll",'dad')
end
function onSpawnNote()
    if not getProperty('notes.members[0].mustPress') then
        setObjectOrder('notes.members[0]', 3)
        

    else
        callMethod('add', {instanceArg('notes.members[0]')})
        setObjectCamera('notes.members[0]', 'hud')
    end
end


function onCreate()
	makeLuaSprite('fade', '', 0, 0);
	setObjectCamera('fade', 'hud');
	setProperty('fade.scale.x',2)
	setProperty('fade.scale.y',2)
	setProperty('fade.alpha', 1)
	makeGraphic('fade', 1280, 720, '000000')
	addLuaSprite('fade', false);




setProperty('skipCountdown',true)
setObjectOrder('AA',1)


    setObjectOrder('dadGroup',300)
    setObjectOrder('intro',301)
    
    setObjectOrder('bfhurt',301)
    setObjectOrder('swipe',301)
    
    setObjectOrder('tele',301)
    
    
    
    setObjectOrder('A2',301)
    
    
    setObjectOrder('A1',302)
    
    setObjectOrder('A3',303)
    
    setObjectOrder('A4',304)
    
    setObjectOrder('AA4',305)
    
    setObjectOrder('AAA4',306)
end



function onUpdate()
    if dadName== "i'll" then
    
        setProperty('dad.x',1630)
        setObjectOrder('boyfriendGroup',getObjectOrder('dadGroup')+2)
        setProperty('dad.y',1150)
    end
end
