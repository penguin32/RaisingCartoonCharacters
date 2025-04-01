ShitTrails = FlooredRectangularObject:extend()

function ShitTrails:new(x,y,spriteScale)
	self.shit_1 = love.graphics.newImage("layers/globalObjects/shits/sprites/shitTrails.png")
	self:offsetDraw()
	ShitTrails.super.new(self,x,y,50,20,1,2,0,false)
	self.iss = spriteScale
	self.spriteScale = spriteScale
	self:updateScaling()
end

function ShitTrails:update(dt)
	Shit.super.update(self,dt)
end

function ShitTrails:draw()
	love.graphics.draw(self.shit_1,self.x-self.ofdx,self.y-self.ofdy,nil,self.spriteScale)
end

function ShitTrails:offsetDraw()
	if self.shit_1 ~= nil then
		self.ofdx = self.shit_1:getWidth()*forZoomingIn/8
		self.ofdy = (self.shit_1:getHeight()-100)*forZoomingIn
	end
end

--Unique functions:
--Special functions:
function ShitTrails:updateScaling()
	ShitTrails.super.updateScaling(self)
	self:offsetDraw()
	if self.iss ~= nil then
		self.spriteScale = self.iss*forZoomingIn
	end
end

function ShitTrails:drawOutlines()
	Shit.super.drawOutlines(self)
	love.graphics.rectangle("line",self.x,self.y,self.w,self.h)
end
