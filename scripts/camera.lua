Camera = SimpleMovement:extend() -- View game's environment, like not used in mainmenu, see levelLoader.lua

function Camera:new(x,y,velocity)
	Camera.super.new(self,x,y,velocity)
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
--	love.graphics.circle("line",self.base_x,self.base_y,20)

--	I need a rectangled that follows game.middleX&Y, it'll be the camera's viewport
--	love.graphics.setColor(0,100,0)
	--okay im a test this shit if i could contain(as collider) this inside layer1
--	local adjust = 30
--	love.graphics.rectangle("line",game.cartX+adjust,game.cartY+adjust,window.width-game.cartX*2-adjust*2,window.height-game.cartY*2-adjust*2)
--	Okay, this rectangle is perfect!, now i just have to attach this to self.x and self.y
end
