
require 'engine/game'
-- require 'engine/map'
require 'game/gameplay_screen'

DragonWarrior = class('DragonWarrior', Game)

function DragonWarrior:initialize()

	Game.initialize(self)
	self.debug = true

	-- create gameplay screen
	gameplayScreen = GameplayScreen:new(self, self.stateManager)
	-- add gameplay screen to component stack
	self:addComponent(gameplayScreen)

	-- map = Map:new()
	-- mapMap = love.image.newImageData('content/map_world.png')

	-- map:fromImageData(mapMap)
	-- map:setupMapView()
	-- map:setupTileset()

	-- self:addComponent(map)
end

