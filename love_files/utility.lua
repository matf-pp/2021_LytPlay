require("data")

local re = require("re")


function isStringURL(str)
    if re.match(str, "(((('http'('s')?)'://')?('www.')?)?'youtube.com/')?('watch?v=')?[a-zA-Z0-9-_]^11") ~= nil then 
        return true
    elseif re.match(str, "(((('http'('s')?)'://')?('www.')?)?'youtu.be/')?('watch%?v=')?[a-zA-Z0-9-_]^11") ~= nil then
        return true
    else
        return false
    end
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
    nextSongList = nil
    previousSongList = nil
end