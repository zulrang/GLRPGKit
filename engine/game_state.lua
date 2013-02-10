
require 'engine/middleclass'
require 'engine/drawable_game_component'

GameState = class('GameState', DrawableGameComponent)

function GameState:initialize(game, manager)
	DrawableGameComponent.initialize(self)
	self.stateManager = manager
	self.tag = self
	self.game = game
	self.childComponents = {}
end

function GameState:update(dt)
	for i,comp in ipairs(self.childComponents) do
		if comp.enabled then
			comp:update(dt)
		end
	end
end

function GameState:draw()
	for i,comp in ipairs(self.childComponents) do
		if comp.visible then
			comp:draw()
		end
	end
end

function GameState:drawUnscaled()
	for i,comp in ipairs(self.childComponents) do
		if comp.visible then
			comp:drawUnscaled()
		end
	end
end

function GameState:stateChange()
	if stateManager.currentState == self then
		self:show()
	else
		self:hide()
	end
end

function GameState:show()
	self.visible = true
	self.enabled = true
	for i,comp in ipairs(self.childComponents) do
		comp.enabled = true
		comp.visible = true
	end
end

function GameState:hide()
	self.visible = false
	self.enabled = false
	for i,comp in ipairs(self.childComponents) do
		comp.enabled = false
		comp.visible = false
	end
end

