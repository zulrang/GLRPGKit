
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
