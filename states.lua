local current_state

local states = {}

function states.load(state, args)
	current_state = require(state)
	if current_state.load then
		current_state.load(args)
	end
end

function states.current()
	return current_state
end

return states
