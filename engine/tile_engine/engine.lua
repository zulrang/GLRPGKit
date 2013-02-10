
TileEngine = class('TileEngine')

function TileEngine:initialize(width, height)
	self.tileWidth = width
	self.tileHeight = height
end

function TileEngine:vectorToCell(x, y)
	return x / self.tileWidth, y / self.tileHeight
end

