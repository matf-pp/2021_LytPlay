require("utility")
require("button_events")
require("unit_tests")
require("data")

local nuklear = require("nuklear")
local ui
local inputStr = {value = ''}
local volumeSlider = {value = 0.5}
local prevFrameWidth, prevFrameHeight = 400, 600

function love.load()
    love.keyboard.setKeyRepeat(true)
	ui = nuklear.newUI()
    love.window.setTitle("LytPlay")
	-- love.window.setMode(400, 600, {resizable=true, minwidth=400, minheight=600})
    love.window.setMode(400, 600, {minwidth=400, minheight=600})
end

function love.update(dt)
	ui:frameBegin()
	width, height, flags = love.window.getMode()
	-- ui:scale(width / prevFrameWidth, height / prevFrameHeight)
	-- debugWidthHeight(prevFrameWidth, prevFrameHeight, width, height)
	if ui:windowBegin('LytPlay', 0, 0, 400, 600) then
        ui:layoutRow('dynamic', 30, {0.16, 0.64, 0.2})
        ui:label("Song:")
        ui:edit('box', inputStr)
        if ui:button('Download') then
			if isStringURL(inputStr.value) == true then
            	downloadSongByURL(inputStr.value)
			else 
				downloadSongByTitle(inputStr.value)
			end
		end
		ui:layoutRow('dynamic', 30, 1)
		ui:label(infoText)
		ui:layoutRow('dynamic', 30, 3)
		if ui:button('Play') then
			playSong()
		end
		if ui:button('Pause') then
			pauseSong()
		end
        if ui:button('Resume') then
            resumeSong()
        end
		ui:layoutRow('dynamic', 30, 1)
		if ui:slider(0, volumeSlider, 1, 0.0001) then 
			updateVolume(volumeSlider.value)
		end
		ui:layoutRow('dynamic', 410, 1)
		ui:label("Placeholder text...")
		ui:layoutRow('dynamic', 30, 1)
		if ui:button('Exit') then
			clearSongsCache()
			love.event.quit()
		end
	end
	prevFrameWidth, prevFrameHeight, flags = love.window.getMode()
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