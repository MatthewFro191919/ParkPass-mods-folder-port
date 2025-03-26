local startVideo = false
function onCreate()
    addHaxeLibrary('MP4Handler','vlc')
end
function preloadVideo(path,startOnCountdown)
    runHaxeCode(
        [[
            var videoSprite = new MP4Handler();
            setVar('preloadedVideo',videoSprite);
            videoSprite.play(Paths.video("]]..path..[["));
            videoSprite.pause();
            return;
        ]]
    )
    startVideo = startOnCountdown == true
end
function onSongStart()
    if startVideo then
        runHaxeCode(
            [[
                if(getVar('preloadedVideo') != null){
                    getVar('preloadedVideo').resume();
                    //getVar('preloadedVideo').setTime(0);
                }
                return;
            ]]
        )
    end
end