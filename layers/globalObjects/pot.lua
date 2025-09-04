Pot = Rectangle:extend()

function Pot:new(x,y,spriteScale)
	self.pot = love.graphics.newImage("layers/globalObjects/pot.png")
	Pot.super.new(self,x,y,70*spriteScale,30*spriteScale,1,1,0,false) --group 1 btw

	self.iss = spriteScale --initial spriteScale
	self.spriteScale = spriteScale*forZoomingIn
	self:updateScaling()
end

function Pot:update(dt)
	Pot.super.update(self,dt)
	self:offsetDraw()
end

function Pot:draw()
	love.graphics.draw(self.pot,self.x-self.ofdx,self.y-self.ofdy,nil,self.spriteScale)
end

function Pot:offsetDraw()
	if self.pot ~= nil and self.spriteScale ~= nil then
		self.ofdx = self.pot:getWidth()*self.spriteScale/3
		self.ofdy = (self.pot:getHeight()-10)*self.spriteScale
	end
end

--Unique Functions:
--Special Functions:
function Pot:mousepressed(mx,my,btn)
end

function Pot:mousereleased(mx,my,btn)
end

function Pot:updateScaling()
	Pot.super.updateScaling(self)
	if self.iss ~= nil then
		self.spriteScale = self.iss*forZoomingIn
	end
end

function Pot:drawOutlines()
	Pot.super.drawOutlines(self)
end
