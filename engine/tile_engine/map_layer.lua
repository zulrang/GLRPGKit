
MapLayer = class('MapLayer')

function MapLayer:initialize(width, height)
	self.width = width
	self.height = height

	self.map = {}

	for y=1,self.height do
		self.map[y] = {}
		for x=1,self.width do
			self.map[y][x] = Tile:new(0, 1)
		end
	end

end

function MapLayer:getTile(x, y)
	return self.map[y][x]
end

function MapLayer:setTile(x, y, tileIndex, tileset)
	self.map[y][x] = Tile:new(tileIndex, tileset)
end

function MapLayer:fromImageData(data)

  self.width = data:getWidth()
  self.height = data:getHeight()

  self.map = {}

  for y=1,self.height do
    self.map[y] = {}
    for x=1,self.width do
      r, g, b, a = data:getPixel(x-1, y-1)
      index = 0
      if b == 255 then
        index = 5
      end
      if b == 102 then
        index = 4
      end
      if b == 51 then
        index = 3
      end
      if g == 153 and index == 0 then
        index = 2
      end

      if g == 204 then
        index = 0
      end
      if g == 128 then
        index = 1
      end

      if r == 128 then
        index = 7
      end

      self.map[y][x] = Tile:new(index, 1)
    end
  end
end

function MapLayer:randomize()
	for y=1,self.height do
		self.map[y] = {}
		for x=1,self.width do
			self.map[y][x] = Tile:new(math.random(0 ,10), 1)
		end
	end
end

