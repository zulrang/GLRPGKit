
Tile = class('Tile')

function Tile:initialize(tileIndex, tileset)
	self.tileIndex = tileIndex
	self.tileset = tileset
end

function Tile:__concat()
	return "[Tile:"..self.tileIndex..","..self.tileset.."]"
end
