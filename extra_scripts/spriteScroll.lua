local scrollImages = {}
function createScrollSprite(lua,image,x,y,ahead,scaleX,scaleY,camera)
    makeLuaSprite(lua,image)
    if x == nil then
        x = 0
    end
    if y == nil then
        y = 0
    end
    if camera ~= nil then
        setObjectCamera(lua,camera)
    else
        camera = 'camGame'
    end
    addLuaSprite(lua,ahead)
    setScrollFactor(lua,0,0)
    if scaleX == nil then
        scaleX = 1
    end
    if scaleY == nil then
        scaleY = 1
    end
    scrollImages[lua] = {camera,x,y,scaleX,scaleY}
    
end
function onUpdate()
    for lua, cam in pairs(scrollImages) do
        local scale = math.max(1,2 - (getProperty(cam[1]..'.zoom'))/2) - 1
        setProperty(lua..'.x',(-200 + cam[2])*scale)
        setProperty(lua..'.y',(-200+cam[3])*scale)
        scaleObject(lua,scale*2+cam[4],scale*2+cam[5])

    end
end
