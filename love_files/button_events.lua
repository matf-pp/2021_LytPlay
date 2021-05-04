require("data")

function playSong()
    print("Playing file: " .. songToPlay)
    musicSrc = love.audio.newSource(songToPlay, "stream") 
    musicSrc:play()
    infoText = "Waiting for song..."
    isPlaying = true
end

function pauseSong()
    print("Paused")
    musicSrc = love.audio.pause()
    isPaused = true
end

function resumeSong()
    print("Resumed")
    love.audio.play(musicSrc)
    isPaused = false
end

function nextSong()

end

function previousSong()

end

function updateVolume(value)
    love.audio.setVolume(value)
end

function removeSong()

end

function clearQueue()

end

function downloadSong(inputStr)
    if isStringURL(inputStr) == true then
        downloadSongByURL(inputStr)
    elseif inputStr ~= '' then
        downloadSongByTitle(inputStr)
    end
end