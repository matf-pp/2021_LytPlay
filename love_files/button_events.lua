require("data")

function playSong()
    print("Playing file: " .. songToPlay)
    musicSrc = love.audio.newSource(songToPlay, "stream") 
    musicSrc:play()
end

function pauseSong()

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