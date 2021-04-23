pathToMusicDir = "music/"
pathToSong = pathToMusicDir .. "%(title)s.%(ext)s"

function downloadSong(url)
    print("Downloading: " .. url)
    
    local command = "youtube-dl -x -f bestaudio --audio-format mp3 -o " .. "\"" .. pathToSong .. "\"" .. " " .. url
    os.execute(command)

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
