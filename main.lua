
require 'game/dragon_warrior'

--[[
function love.load()
	mapMap = love.image.newImageData('map_world.png')

	map = Map:new()
	map:fromImageData(mapMap)
	map:setupMapView()
	map:setupTileset()
end

]]

function love.load()
	game = DragonWarrior:new()
	game:loadContent()
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	--love.graphics.push()
	--love.graphics.scale(4,4)
	game:draw() -- tell the game to draw scaled content
	--love.graphics.pop()

	game:drawUnscaled() -- draw unscaled content (overlays/menus)
end

function love.quit()
	game:cleanup()
end
