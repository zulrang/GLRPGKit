
require 'engine/middleclass'
require 'engine/game_state'

BaseGameState = class('BaseGameState', GameState)

function BaseGameState:initialize(game, manager)
	GameState.initialize(self, game, manager)
end
