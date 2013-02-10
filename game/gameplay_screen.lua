
require 'game/base_game_state'
require 'engine/tile_engine/engine'
require 'engine/tile_engine/tileset'
require 'engine/tile_engine/map_layer'
require 'engine/tile_engine/tile_map'
require 'engine/tile_engine/camera'
require 'game/player'
require 'lib/vector2'
require 'lib/rect'

GameplayScreen = class('GameplayScreen', BaseGameState)

function GameplayScreen:initialize(game, manager)

	self.game = game

	engine = TileEngine:new(16, 16)

	BaseGameState.initialize(self, game, manager)
end

function GameplayScreen:loadContent()

	playerStart = Vector2(3, 3)
	playerSprite = love.graphics.newImage("content/sprites.png")
	playerSprite:setFilter("nearest", "nearest")
	playerQuad = love.graphics.newQuad(0, 3*16, 16, 16, playerSprite:getWidth(), playerSprite:getHeight())


	-- create the camera
	self.camera = Camera:new(Rect:new(0, 0, 800/4, 600/4), Vector2:new(0,0))
	-- self.camera.zoom = 4

  	-- create the tileset
  	tilesetImage = love.graphics.newImage("content/tiles_overworld.png")
  	tileset = Tileset:new(tilesetImage, 16, 16)

  	-- create the map layer
  	layer = MapLayer:new(300, 300)

  	mapImage = love.image.newImageData("content/map_world.png")
  	layer:fromImageData(mapImage)

  	-- create the tile map
	self.map = TileMap:new({tileset}, {layer})
	self.map:updateTilesetBatch(self.camera)

	-- create the player
	self.player = Player:new(self.map, playerStart, playerSprite, playerQuad)
	self.player:addCamera(self.camera)

	love.graphics.setFont(love.graphics.newFont("content/pf_tempesta_7_xb.ttf",16))

	BaseGameState.loadContent(self)
end

function GameplayScreen:update(dt)

	motion = Vector2:new(0,0)

	if love.keyboard.isDown("right") then
		motion.x = self.camera.speed
	end

	if love.keyboard.isDown("left") then
		motion.x = -self.camera.speed
	end

	if love.keyboard.isDown("up") then
		motion.y = -self.camera.speed
	end

	if love.keyboard.isDown("down") then
		motion.y = self.camera.speed
	end

	motion:normalize()

	self.camera.position = self.camera.position + motion * self.camera.speed * dt
	self.camera:lock(self.map.pixelWidth, self.map.pixelHeight)

	self.map:updateTilesetBatch(self.camera)

	self.player:idleUpdate(dt)
end

function GameplayScreen:draw()

	self.map:draw(self.camera)

	self.player:draw(
		self.player.position.x - self.camera.position.x,
		0+self.player.position.y - self.camera.position.y
		) 

	BaseGameState.draw(self)
end

function GameplayScreen:drawUnscaled()

	self.map:drawUnscaled(self.camera)
  	
  	love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10)

	BaseGameState.draw(self)
end
