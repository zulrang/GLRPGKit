
Tileset = class('Tileset')

function Tileset:initialize(image, tileWidth, tileHeight)

	self.image = image
	self.image:setFilter("nearest", "nearest")

	self.tileWidth = tileWidth
	self.tileHeight = tileHeight

	tilesetImageWidth = self.image:getWidth()
	tilesetImageHeight = self.image:getHeight()

	self.tilesWide = tilesetImageWidth / tileWidth
	self.tilesHigh = tilesetImageHeight / tileHeight

	tiles = self.tilesWide * self.tilesHigh
	tile = 0

	self.tileQuads = {}

	for y=0,self.tilesHigh-1 do
		for x=0,self.tilesWide-1 do
		  self.tileQuads[tile] = love.graphics.newQuad(
		  	x * (self.tileWidth),
		  	y * (self.tileHeight),
		    self.tileWidth,
		    self.tileHeight,
		    tilesetImageWidth,
		    tilesetImageHeight)
		  tile = tile + 1
		end
	end

end
