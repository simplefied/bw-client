local ui = require "ui"
local network = require "network"
local world = require "world"
local states = require "states"

local info_msg = "Wait a while."

local connection = {}

function connection.update(dt)
	world_data = network.receive()
	if world_data then
		world.load(world_data)
	end
	if world.empty() then
		network.send("connect")
	else
		states.load("menu")
	end
end

function connection.draw()
	ui.message("Connection...", info_msg)
end

return connection
