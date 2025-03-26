

local lastRating = ''
function onCreate()
    createTvText('TvData','DEC. 22 1996',50,screenHeight-80,'left')
    if songName == 'The End' then
        setTextString('TvData','SEP. 02 97')
    end
    createTvText('RightScoreTxt','',screenWidth/2 - 50,screenHeight-140,'right')
end
function createTvText(tag,text,x,y,alignment)
    if not luaTextExists(tag) then
        makeLuaText(tag,text,screenWidth/2,x,y)
        setTextSize(tag,70)
        addLuaText(tag,false)
        setTextBorder(tag,0,'FFFFFF')
        setTextAlignment(tag,alignment)
    else
        setTextString(tag,text)
    end
end
function goodNoteHit(id,data,type,sus)
    if not sus then
        local rating = ''
        local strumTime = math.abs(getPropertyFromGroup('notes',id,'strumTime') - getSongPosition())
        if version <= '0.6.3' then
            if strumTime < getPropertyFromClass('ClientPrefs','sickWindow') then
                rating = 'SICK'
            elseif strumTime < getPropertyFromClass('ClientPrefs','goodWindow')  then
                rating = 'GOOD'
            elseif strumTime < getPropertyFromClass('ClientPrefs','badWindow')  then
                rating = 'BAD'
            else
                rating = 'SHIT'
            end
        else
            if strumTime < getPropertyFromClass('backend.ClientPrefs','data.sickWindow') then
                rating = 'SICK'
            elseif strumTime < getPropertyFromClass('backend.ClientPrefs','data.goodWindow')  then
                rating = 'GOOD'
            elseif strumTime < getPropertyFromClass('backend.ClientPrefs','data.badWindow')  then
                rating = 'BAD'
            else
                rating = 'SHIT'
            end
        end
        createTvText('TvCombo',rating..'\n'..getProperty('combo'),50,screenHeight/2,'left')
        runTimer('removeTVCombo',2)
    end
end
function onTimerCompleted(tag)
    if tag == 'removeTVCombo' then
        removeLuaText('TvCombo',true)
    end
end
function onCreatePost()
    setProperty('iconP1.visible',false)
    setProperty('iconP2.visible',false)
    setProperty('healthBar.visible',false)
    setProperty('timeBar.visible',false)
    setProperty('timeTxt.visible',false)
    setProperty('timeBar.visible',false)
    setProperty('scoreTxt.visible',false)
    if version <= '0.6.3' then
        setProperty('healthBarBG.visible',false)
        setProperty('timeBarBG.visible',false)
    end
end
function onUpdate()
    setTextString('RightScoreTxt','H: '..tostring(math.floor(math.min(2,getHealth())*100))..'\nS: '..tostring(getProperty('songScore')))
end
