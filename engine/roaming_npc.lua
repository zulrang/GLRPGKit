
require 'engine/entity'

RoamingNpc = class('RoamingNpc', Entity)

function RoamingNpc:initialize(tileMap, mapPosition, sprite, quad)
	Entity.initialize(self, tileMap, mapPosition, sprite, quad)
	self.roamSec = math.random(1, 5)
	self.roamTimer = 0
	self.speed = math.random(40,120)
end

function RoamingNpc:idleUpdate(dt)

	if not self.isMoving then
		-- only roam if we're not moving

		self.roamTimer = self.roamTimer + dt

		if self.roamTimer > self.roamSec then

			-- reset roam timer
			self.roamTimer = 0

			-- pick random direction 
			dir = math.random(1,4)

			motion = Vector2:new(0,0)

			if dir == 1 then
				motion.x = 1
				self:move(motion)
			elseif dir == 2 then
				motion.x = -1
				self:move(motion)
			elseif dir == 3 then
				motion.y = -1
				self:move(motion)
			elseif dir == 4 then
				motion.y = 1
				self:move(motion)
			end

		end

	end

	Entity.idleUpdate(self, dt)

end

function RoamingNpc:draw()

	Entity.draw(self)
end

