require("data")

function playSong()
    print("Playing file: " .. songToPlay)
    musicSrc = love.audio.newSource(songToPlay, "stream") 
    musicSrc:play()
end

function pauseSong()
    print("Paused")
    musicSrc = love.audio.pause()
end

function resumeSong()
    print("Resumed")
    love.audio.play(musicSrc)
end

function nextSong()

end

function previousSong()

end

function updateVolume()

end

function removeSong()

end

function clearQueue()

end