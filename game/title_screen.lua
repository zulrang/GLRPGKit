
require 'game/base_game_state'
require 'game/gameplay_screen'

TitleScreen = class('TitleScreen', BaseGameState)

function TitleScreen:initialize(game, manager)
	BaseGameState.initialize(self, game, manager)
	self.backgroundImage = nil;
end

function TitleScreen:loadContent()
	self.backgroundImage = love.graphics.newImage('content/titlescreen.png')
	BaseGameState.loadContent(self)
end

function TitleScreen:update(dt)

	if love.keyboard.isDown(" ") then
		self.stateManager:changeState(game.gameplayScreen)
	end

end

function TitleScreen:draw()
	BaseGameState.draw(self)
	love.graphics.draw(self.backgroundImage, 0, 0)
end
