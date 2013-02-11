
menu = {}
character = Character:new("Zulrang")

function menu:load()


end

function menu:update(dt)
	if love.keyboard.isDown("escape") then
		love.event.push("quit")
	end
end

function menu:drawUnscaled()

end

function menu:draw()

end



function love.load()
	love.graphics.setFont(love.graphics.newFont("content/pf_tempesta_7_xb.ttf",8))
	menu:load()
end


function love.update(dt)
	menu:update(dt)
end

function love.draw()
	love.graphics.push()
	love.graphics.scale(4,4)
	menu:draw() -- tell the game to draw scaled content
	love.graphics.pop()

	menu:drawUnscaled() -- draw unscaled content (overlays/menus)
end

function love.quit()
end
