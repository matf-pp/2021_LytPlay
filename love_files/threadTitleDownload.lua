require("utility")

pathToSong = "music/%(title)s.%(ext)s"

local channel = {	isDownloading	= love.thread.getChannel("isDownloading"),
					infoText = love.thread.getChannel("infoText"),
                    songTitle = love.thread.getChannel("songTitle"),
                    setSongToPlay = love.thread.getChannel("setSongToPlay")
				}


songTitle = channel.songTitle:pop()
if songTitle then
    print("String not URL. Downloading song by title...")
    channel.isDownloading:push(true)
    local command = "youtube-dl -x -f bestaudio --audio-format mp3 -o " .. "\"" .. pathToSong .. "\"" .. " " .. "\"ytsearch1:" .. songTitle .. "\""
    channel.infoText:push("Downloading song...")
    os.execute(command)

    channel.setSongToPlay:push("\"ytsearch1:" .. songTitle .. "\"")
    channel.infoText:push("Finished downloading! Play your song now.")
    channel.isDownloading:push(false)
end