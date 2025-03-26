local blackCam = 'camGame'
function onCreate()
    makeLuaSprite('blackThink',nil,-100,-100)
    makeGraphic('blackThink',screenWidth,screenHeight,'000000')
    setScrollFactor('blackThink',0,0)
    setProperty('blackThink.alpha',0.001)
    addLuaSprite('blackThink',true)
    setObjectOrder('blackThink',999)
end
function setBlackCam(cam)
    setObjectCamera('blackThink',cam)
    if cam == 'game' then
        blackCam = 'camGame'
    elseif cam == 'hud' then
        blackCam = 'camHUD'
    elseif cam == 'other' then
        blackCam = 'camOther'
    end
end
function onUpdate()
    local scale = math.max(1,2 - (getProperty(blackCam..'.zoom')/2))
    setProperty('blackThink.x',-200*scale)
    setProperty('blackThink.y',-200*scale)
    scaleObject('blackThink',scale,scale)
end