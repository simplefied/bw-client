local ui = require "ui"
local network = require "network"
local world = require "world"
local states = require "states"

local info_msg = "Wait a while."
local player_name

local birth = {}

function birth.load(name)
	player_name = name
end

function birth.update(dt)
	world_data = network.receive()
	if world_data then
		world.load(world_data)
	end
	if not world.player(player_name) then
		network.send("birth " .. player_name)
	else
		states.load("game", player_name)
	end
end

function birth.draw()
	world.draw()
	ui.message("Login to the game...", info_msg)
end

return birth
