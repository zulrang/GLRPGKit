
require 'engine/game'
-- require 'engine/map'
require 'game/title_screen'

DragonWarrior = class('DragonWarrior', Game)

function DragonWarrior:initialize()

	Game.initialize(self)
	self.debug = true

	-- create gameplay screens
	self.titleScreen = TitleScreen:new(self, self.stateManager)
	self.gameplayScreen = GameplayScreen:new(self, self.stateManager)

	self:addComponent(self.stateManager)

	-- add title screen to component stack
	self.stateManager:changeState(self.titleScreen)

	-- map = Map:new()
	-- mapMap = love.image.newImageData('content/map_world.png')

	-- map:fromImageData(mapMap)
	-- map:setupMapView()
	-- map:setupTileset()

	-- self:addComponent(map)
end

