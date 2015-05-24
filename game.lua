local network = require "network"
local world = require "world"
local states = require "states"

local player_name

game = {}

function game.load(name)
	player_name = name
end

function game.update(dt)
	world_data = network.receive()
	if world_data then
		world.load(world_data)
	end
	local width, height, flags = love.window.getMode()
	local player = world.player(player_name)
	if player then
		world.lookAt(player.x, player.y);
		local x, y = love.mouse.getPosition()
		local turn = string.format("%s %s %f %f", 'turn', player_name, x - width/2, y - height/2)
		network.send(turn)
	else
		states.load("game_over")
	end
end

function game.draw()
	world.draw()
end

function game.keypressed(key)
    if key == "escape" then
        states.load("menu")
    end
end

return game
