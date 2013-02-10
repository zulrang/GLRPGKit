
require 'engine/game_component'

StateManager = class('StateManager', GameComponent)

local startDrawOrder = 5000
local drawOrderInc = 100

function StateManager:currentState() 
	return self.gameStates[#self.gameStates]
end

function StateManager:initialize(game)
	GameComponent.initialize(self)
	self.gameStates = {}
	self.drawOrder = startDrawOrder
	self.game = game
end

function StateManager:update(dt)
end

function StateManager:popState()
	if #self.gameStates > 0 then
		self:removeState()
		self.drawOrder = self.drawOrder - drawOrderInc

		-- call event handler
	end
end

function StateManager:removeState()
	-- remove event handler
	local state = self.gameStates[#self.gameStates]
	self.game:removeComponent(state)
	table.remove(self.gameStates)
end

function StateManager:pushState(newState)
	self.drawOrder = self.drawOrder - drawOrderInc
	newState.drawOrder = self.drawOrder

	self:addState(newState)

	-- call event handler
end

function StateManager:addState(newState)
	self.game:addComponent(newState)
	table.insert(self.gameStates, newState)
	-- add event handler
end

function StateManager:changeState(newState)
	while #self.gameStates > 0 do
		self:removeState()
	end

	newState.drawOrder = startDrawOrder
	self.drawOrder = startDrawOrder

	self:addState(newState)

	-- call event handler
end
