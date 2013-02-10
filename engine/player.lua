
require 'game/entity'

Player = class('Player', Entity)

function Player:idleUpdate(dt)

	motion = Vector2:new(0,0)

	if not self.isMoving then

		if love.keyboard.isDown("d") then
			motion.x = 1
			self:move(motion)
		elseif love.keyboard.isDown("a") then
			motion.x = -1
			self:move(motion)
		elseif love.keyboard.isDown("w") then
			motion.y = -1
			self:move(motion)
		elseif love.keyboard.isDown("s") then
			motion.y = 1
			self:move(motion)
		end

	end

	Entity.idleUpdate(self, dt)

end

