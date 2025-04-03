ShitTrails = FlooredRectangularObject:extend()

function ShitTrails:new(x,y,spriteScale)
	self.shit_1 = love.graphics.newImage("layers/globalObjects/shits/sprites/shitTrails.png")
	ShitTrails.super.new(self,x,y,100*spriteScale,100*spriteScale,1,-1,0,false) --collider
	self.iss = spriteScale
	self.spriteScale = spriteScale
	self:updateScaling()
end

function ShitTrails:update(dt)
	Shit.super.update(self,dt)
	self:offsetDraw()
--	self:updateScaling()
end

function ShitTrails:draw()
	love.graphics.draw(self.shit_1,self.x-self.ofdx,self.y-self.ofdy,nil,self.spriteScale)
end

function ShitTrails:offsetDraw()
	if self.shit_1 ~= nil and self.spriteScale ~= nil then
		self.ofdx = self.shit_1:getWidth()*self.spriteScale/3
		self.ofdy = (self.shit_1:getHeight())*self.spriteScale
	end
end

--Unique functions:
--Special functions:
function ShitTrails:updateScaling()
	ShitTrails.super.updateScaling(self)
--	self:offsetDraw()
	if self.iss ~= nil then
		self.spriteScale = self.iss*forZoomingIn
	end
end

function ShitTrails:drawOutlines()
	Shit.super.drawOutlines(self)
end
