
Map = class('Map')

function Map:initialize(width, height, tileWidth, tileHeight)
	self.mapWidth = width
	self.mapHeight = height
	self.tileHeight = tileHeight
	self.tileWidth = tileWidth
	self.engine = TileEngine:new(tileWidth, tileHeight)
	self.map = {}
end

function Map:loadTileset(filename)

  	tilesetImage = love.graphics.newImage(filename)

  	self.tileset = Tileset:new(tilesetImage, 16, 16)

  	self.tilesetBatch = love.graphics.newSpriteBatch(
  		self.tileset.image,
  		self.mapWidth * self.mapHeight)

  	self:updateTilesetBatch()
end



