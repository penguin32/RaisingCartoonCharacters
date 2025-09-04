Cursor = Circle:extend()
Cursor:implement(SimpleMovement)

function Cursor:new(x,y,spriteScale)
	--self.Cursor = love.graphics.newImage()
	--			x,y,velocity,radius,init_scale,group,gameDev
	Cursor.super.new(self,x,y,100,15,1,1,false)
	self.iss = spriteScale
	self.spriteScale = spriteScale*forZoomingIn
	self:updateScaling()
end

function Cursor:update(dt)
	Cursor.super.update(self,dt)
--	self:offsetDraw()
	self:Follow(dt,self.x,self.y,cursor.x,cursor.y)
end

function Cursor:draw()
	--draw image sprite here
end
--function Cursor:offsetDraw()

--Unique Functions:
--Special Functions:
function Cursor:mousepressed(mx,my,btn)
end

function Cursor:mousereleased(mx,my,btn)
end

function Cursor:updateScaling()
	Cursor.super.updateScaling(self)
	if self.iss ~= nil then
		self.spriteScale = self.iss*forZoomingIn
	end
end

function Cursor:drawOutlines()
	Cursor.super.drawOutlines(self)
end
