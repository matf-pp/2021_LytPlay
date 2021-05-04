require("data")

local re = require("re")

pathToMusicDir = "music/"
pathToSong = pathToMusicDir .. "%(title)s.%(ext)s"


function isStringURL(str)
    if re.match(str, "(((('http'('s')?)'://')?('www.')?)?'youtube.com/')?('watch?v=')?[a-zA-Z0-9-_=%?]") ~= nil then 
        return true
    elseif re.match(str, "(((('http'('s')?)'://')?('www.')?)?'youtu.be/')?('watch%?v=')?[a-zA-Z0-9-_=%?]") ~= nil then
        return true
    else
        return false
    end
end

function downloadSongByTitle(title) 
    isDownloading = true
    print("String not URL. Downloading song by title...")

    local command = "youtube-dl -x -f bestaudio --audio-format mp3 -o " .. "\"" .. pathToSong .. "\"" .. " " .. "\"ytsearch1:" .. title .. "\""
    os.execute(command)
    
    setSongToPlay("\"ytsearch1:" .. title .. "\"")
    infoText = "Finished downloading! Play your song now."
    isDownloading = false
end

function downloadSongByURL(url)
    isDownloading = true
    print("String URL. DOwnloading song by link...")
    
    local command = "youtube-dl -x -f bestaudio --audio-format mp3 -o " .. "\"" .. pathToSong .. "\"" .. " " .. url
    os.execute(command)

    setSongToPlay(url)
    infoText = "Finished downloading! Play your song now."
    isDownloading = false
end

function setSongToPlay(url)
    local filename = io.popen("youtube-dl --get-title -o " .. "\"" .. pathToSong .. "\"  " .. url):read("*a")
    filename = "music/" .. string.sub(filename,1,-2) .. ".mp3"
    songToPlay = filename
    print("File path: " .. filename)
end

function clearSongsCache()
    print("Deleting cache...")
    local command = "rm -r " .. pathToMusicDir .. "*"
    os.execute(command)
end