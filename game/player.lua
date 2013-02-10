
require 'game/entity'

Player = class('Player', Entity)

function Player:idleUpdate(dt)

	motion = Vector2:new(0,0)

	if not self.isMoving then

		if love.keyboard.isDown("d") then
			motion.x = 1
			self.isMoving = true;
		elseif love.keyboard.isDown("a") then
			motion.x = -1
			self.isMoving = true;
		elseif love.keyboard.isDown("w") then
			motion.y = -1
			self.isMoving = true;
		elseif love.keyboard.isDown("s") then
			motion.y = 1
			self.isMoving = true;
		end

		if self.isMoving then
			self.direction = motion
			self.mapPosition = self.mapPosition + motion
			self.distanceToMove = self.tileMap.tileSize
		end
	end

	if self.isMoving then
		if self.distanceToMove > 0 then
			motion = self.speed * dt
			self.distanceToMove = self.distanceToMove - motion
			self.position = self.position + self.direction * motion
		else
			self.position = Vector2(self.tileMap.tileSize * self.mapPosition.x, 
				self.tileMap.tileSize * self.mapPosition.y)
			self.isMoving = false
			self.distanceToMove = 0
		end

		if self.camera then

			self.camera.position.x = 
				self.position.x -- position of player
				+ (self.tileMap.tileSize / 2) -- plus half the size of the sprite
				- (self.camera.viewportRect.width / 2) -- minus half the size of the viewport

			self.camera.position.y = 
				self.position.y -- position of player
				+ (self.tileMap.tileSize / 2) -- plus half the size of the sprite
				- (self.camera.viewportRect.height / 2) -- minus half the size of the viewport

			self.camera:lock(self.tileMap.pixelWidth, self.tileMap.pixelHeight)

			self.tileMap:updateTilesetBatch(self.camera)
		end

	end


end

