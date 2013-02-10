
Entity = class('Entity')

function Entity:initialize(tileMap, mapPosition, sprite, quad)
	self.tileMap = tileMap
	self.mapPosition = mapPosition
	self.position = Vector2(tileMap.tileSize * (mapPosition.x-1), tileMap.tileSize * (mapPosition.y-1))

	self.speed = 80 -- animation speed'
	self.camera = false
	self.isMoving = false

	self.sprite = sprite
	self.quad = quad

end

function Entity:draw()
	love.graphics.drawq(self.sprite, self.quad, self.position.x, self.position.y)
end

function Entity:addCamera(camera)
	self.camera = camera
end

function Entity:move(motion)
	newMapPosition = self.mapPosition + motion

	if self.tileMap:checkPassable(newMapPosition.x, newMapPosition.y) then
		self.isMoving = true;
		self.direction = motion
		self.mapPosition = newMapPosition
		self.distanceToMove = self.tileMap.tileSize

		return true
	end

	return false
end

function Entity:idleUpdate(dt)

	if self.isMoving then
		if self.distanceToMove > 0 then
			motion = self.speed * dt
			if motion > self.distanceToMove then
				motion = self.distanceToMove
			end
			self.distanceToMove = self.distanceToMove - motion
			self.position = self.position + self.direction * motion
		else
			self.position = Vector2(self.tileMap.tileSize * (self.mapPosition.x-1), 
				self.tileMap.tileSize * (self.mapPosition.y-1))
			self.isMoving = false
			self.distanceToMove = 0
		end

		-- while we're moving, and a camera is attached, lock camera to ourself
		if self.camera then

			self.camera.position.x = 
				self.position.x -- position of player
				+ (self.tileMap.tileSize / 2) -- plus half the size of the sprite
				- ((self.camera.viewportWidth / self.camera.zoom) / 2) -- minus half the size of the viewport

			self.camera.position.y = 
				self.position.y -- position of player
				+ (self.tileMap.tileSize / 2) -- plus half the size of the sprite
				- ((self.camera.viewportHeight / self.camera.zoom) / 2) -- minus half the size of the viewport

			self.camera:lock()

		end

	end


end
