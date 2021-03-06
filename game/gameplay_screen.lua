
require 'game/base_game_state'
require 'engine/tile_engine/engine'
require 'engine/tile_engine/tileset'
require 'engine/tile_engine/map_layer'
require 'engine/tile_engine/tile_map'
require 'engine/tile_engine/camera'
require 'engine/player'
require 'engine/roaming_npc'
require 'lib/vector2'
require 'lib/rect'

GameplayScreen = class('GameplayScreen', BaseGameState)

mapWidth = 300
mapHeight = 300

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
	self.camera = Camera:new(love.graphics.getWidth(), love.graphics.getHeight(), Vector2:new(0,0))
	self.camera.zoom = 1

 	-- create the tileset
  	tilesetImage = love.graphics.newImage("content/tiles_overworld.png")
  	tileset = Tileset:new(tilesetImage, 16, 16)

  	-- create the map layer
  	layer = MapLayer:new(mapWidth, mapHeight)

  	mapImage = love.image.newImageData("content/map_world.png")
  	layer:fromImageData(mapImage)
  	mapWidth = layer.width
  	mapHeight = layer.height

  	-- create the tile map
	self.map = TileMap:new(layer.width, layer.height, 16, {tileset}, {layer})
	self.map:updateSpriteBatch()

	-- lock camera to map
	self.camera.lockMaxX = self.map.pixelWidth
	self.camera.lockMaxY = self.map.pixelHeight

	-- create the player
	self.player = Player:new(self.map, playerStart, playerSprite, playerQuad)
	self.player:addCamera(self.camera)

	-- add player to map
	self.map:addEntity(self.player)

	-- add roamers
	for i=1,40 do
		randX = math.random(1, mapWidth)
		randY = math.random(1, mapHeight)
		while not self.map:checkPassable(randX, randY) do
			randX = math.random(1, mapWidth)
			randY = math.random(1, mapHeight)
		end 
		ent = RoamingNpc:new(self.map, Vector2(randX, randY), playerSprite, playerQuad)
		ent._id = generateId()
		self.map:addEntity(ent)
	end

	love.graphics.setFont(love.graphics.newFont("content/pf_tempesta_7_xb.ttf",8))

	BaseGameState.loadContent(self)
end

function GameplayScreen:update(dt)

	self.camera:update(dt)
	self.map:update(dt)

	self.mouseWorldPosX, self.mouseWorldPosY = self.camera:getMousePos()
	self.mouseTilePosX, self.mouseTilePosY = self.map:positionToTile(self.mouseWorldPosX, self.mouseWorldPosY)

end

function GameplayScreen:draw()

	-- translate camera
	love.graphics.push()
	love.graphics.scale(self.camera.zoom, self.camera.zoom)
	love.graphics.translate(-self.camera.position.x, -self.camera.position.y)

	self.map:draw()

	-- draw tile highlight

	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle(
		"line",
		self.map.tileSize*(self.mouseTilePosX-1),
		self.map.tileSize*(self.mouseTilePosY-1),
		16,
		16
		)

	love.graphics.pop()

	BaseGameState.draw(self)
end

function GameplayScreen:drawUnscaled()

	self.map:drawUnscaled(self.camera)
  	
  	love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10)
  	love.graphics.print("Player: ("..self.player.mapPosition.x..", "..
  		self.player.mapPosition.y..")", 10, 30)

  	love.graphics.print("Mouse: ("..self.mouseWorldPosX..", "..
  		self.mouseWorldPosY..")", 10, 50)

  	love.graphics.print("Mouse (tile): ("..self.mouseTilePosX..", "..
  		self.mouseTilePosY..")", 10, 70)

	BaseGameState.draw(self)
end
