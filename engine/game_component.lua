
require 'engine/middleclass'
require 'lib/utils'

GameComponent = class('GameComponent')

function GameComponent:initialize()
	self.isDrawable = false
	self.id = generateId()
end

function GameComponent:update(dt)

end

