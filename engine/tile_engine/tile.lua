
Tile = class('Tile')

function Tile:initialize(tileIndex, tileset, passable)
	self.tileIndex = tileIndex
	self.tileset = tileset
	self.passable = passable
end

function Tile:__concat()
	return "[Tile:"..self.tileIndex..","..self.tileset.."]"
end
