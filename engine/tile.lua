
require 'engine/middleclass'

Tile = class('Tile')

function Tile:initialize(index, passable)
	self.index = index
	self.passable = passable
end
