
require 'engine/middleclass'
require 'engine/game_component'

DrawableGameComponent = class('DrawableGameComponent', GameComponent)

function DrawableGameComponent:initialize()
	GameComponent.initialize(self)
	self.isDrawable = true
end

function DrawableGameComponent:draw()
end

function DrawableGameComponent:loadContent()
end
