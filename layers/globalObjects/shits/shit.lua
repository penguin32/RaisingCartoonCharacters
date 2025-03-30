Shit = Rectangle:extend()

function Shit:new(x,y,init_scale)
	self.shit_1 = love.graphics.newImage("layers/globalObjects/shits/sprites/shit_1.png")
--	self.ofdx = self.shit_1:getWidth()*forZoomingIn/2
--	self.ofdy = self.shit_1:getHeight()*forZoomingIn
	self:offsetDraw()
	Shit.super.new(self,x,y,50,25,init_scale,true,1,false)
end

function Shit:update(dt)
	Shit.super.update(self,dt)
end

function Shit:draw()
	love.graphics.draw(self.shit_1,self.x-self.ofdx,self.y-self.ofdy,nil,self.scale)
end

function Shit:offsetDraw() -- kinda like updateScalingSprite()
	if self.shit_1 ~= nil and self.scale ~= nil then
		self.ofdx = (self.shit_1:getWidth()-self.shit_1:getWidth()/1.4)*self.scale
		self.ofdy = self.shit_1:getHeight()*self.scale
	end
end

--Unique functions:
--Special functions:
function Shit:updateScaling()
	Shit.super.updateScaling(self)
	self:offsetDraw()
end

function Shit:drawOutlines()
	love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
end
