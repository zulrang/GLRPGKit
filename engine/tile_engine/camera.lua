
require 'lib/rect'
require 'lib/utils'
require 'lib/vector2'

Camera = class('Camera')

function Camera:initialize(rect, position)
	self.speed = 400
	self.zoom = 1
	self.position = position or Vector2:new(0,0)
	self.viewportRect = rect
end

function Camera:lock(maxX, maxY)
	self.position.x = math.clamp(self.position.x, 0,
		maxX * self.zoom - self.viewportRect.width)
	self.position.y = math.clamp(self.position.y, 0,
		maxY * self.zoom - self.viewportRect.height)
end
