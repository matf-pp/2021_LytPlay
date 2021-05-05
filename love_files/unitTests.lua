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

function testChoice()
    str1 = 'anavolimilovana'
    str2 = 'milavolianovana'
    if re.match(str1, "('anavolimilovana')/('kukurikokokoda')") ~= nil then
        print('anavolimilovana')
    end
    if re.match(str2, "('tojepravaneygoda')/('milavolianovana')") ~= nil then
        print('milavolianovana')
    end
end

function debugWidthHeight(prevW, prevH, width, height)
    print("----------------------------------")
	print("prevFrameWidth " .. prevW)
	print("prevFrameHeight " .. prevH)
	print("Width " .. width)
	print("Height " .. height)
	print(width / prevW .. " " .. height / prevH)
end