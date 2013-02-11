
require 'engine/middleclass'
require 'engine/input_handler'
require 'engine/state_manager'

Game = class('Game')

function Game:initialize()
	self.components = {}
	self.debug = false

	self.inputHandler = InputHandler:new()
	self.stateManager = StateManager:new(self)
	self:addComponent(self.inputHandler)
	self:addComponent(self.stateManager)

	self.logfile = love.filesystem.newFile("log.txt")
	self.logfile:open("w")

end

function Game:cleanup() 
	self.logfile:close()
end

function Game:log(str) 
	self.logfile:write(str.."\n")
end

function Game:loadContent()
	for id,comp in pairs(self.components) do
		if comp.isDrawable then
			comp:loadContent()
		end
	end
end

function Game:addComponent(comp)
	self.components[comp.id] = comp
	if comp.isDrawable then
		comp:loadContent()
	end
end

function Game:removeComponent(comp)
	self.components[comp.id] = nil
end

function Game:update(dt)
	for id,comp in pairs(self.components) do
		comp:update(dt)
	end
end

function Game:draw()
	for id,comp in pairs(self.components) do
		if comp.isDrawable then
			comp:draw()
		end
	end

end

function Game:drawUnscaled()
	for id,comp in pairs(self.components) do
		if comp.isDrawable then
			comp:drawUnscaled()
		end
	end

end

