require("utility")

pathToSong = "music/%(title)s.%(ext)s"

local channel = {	isDownloading	= love.thread.getChannel("isDownloading"),
					infoText = love.thread.getChannel("infoText"),
                    songURL = love.thread.getChannel("songURL")
				}


songURL = channel.songURL:pop()
if songURL then
    print("String URL. Downloading song by link...")
    channel.isDownloading:push(true)
    local command = "youtube-dl -x -f bestaudio --audio-format mp3 -o " .. "\"" .. pathToSong .. "\"" .. " " .. songURL
    channel.infoText:push("Downloading song...")
    os.execute(command)

    setSongToPlay(songURL)
    channel.infoText:push("Finished downloading! Play your song now.")
    channel.isDownloading:push(false)
end