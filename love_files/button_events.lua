require("data")

function playSong()
    print("Playing file: " .. songToPlay)
    if isPlaying then love.audio.stop(musicSrc) end
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
    if nextSongList then 
        previousSongList = {next = previousSongList, value = string.gsub(songToPlay, "music/", "")}
        songToPlay = "music/"..nextSongList.value
        nextSongList = nextSongList.next
        playSong()
    end
end

function previousSong()
    if previousSongList then 
        nextSongList = {next = nextSongList, value = string.gsub(songToPlay, "music/", "")}
        songToPlay = "music/"..previousSongList.value
        previousSongList = previousSongList.next
        playSong()
    end
end

function updateVolume(value)
    love.audio.setVolume(value)
end

function removeSong()

end

function clearQueue()

end