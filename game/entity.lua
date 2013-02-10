
Entity = class('Entity')

function Entity:initialize(tileMap, mapPosition, sprite, quad)
	self.tileMap = tileMap
	self.mapPosition = mapPosition
	self.position = Vector2(tileMap.tileSize * mapPosition.x, tileMap.tileSize * mapPosition.y)

	self.speed = 80 -- animation speed'
	self.camera = false
	self.isMoving = false

	self.sprite = sprite
	self.quad = quad

end

function Entity:draw(x, y)
	love.graphics.drawq(self.sprite, self.quad, x, y)
end

function Entity:addCamera(camera)
	self.camera = camera
end

function Entity:idleUpdate(dt)

end
