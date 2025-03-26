local shaderName = "vcr-with-glitch"
function onCreate()
    shaderCoordFix()
    makeLuaSprite("vcr-with-glitch")
    makeGraphic("shaderImage", screenWidth, screenHeight)

   setSpriteShader("shaderImage", "vcr-with-glitch")
    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        
        game.initLuaShader(shaderName);
        
        var shader0 = game.createRuntimeShader(shaderName);
        game.camGame.setFilters([new ShaderFilter(shader0)]);
        game.getLuaObject("vcr-with-glitch").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
        game.camOther.setFilters([new ShaderFilter(game.getLuaObject("vcr-with-glitch").shader)]);
        return;
    ]])
end
function onUpdate(elapsed)
    setShaderFloat("vcr-with-glitch", "iTime", os.clock())
 end
function shaderCoordFix()
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData = null;
        }
        
        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }
    
        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
        return;
    ]])
    
    local temp = onDestroy
    function onDestroy()
        runHaxeCode([[
            FlxG.signals.gameResized.remove(fixShaderCoordFix);
            return;
        ]])
        if (temp) then temp() end
    end
end