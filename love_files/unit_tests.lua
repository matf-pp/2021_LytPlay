require("utility")
require("button_events")
require("data")

function runTests()
    downloadSong("https://youtu.be/PduHaacGTqM")
    os.execute("sleep " .. tonumber(2))
    songToPlay = "music/Long After You Are Gone.mp3"
end

function playPauseResumeTest()
    playSong()
    love.timer.sleep(5)
    pauseSong()
    love.timer.sleep(5)
    resumeSong()
end

function isUrlTest()
    print(isStringURL("https://youtu.be/PduHaacGTqM"))
    print(isStringURL("aaaaa"))
end