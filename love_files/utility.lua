require("data")

local re = require("re")


function getSongsListString() 
    return  "Previously played:" .. "\n" .. getPreviousSongsListString() .. "\n" ..
            "Currently playing:" .. "\n" .. getCurrentSongNameString() .. "\n" ..
            "Next in queue:" .. "\n" .. getNextSongsListString()
end

function getNextSongsListString()
    if nextSongList == nil then 
        return ""
    end
    local songsList = ""
    local l = nextSongList
	while l do
        if l.value then
            songsList = songsList .. string.gsub(l.value, ".mp3", "") .. "\n"
            l = l.next
        end
	end
    return songsList
end

function getPreviousSongsListString()
    if previousSongList == nil then 
        return ""
    end
    local songsList = ""
    local arrayToReverse = {}
    local l = previousSongList
	while l do
        if l.value then
            arrayToReverse[#arrayToReverse + 1] = string.gsub(l.value, ".mp3", "")
		    l = l.next
        end
	end

    for i = #arrayToReverse, 1, -1 do
        songsList = songsList .. arrayToReverse[i] .. "\n"
    end
    return songsList
end

function getCurrentSongNameString()
    if currentlyPlaying == "" then
        return ""
    end
    return string.sub(string.gsub(currentlyPlaying, ".mp3", ""), 7) .. "\n"
end

function isStringURL(str)
    if re.match(str, "(((('http'('s')?)'://')?('www.')?)?'youtube.com/')?('watch?v=')?[a-zA-Z0-9-_]^11") then 
        return true
    elseif re.match(str, "(((('http'('s')?)'://')?('www.')?)?'youtu.be/')?('watch%?v=')?[a-zA-Z0-9-_]^11") then
        return true
    elseif re.match(str, "((('http'('s')?'://')?('www.')?)?'youtube.com/')?(('playlist?list='[a-zA-Z0-9_-]^34)/('watch?'('list='[a-zA-Z0-9_-]^18'&v='[a-zA-Z0-9_-]^11'&')/('v='[a-zA-Z0-9_-]^11'&list='[a-zA-Z0-9_-]^18'&')))") then
        return true
    else
        return false
    end
end

function getSongName(url)
    local filename = io.popen("youtube-dl --get-title -o " .. "\"" .. pathToSong .. "\"  " .. url):read("*a")
    return string.sub(filename, 1, -2) .. ".mp3"
end

-- function setSongToPlay(url)
--     local filename = "music/" .. string.sub(io.popen("youtube-dl --get-title -o " .. "\"" .. pathToSong .. "\"  " .. url):read("*a"), 1, -2) .. ".mp3"
--     songToPlay = filename
-- end

function clearSongsCache()
    local command = "rm -r " .. pathToMusicDir .. "*"
    os.execute(command)
    nextSongList = nil
    previousSongList = nil
    songToPlay = ""
end