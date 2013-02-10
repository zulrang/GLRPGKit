
require 'engine/middleclass'
require 'engine/tile'
require 'engine/drawable_game_component'

Map = class('Map', DrawableGameComponent)

function Map:updateTilesetBatch()
  self.tilesetBatch:clear()
  for x=0, self.tilesDisplayWidth-1 do
    for y=0, self.tilesDisplayHeight-1 do
      self.tilesetBatch:addq(self.tileQuads[self.map[x+math.floor(self.mapX)][y+math.floor(self.mapY)].index],
        x*self.tileSize, y*self.tileSize)
    end
  end
end

function Map:setupMapView()
  self.mapX = 1
  self.mapY = 1
  self.tilesDisplayWidth = 52
  self.tilesDisplayHeight = 40
  
  self.zoomX = 4
  self.zoomY = 4
end

-- central function for moving the map
function Map:moveMap(dx, dy)
  self.oldMapX = self.mapX
  self.oldMapY = self.mapY
  self.mapX = math.max(math.min(self.mapX + dx, self.mapWidth - self.tilesDisplayWidth), 1)
  self.mapY = math.max(math.min(self.mapY + dy, self.mapHeight - self.tilesDisplayHeight), 1)
  -- only update if we actually moved
  if math.floor(self.mapX) ~= math.floor(self.oldMapX) or math.floor(self.mapY) ~= math.floor(self.oldMapY) then
    self:updateTilesetBatch()
  end
end

function Map:draw()
  -- love.graphics.draw(self.backgroundImage, 64, 64, 0, 800/48, 600/1300)
  --love.graphics.drawq(self.tilesetImage, self.tileQuads[1], 0, 0)
  --love.graphics.drawq(self.tilesetImage, self.tileQuads[2], 16, 0)
  --love.graphics.drawq(self.tilesetImage, self.tileQuads[3], 32, 0)

  love.graphics.draw(self.tilesetBatch,
    math.floor(-self.zoomX*(self.mapX%1)*self.tileSize), math.floor(-self.zoomY*(self.mapY%1)*self.tileSize),
    0, self.zoomX, self.zoomY)

end

function Map:update(dt)

  if love.keyboard.isDown("up")  then
    -- self:moveMap(0, -0.8 * self.tileSize * dt)
    self:moveMap(0, -1/self.tileSize)
  end
  if love.keyboard.isDown("down")  then
    -- self:moveMap(0, 0.8 * self.tileSize * dt)
    self:moveMap(0, 1/self.tileSize)
  end
  if love.keyboard.isDown("left")  then
    -- self:moveMap(-0.8 * self.tileSize * dt, 0)
    self:moveMap(-1/self.tileSize, 0)
  end
  if love.keyboard.isDown("right")  then
    -- self:moveMap(0.8 * self.tileSize * dt, 0)
    self:moveMap(1/self.tileSize, 0)
  end

end

function Map:setupTileset()

  self.backgroundImage = love.graphics.newImage("content/Background_0.png")

  self.tilesetImage = love.graphics.newImage("content/tiles_overworld.png")
  self.tilesetImage:setFilter("nearest", "nearest")
  self.tileSize = 16
  self.tilesetImageWidth = self.tilesetImage:getWidth()
  self.tilesetImageHeight = self.tilesetImage:getHeight()

  self.tileQuads = {}

  for x=0,(self.tilesetImageWidth/self.tileSize) do
    for y=0,(self.tilesetImageHeight/self.tileSize) do
      self.tileQuads[(y*x)+x] = love.graphics.newQuad(x * (self.tileSize), y * (self.tileSize), 
        self.tileSize, self.tileSize, self.tilesetImageWidth, self.tilesetImageHeight)
    end
  end

  self.tilesetBatch = love.graphics.newSpriteBatch(self.tilesetImage, self.tilesDisplayWidth * self.tilesDisplayHeight)
  self:updateTilesetBatch()
end

function Map:fromImageData(data) 

  self.mapWidth = data:getWidth()
  self.mapHeight = data:getHeight()

  self.map = {}
  for x=1,self.mapWidth do
    self.map[x] = {}
    for y=1,self.mapHeight do
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

      self.map[x][y] = Tile:new(index, true)
    end
  end
end

function Map:random(mapWidth, mapHeight)

  rowHeight = mapHeight / 3
  self.mapWidth = mapWidth
  self.mapHeight = mapHeight

  self.map = {}
  for x=1,self.mapWidth do
    self.map[x] = {}
    rowHeight = rowHeight + math.random(-1,1)
    for y=1,self.mapHeight do
    	if y > rowHeight then
      		self.map[x][y] = Tile:new(math.random(1,3), true)
      	else
      		self.map[x][y] = Tile:new(0, true)
      	end
    end
  end

end
