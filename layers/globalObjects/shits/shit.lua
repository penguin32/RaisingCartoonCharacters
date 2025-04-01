Shit = Rectangle:extend()
---i want to implement rectangleCOllider here.

function Shit:new(x,y,spriteScale)
	self.shit_1 = love.graphics.newImage("layers/globalObjects/shits/sprites/shit_1.png")
	self:offsetDraw()
				      --group, below letter g
	Shit.super.new(self,x,y,50,20,1,1,0,false)--init_scale are wierd
							--so its recommended to not change that for other obj
							--I tried, however i update self:updateScaling
							--move that function on update()
							--it still doesn't update self.w and h as in this
							--iDrawOutlines()
	self.iss = spriteScale--inital sprite scale
	self.spriteScale = spriteScale
	self:updateScaling()

--	self.svx = 1 --scale vector x, becomes either negative or positive and it is used in bounce function
--	self.svy = 1 -- Shit:slide()
end

function Shit:update(dt)
	Shit.super.update(self,dt)
	self:slide(dt,2,-1,50,self:trails())
			--(change in time,			dt
			--group highest but not equal to,	gh
			--group lowest but not equal to)	gl
			--friction				f
			--function				doStuff
	--i made shitTrails.lua to be at group 2 so that it doesn't collide with anything else
end

function Shit:draw()
	love.graphics.draw(self.shit_1,self.x-self.ofdx,self.y-self.ofdy,nil,self.spriteScale)
end

function Shit:offsetDraw() -- kinda like updateScalingSprite()
	if self.shit_1 ~= nil then
		self.ofdx = self.shit_1:getWidth()*forZoomingIn/8
		self.ofdy = (self.shit_1:getHeight()-100)*forZoomingIn
	end
end

--Unique functions:
function Shit:trails()
	if math.floor(self.v) > 100 then
	table.insert(LevelLoader.objects,ShitTrails(self.dx,self.dy,self.iss))
	end
end
--Special functions:
function Shit:updateScaling()
	Shit.super.updateScaling(self)
	self:offsetDraw()
	if self.iss ~= nil then
		self.spriteScale = self.iss*forZoomingIn
	end
end

function Shit:drawOutlines()
	Shit.super.drawOutlines(self)
	love.graphics.rectangle("line",self.x,self.y,self.w,self.h)
end
