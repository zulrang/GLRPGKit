
require 'lib/rect'
require 'lib/utils'
require 'lib/vector2'

Camera = class('Camera')

function Camera:initialize(viewportWidth, viewportHeight, position)
	self.speed = 400
	self.zoomSpeed = 1
	self.zoom = 1
	self.position = position or Vector2:new(0,0)
	self.viewportWidth = viewportWidth
	self.viewportHeight = viewportHeight
end

function Camera:zoomIn(dt)
	self.zoom = self.zoom + self.zoomSpeed * dt
end

function Camera:zoomOut(dt)
	self.zoom = self.zoom - self.zoomSpeed * dt
end

function Camera:lock()
	self.position.x = math.clamp(self.position.x, 0,
		self.lockMaxX - (self.viewportWidth / self.zoom))
	self.position.y = math.clamp(self.position.y, 0,
		self.lockMaxY - (self.viewportHeight / self.zoom))
end

function Camera:getMousePos()
	return (self.position.x) + love.mouse.getX() / self.zoom, (self.position.y) + love.mouse.getY() / self.zoom
end

function Camera:update(dt)

	motion = Vector2:new(0,0)

	if love.keyboard.isDown("right") then
		motion.x = self.speed
	end

	if love.keyboard.isDown("left") then
		motion.x = -self.speed
	end

	if love.keyboard.isDown("up") then
		motion.y = -self.speed
	end

	if love.keyboard.isDown("down") then
		motion.y = self.speed
	end

	if love.keyboard.isDown("1") then
		self.zoom = 1
	end

	if love.keyboard.isDown("2") then
		self.zoom = 2
	end

	if love.keyboard.isDown("3") then
		self.zoom = 3
	end

	if love.keyboard.isDown("4") then
		self.zoom = 4
	end

	if love.keyboard.isDown("=") then
		self.zoomIn(dt)
	end

	if love.keyboard.isDown("-") then
		self.zoomOut(dt)
	end

	motion:normalize()

	self.position = self.position + motion * self.speed * dt
	self:lock()
end
