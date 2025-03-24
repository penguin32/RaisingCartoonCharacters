Camera = SimpleMovement:extend() -- View game's environment, like not used in mainmenu, see levelLoader.lua

function Camera:new(base_x,base_y,base_v)
	Camera.super.new(self,base_x,base_y,base_v)
end

function Camera:update(dt)
	Camera.super.update(self,dt,game.middleX,game.middleY,cursor.x,cursor.y)
end

function Camera:draw()
end

--Special Functions:
function Camera:mousepressed(mx,my,btn)
end

function Camera:mousereleased(mx,my,btn)
end

function Camera:updateScaling()
	Camera.super.updateScaling(self)
end

function Camera:drawOutlines()
	Camera.super.drawOutlines(self)
end
