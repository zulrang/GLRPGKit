
require 'engine/tile_engine/tile'

TileMap = class('TileMap')

function TileMap:initialize(mapWidth, mapHeight, tileSize, tilesets, layers)

	self.mapWidth = mapWidth 	-- number of tiles wide
	self.mapHeight = mapHeight  -- number of tiles high
	self.tileSize = tileSize	-- width and height of tile sprites in pixels

	self.tilesets = tilesets
	self.layers = layers

	self.pixelWidth = self.mapWidth * self.tileSize		-- width of map in pixels
	self.pixelHeight = self.mapHeight * self.tileSize	-- height of map in pixels

	self.spriteBatch = love.graphics.newSpriteBatch(
		self.tilesets[1].image, self.mapWidth * self.mapHeight)

	self.entities = {}

end

function TileMap:positionToTile(posX, posY)
	-- determine tile xy coords from position
	-- (ajusted for 1-index array)
	return math.floor(posX / self.tileSize)+1, math.floor(posY / self.tileSize)+1
end


function TileMap:updateSpriteBatch()

	-- draw each layer
	for i=1,# self.layers do
		for y=1, self.mapHeight do
			for x=1, self.mapWidth do
				-- get tile info
				tile = self.layers[i]:getTile(x, y)
				-- draw tile quad				
				self.spriteBatch:addq(
					self.tilesets[tile.tileset].tileQuads[tile.tileIndex],
					(x-1) * self.tileSize,
					(y-1) * self.tileSize )
			end
		end
	end

end

function TileMap:checkPassable(x, y)

	-- can't walk off of map
	if x == 0 or y == 0 or x > self.mapWidth or y > self.mapHeight then
		return false
	end

	-- check tile layer flags
	for i=1,# self.layers do
		tile = self.layers[i]:getTile(x,y)
		if tile.passable == false then
			return false
		end
	end

	-- check if the cell is occupied
	for id,entity in pairs(self.entities) do
		if entity.mapPosition.x == x and entity.mapPosition.y == y then
			return false
		end
	end

	return true
end

function TileMap:activate(x, y)
	-- implement code for event firing
end

function TileMap:addEntity(entity)
	entity._id = generateId()
	self.last_id = entity._id
	self.entities[entity._id] = entity
end

function TileMap:removeEntity(entity)
	self.entities[entity._id] = nil
end

function TileMap:updateEntities(dt) 
	for i,v in pairs(self.entities) do
		v:idleUpdate(dt)
	end
end

function TileMap:drawEntities()
	for i,v in pairs(self.entities) do
		self.entities[i]:draw()
	end
end

function TileMap:update(dt)
	self:updateEntities(dt)
end

function TileMap:draw()

	love.graphics.draw(self.spriteBatch, 0, 0)
	self:drawEntities()

end

function TileMap:drawUnscaled()

end
