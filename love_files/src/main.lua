os.execute('cp ../lib/* .')
os.execute('mkdir music')

require("utility")
require("buttonEvents")
require("unitTests")
require("data")

local nuklear = require("nuklear")
local ui
local inputStr = {value = ''}
local volumeSlider = {value = 1.0}
local prevFrameWidth, prevFrameHeight = 400, 600

-- Channels for communication between main process and threads
local channel = {	isDownloading = love.thread.getChannel("isDownloading"),
					infoText = love.thread.getChannel("infoText"),
					songTitle = love.thread.getChannel("songTitle"),
					songURL = love.thread.getChannel("songURL"),
					URLorTitle = love.thread.getChannel("URLorTitle")
				}


function love.load()
    love.keyboard.setKeyRepeat(true)
	ui = nuklear.newUI()
    love.window.setTitle("LytPlay")
    love.window.setMode(400, 600, {minwidth=400, minheight=600})

	for f in io.popen([[dir -1 "./music"]]):lines() do 
		nextSongList = {next = nextSongList, value = string.gsub(f, "\\", "")} 
	end
end

function love.update(dt)
	ui:frameBegin()
	width, height, flags = love.window.getMode()

	if ui:windowBegin('LytPlay', 0, 0, 400, 600) then
        ui:layoutRow('dynamic', 30, {0.16, 0.64, 0.2})
        ui:label("Song:")
        ui:edit('box', inputStr)
        if ui:button('Download') then
			if not isDownloading then
				if isStringURL(inputStr.value) == true then
					channel.songURL:push(inputStr.value)
					thread = love.thread.newThread("threadURLDownload.lua")
					thread:start()
				elseif inputStr.value ~= "" then
					channel.songTitle:push(inputStr.value)
					thread = love.thread.newThread("threadTitleDownload.lua")
					thread:start()
				end
				inputStr.value = ""
			end
		end
		
		local threadDataIsDownloading = channel.isDownloading:pop()
		local threadDataInfoText = channel.infoText:pop()
		local threadDataURLorTitle = channel.URLorTitle:pop()
		

		if threadDataURLorTitle then
			nextSongList = {next = nextSongList, value = getSongName(threadDataURLorTitle)}
		end

		if threadDataInfoText then
			infoText = threadDataInfoText
		end

		if threadDataIsDownloading == true then
			isDownloading = true
		elseif threadDataIsDownloading == false then
			isDownloading = false
		end

		ui:layoutRow('dynamic', 30, 1)
		ui:label(infoText)
		ui:layoutRow('dynamic', 30, 3)
		if ui:button('Previous') then
			previousSong()
		end
		if isPlaying then
			if isPaused then
				if ui:button('Play') then
					resumeSong()
				end
			else
				if ui:button('Pause') then
					pauseSong()
				end
			end
		else
			if ui:button('Play') then
				playSong()
			end
		end
		if ui:button('Next') then
			nextSong()
		end
		ui:layoutRow('dynamic', 30, 1)
		if ui:slider(0, volumeSlider, 1, 0.0001) then 
			updateVolume(volumeSlider.value)
		end
		ui:layoutRow('dynamic', 380, 1)
		ui:label(getSongsListString(), 'top left')
		ui:layoutRow('dynamic', 30, 1)
		if ui:button('Clear cache') then
			clearSongsCache()
		end
		ui:layoutRow('dynamic', 30, 1)
		if ui:button('Exit') then
			love.event.quit()
		end
	end
	ui:windowEnd()
	ui:frameEnd()
end

--Connect love and nuklear events
function love.draw()
	ui:draw()
end
function love.keypressed(key, scancode, isrepeat)
	ui:keypressed(key, scancode, isrepeat)
end
function love.keyreleased(key, scancode)
	ui:keyreleased(key, scancode)
end
function love.mousepressed(x, y, button, istouch, presses)
	ui:mousepressed(x, y, button, istouch, presses)
end
function love.mousereleased(x, y, button, istouch, presses)
	ui:mousereleased(x, y, button, istouch, presses)
end
function love.mousemoved(x, y, dx, dy, istouch)
	ui:mousemoved(x, y, dx, dy, istouch)
end
function love.textinput(text)
	ui:textinput(text)
end
function love.wheelmoved(x, y)
	ui:wheelmoved(x, y)
end

--isUrlTest()
--testChoice()