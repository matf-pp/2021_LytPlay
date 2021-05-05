require("data")

function playSong()
    if isPlaying then love.audio.stop(musicSrc) end
    if songToPlay ~= "" then
        musicSrc = love.audio.newSource(songToPlay, "stream") 
        musicSrc:play()
        currentlyPlaying = string.gsub(songToPlay, ".mp3", "")
        infoText = "Waiting for the song title or URL..."
        isPlaying = true
    end
end

function pauseSong()
    musicSrc = love.audio.pause()
    isPaused = true
end

function resumeSong()
    love.audio.play(musicSrc)
    isPaused = false
end

function nextSong()
    if nextSongList then 
        previousSongList = {next = previousSongList, value = string.gsub(songToPlay, "music/", "")}
        songToPlay = "music/"..nextSongList.value
        nextSongList = nextSongList.next
        playSong()
        currentlyPlaying = string.gsub(songToPlay, ".mp3", "")
    end
end

function previousSong()
    if previousSongList then 
        nextSongList = {next = nextSongList, value = string.gsub(songToPlay, "music/", "")}
        songToPlay = "music/"..previousSongList.value
        previousSongList = previousSongList.next
        playSong()
        currentlyPlaying = string.gsub(songToPlay, ".mp3", "")
    end
end

function updateVolume(value)
    love.audio.setVolume(value)
end

function removeSong()

end