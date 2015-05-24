local ui = require "ui"
local states = require "states"

local err_message

local menu = {}

function menu.load(message)
	err_message = message
end

function menu.draw()
	ui.message("An error has occurred", err_message)
end

function menu.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "return" then
		love.event.quit()
    end
end

return menu
