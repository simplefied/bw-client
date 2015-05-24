local ui = require "ui"

local players = {}
local poisons = {}
local meats = {}
local world_radius
local lookAt

local world = {}

function world.load(data)
	players = {}
	poisons = {}
	meats = {}
	world_radius, data = data:match("([^\n]+)\n(.+)")
	if world_radius then
		world_radius = tonumber(world_radius)
	else
		world_radius = 100
	end
	for line in data:gmatch("([^\n]+)\n") do
		local name, size, x, y = line:match("^(.+) (.+) (.+) (.+)$")
		if name and size and x and y then
			size, x, y = tonumber(size), tonumber(x), tonumber(y)
			local blob = {
				size = size,
				x = x,
				y = y
			}
			if name == "meat" then 
				table.insert(meats, blob)
			elseif name == "poison" then 
				table.insert(poisons, blob)
			else
				players[name] = blob
			end
		end
	end
end

function world.draw()
	if not world_radius then
		return
	end
	local width, height, flags = love.window.getMode()
	love.graphics.push()
	if lookAt then
		love.graphics.translate(width/2 - lookAt.x, height/2 - lookAt.y)
	else
		love.graphics.translate(width/2, height/2)
	end
	love.graphics.setColor(200, 200, 200)
	love.graphics.circle("fill", 0, 0, world_radius + 4, 360)
	love.graphics.setColor(95, 163, 247)
	love.graphics.circle("fill", 0, 0, world_radius, 360)
	love.graphics.setFont(ui.font())
	for k, v in pairs(players) do
		love.graphics.setColor(200, 200, 200)
		love.graphics.circle("fill", v.x, v.y, v.size, 36)
		love.graphics.setColor(255, 255, 255)
		love.graphics.circle("fill", v.x, v.y, v.size - 5, 36)
		love.graphics.setColor(0, 0, 0)
		local text_r = math.cos(math.pi/4) * (v.size + 10)
		love.graphics.print(k, v.x + text_r, v.y - text_r - 10, -math.pi/4);
    end
    for i, v in ipairs(poisons) do
		love.graphics.setColor(32, 32, 32)
		love.graphics.circle("fill", v.x, v.y, v.size, 36)
    end
    for i, v in ipairs(meats) do
		love.graphics.setColor(255, 255, 255)
		love.graphics.circle("fill", v.x, v.y, v.size, 36)
    end
    love.graphics.pop()
end

function world.lookAt(x, y)
	lookAt = {x=x, y=y}
end

function world.player(name)
	return players[name]
end

function world.empty()
	return #meats == 0
end

return world
