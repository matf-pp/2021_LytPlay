currentlyPlaying = ""
songToPlay = ""
pathToMusicDir = "music/"
pathToSong = pathToMusicDir .. "%(title)s.%(ext)s"
infoText = "Waiting for song title or URL..."
isPlaying = false
isPaused = false
isDownloading = false
nextSongList = nil
previousSongList = nil

musicSrc = nil