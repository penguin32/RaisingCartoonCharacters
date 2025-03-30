Shit = Rectangle:extend()

function Shit:new(x,y,spriteScale)
	self.shit_1 = love.graphics.newImage("layers/globalObjects/shits/sprites/shit_1.png")
	self:offsetDraw()
	Shit.super.new(self,x,y,50,20,1,1,0,false)--init_scale are wierd
							--so its recommended to not change that for other obj
							--I tried, however i update self:updateScaling
							--move that function on update()
							--it still doesn't update self.w and h as in this
							--iDrawOutlines()
	self.iss = spriteScale--inital sprite scale
	self.spriteScale = spriteScale
	self:updateScaling()
end

function Shit:update(dt)
	Shit.super.update(self,dt)
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
function Shit:slide()

end
--
--function Shit:collideConditions()
--	if #LevelLoader.objects > 0 then
--		for i,v in ipairs(LevelLoader.objects) do
--			if v:is(Mymy) then
--				self:undoCollided(v,0,0)
--			end
--		end
--	end
--end

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
