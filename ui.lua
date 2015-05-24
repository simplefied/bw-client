local title_font
local message_font

local ui = {}

function ui.init()
	title_font = love.graphics.newFont("resources/fonts/bacterium.ttf", 40)
	message_font = love.graphics.newFont("resources/fonts/bacterium.ttf", 12)
end

function ui.message(title, message)
	local width, height, flags = love.window.getMode()
	love.graphics.setColor(255, 255, 255, 150)
	love.graphics.rectangle("fill", 0, height/2 - 60, width, 102)
	love.graphics.setFont(title_font)
	love.graphics.setColor(0, 0, 0)
	love.graphics.printf(title, 0, height/2 - 40, width, "center")
	love.graphics.setFont(message_font)
	love.graphics.setColor(40, 40, 40)
	love.graphics.printf(message, 0, height/2 + 10, width, "center")
end

function ui.font()
	return message_font
end

return ui
