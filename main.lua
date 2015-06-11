local ui = require "ui"
local network = require "network"
local states = require "states"

local graphics_options = {
	fullscreen = true,
	fullscreentype = "desktop",
	fsaa = 0
}

function love.load()
	love.window.setTitle("Bacterium Wars")
	love.graphics.setBackgroundColor(85, 153, 237)
	love.keyboard.setKeyRepeat(true)
	local success = love.window.setMode(800, 600, graphics_options)
	if not success then
		states.load("error", "Graphics mode setting error.")
	end
	ui.init()
	network.init("bacteriumwars.ru", 27161)
	states.load("connection")
end

function love.update(dt)
	if states.current().update then
		states.current().update(dt)
	end
end

function love.draw()
	if states.current().draw then
		states.current().draw()
	end
end

function love.textinput(t)
	if states.current().textinput then
		states.current().textinput(t)
	end
end

function love.keypressed(key)
	if states.current().keypressed then
		states.current().keypressed(key)
	end
end
