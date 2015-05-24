local ui = require "ui"
local network = require "network"
local world = require "world"
local states = require "states"
local utf8 = require "utf8"

local info_msg = "Type your nickname and press Enter."
local player_name

local menu = {}

function menu.load()
	player_name = player_name or "Player_Name"
end

function menu.update(dt)
	world_data = network.receive()
	if world_data then
		world.load(world_data)
	end
end

function menu.draw()
	world.draw()
	ui.message(player_name, info_msg)
end

function menu.textinput(t)
	if player_name:len() == 16 then
		return
	end
	if t == ' ' then
		return
	end
    player_name = player_name .. t
end

function menu.keypressed(key)
	if key == "escape" then
        love.event.quit()
    end
    if key == "backspace" then
        local byteoffset = utf8.offset(player_name, -1)
        if byteoffset then
            player_name = string.sub(player_name, 1, byteoffset - 1)
        end
    end
    if key == "return" then
		if player_name == "meat" then
			return
		end
		if player_name == "poison" then
			return
		end
		if player_name:len() < 2 then
			return
		end
        states.load("birth", player_name)
    end
end

return menu
