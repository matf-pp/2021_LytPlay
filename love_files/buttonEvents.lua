require("data")
require("utility")

function playSong()
    if isPlaying then love.audio.stop(musicSrc) end
    local stp = songToPlay
    if songToPlay ~= "" then
        musicSrc = love.audio.newSource(songToPlay, "stream") 
        musicSrc:play()
        currentlyPlaying = stp
        infoText = "Waiting for the song title or URL..."
        isPlaying = true
    else
        local l = nextSongList
        if l then
            songToPlay = "music/"..nextSongList.value
            stp = songToPlay
            nextSongList = nextSongList.next
            musicSrc = love.audio.newSource(songToPlay, "stream")
            currentlyPlaying = stp
            musicSrc:play()
            infoText = "Waiting for the song title or URL..."
            isPlaying = true
        end 
    end
    print(getSongsListString())
end

function pauseSong()
    musicSrc:pause()
    isPaused = true
end

function resumeSong()
    musicSrc:play()
    isPaused = false
end

function nextSong()
    local stp = songToPlay
    if nextSongList then 
        previousSongList = {next = previousSongList, value = string.gsub(songToPlay, "music/", "")}
        songToPlay = "music/"..nextSongList.value
        nextSongList = nextSongList.next
        playSong()
    end
end

function previousSong()
    local stp = songToPlay
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