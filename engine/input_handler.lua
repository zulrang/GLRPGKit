
require 'engine/middleclass'
require 'engine/game_component'

InputHandler = class('InputHandler', GameComponent)

function InputHandler:update(dt)
	if love.keyboard.isDown("escape") then
		love.event.push("quit")
	end
end
