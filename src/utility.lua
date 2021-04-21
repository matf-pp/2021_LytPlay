local lfs = require "lfs"

local pathToMusicDir = lfs.currentdir() .. "/../music/"
local pathToSong = pathToMusicDir .. "%(title)s.%(ext)s"


function downloadSong(url)
    print("Downloading " .. url)
    
    local command = "youtube-dl -x -o " .. "\"" .. pathToSong .. "\"" .. " " .. url

    os.execute(command)

end
