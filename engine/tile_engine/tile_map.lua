
require 'engine/tile_engine/tile'

TileMap = class('TileMap')

function TileMap:initialize(tilesets, layers)
	self.tilesets = tilesets
	self.layers = layers
	self.tilesetBatches = {}

	self.tileSize = self.tilesets[1].tileWidth
	self.pixelWidth = self.layers[1].width * self.tileSize
	self.pixelHeight = self.layers[1].height * self.tileSize

	-- get max sprite batch size
	maxSize = 0
	for i=1,# self.layers do
		-- need a one tile buffer for sprite batch
		layerSize = (self.layers[i].width+1) * (self.layers[i].height+1)
		if layerSize > maxSize then
			maxSize = layerSize
		end
	end

	-- create sprite batch objects
	for i=1,# self.layers do
		self.tilesetBatches[i] = love.graphics.newSpriteBatch(
			self.tilesets[i].image,
			maxSize)
	end
end

function TileMap:draw(camera)

	-- determine draw portion of sprite batch
	posX = camera.viewportRect.position.x +
		math.floor(-(camera.position.x%(self.tileSize*camera.zoom)))
	posY = camera.viewportRect.position.y +
		math.floor(-(camera.position.y%(self.tileSize*camera.zoom)))

	-- draw each sprite batch
	for i=1,# self.tilesetBatches do
		love.graphics.draw(
			self.tilesetBatches[i],
			posX,
			posY,
			0,
    		camera.zoom,
    		camera.zoom)
	end

	love.graphics.rectangle(
		"line",
		camera.viewportRect.position.x,
		camera.viewportRect.position.y,
		camera.viewportRect.width,
		camera.viewportRect.height)

end

function TileMap:drawUnscaled(camera)

	-- determine draw portion of sprite batch
	posX = camera.viewportRect.position.x +
		math.floor(-(camera.position.x%(self.tileSize*camera.zoom)))
	posY = camera.viewportRect.position.y +
		math.floor(-(camera.position.y%(self.tileSize*camera.zoom)))

	love.graphics.setColor(0, 0, 0, 128)
	love.graphics.rectangle("fill", 40, 50, 350, 120)
	love.graphics.setColor(255,255,255,255)

	love.graphics.print("Cam X: "..camera.position.x, 60, 60)
	love.graphics.print("Cam Y: "..camera.position.y, 60, 80)
	love.graphics.print("Pos X: "..posX, 60, 100)
	love.graphics.print("Pos Y: "..posY, 60, 120)
end

function TileMap:updateTilesetBatch(camera)

	-- we need to create the tileset sprite batch
	-- with a size one tile greater than the viewport
	-- based on the camera's position

	displayWidth = camera.viewportRect.width
	displayHeight = camera.viewportRect.height

	tileWidth = self.tilesets[1].tileWidth * camera.zoom
	tileHeight = self.tilesets[1].tileHeight * camera.zoom

	tilesDisplayWidth = math.ceil(displayWidth / tileWidth)
	tilesDisplayHeight = math.ceil(displayHeight / tileHeight)


	-- update sprite batches for each layer
	for i=1,# self.layers do
		-- clear sprite batch
		self.tilesetBatches[i]:clear()
		-- cycle through each tile in the layer
		for y=1, tilesDisplayHeight+1 do
			for x=1, tilesDisplayWidth+1 do
				-- get the tile data
				posX = math.floor(camera.position.x / tileWidth)
				posY = math.floor(camera.position.y / tileHeight)

				if x+posX <= self.layers[i].width and
					y+posY <= self.layers[i].height then

					tile = self.layers[i]:getTile(x+posX,y+posY)

					-- add the quad for the tile index and tileset
					self.tilesetBatches[i]:addq(
						self.tilesets[tile.tileset].tileQuads[tile.tileIndex],
						(x-1)*self.tilesets[tile.tileset].tileWidth,
						(y-1)*self.tilesets[tile.tileset].tileHeight)

				end
			end
		end
	end
end


