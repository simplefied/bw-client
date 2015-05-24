local ui = require "ui"
local network = require "network"
local world = require "world"
local states = require "states"

local info_msg = "Press Enter to restart the game."

game_over = {}

function game_over.load()
	
end

function game_over.update(dt)
	world_data = network.receive()
	if world_data then
		world.load(world_data)
	end
end

function game_over.draw()
	world.draw();
	ui.message("Game over!", info_msg)
end

function game_over.keypressed(key)
    if key == "return" then
        states.load("menu")
    end
end

return game_over
