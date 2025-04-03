Shit = Rectangle:extend()
---i want to implement rectangleCOllider here.

function Shit:new(x,y,spriteScale)
	self.shit_1 = love.graphics.newImage("layers/globalObjects/shits/sprites/shit_1.png")
				      			      --group, below letter g
	Shit.super.new(self,x,y,70*spriteScale,30*spriteScale,1,2,0,false)--init_scale are wierd
	--your collider					--so its recommended to not change that for other obj
	--which explains why init_scale is set to 1	--I tried, however i update self:updateScaling
							--move that function on update()
							--it still doesn't update self.w and h as in this
							--iDrawOutlines()
	self.iss = spriteScale--inital sprite scale
	self.spriteScale = spriteScale*forZoomingIn
	self:updateScaling()
--	self:offsetDraw()

--	self.svx = 1 --scale vector x, becomes either negative or positive and it is used in bounce function
--	self.svy = 1 -- Shit:slide()
	self.timer = 0 --timer for shit trails
end

function Shit:update(dt)
	Shit.super.update(self,dt)
	self:slide(dt,3,-1,50,self:trails(dt))
			--(change in time,			dt
			--group highest but not equal to,	gh
			--group lowest but not equal to)	gl
			--friction				f
			--function				doStuff
	--i made shitTrails.lua to be at group -1 so that it doesn't collide with anything else
	--		so negative values for objects drawn on floors like blood or vomits or carpets.
--	self:updateScaling()
	self:offsetDraw()
end

function Shit:draw()
	love.graphics.draw(self.shit_1,self.x-self.ofdx,self.y-self.ofdy,nil,self.spriteScale)
end

function Shit:offsetDraw() -- kinda like updateScalingSprite()
	if self.shit_1 ~= nil and self.spriteScale~= nil then
		self.ofdx = self.shit_1:getWidth()*self.spriteScale/3
		self.ofdy = (self.shit_1:getHeight()-10)*self.spriteScale
		--offset change in self.x
	end
end

--Unique functions:
function Shit:trails(dt)
	if math.floor(self.v) > 25 and self.timer > 0.5 then
		table.insert(LevelLoader.objects,ShitTrails(self.dx,self.dy,self.iss/2))
		self.timer = 0
	end
	self.timer = self.timer + dt
end

--Special functions:
function Shit:updateScaling()
	Shit.super.updateScaling(self)
--	self:offsetDraw()
	if self.iss ~= nil then
		self.spriteScale = self.iss*forZoomingIn
	end
end

function Shit:drawOutlines()
	Shit.super.drawOutlines(self)
end
