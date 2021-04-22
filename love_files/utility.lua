pathToMusicDir = "music/"
pathToSong = pathToMusicDir .. "%(title)s.%(ext)s"

function downloadSong(url)
    print("Downloading " .. url)
    
    local command = "youtube-dl -x -f bestaudio --audio-format mp3 -o " .. "\"" .. pathToSong .. "\"" .. " " .. url

    os.execute(command)
end

function clearSongsCache()
    print("Deleting cache...")
    local command = "rm -r " .. pathToMusicDir .. "*"
    os.execute(command)
end
