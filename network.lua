local socket = require "socket"
local states = require "states"

local proto_err_msg = "Incompatible version of the protocol. Perhaps your version of the client program is outdated."
local network_err_msg = "Network is unreachable."
				
local protocol = 0.3

local udp
local receive_fails = 0

local network = {}

function network.init(address, port)
	udp = socket.udp()
	if not udp then
		states.load("error", network_err_msg)
	end
	udp:settimeout(0)
	local res = udp:setpeername(address, port)
	if not res then
		states.load("error", network_err_msg)
	end
end

function network.send(msg)
	udp:send(msg)
end

function network.receive()
	if receive_fails == 60 then
		states.load("error", "The server is not responding.")
	end
	local data
	local data_temp = udp:receive()
	while data_temp do
		data = data_temp
		data_temp = udp:receive()
	end
	if data then
		local srv_protocol, other = data:match("([^\n]+)\n(.+)")
		if tonumber(srv_protocol) ~= protocol then
			states.load("error", proto_err_msg)
		end
		receive_fails = 0
		return other
	end
	receive_fails = receive_fails + 1
	return data
end

return network
