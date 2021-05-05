require("utility")
require("buttonEvents")
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

function debugWidthHeight(prevW, prevH, width, height)
    print("----------------------------------")
	print("prevFrameWidth " .. prevW)
	print("prevFrameHeight " .. prevH)
	print("Width " .. width)
	print("Height " .. height)
	print(width / prevW .. " " .. height / prevH)
end

function printListStrings()
    print("-----------------------------")
    print("Previous:")
    print(getPreviousSongsListString())
    print("Current:")
    print(getCurrentSongNameString())
    print("Next:")
    print(getNextSongsListString())
end