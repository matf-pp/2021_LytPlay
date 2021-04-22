function playSong(file)
    print("Playing file: " .. file)
    musicSrc = love.audio.newSource(file, "stream")
    musicSrc:setVolume(0.05)
    musicSrc:play()
end