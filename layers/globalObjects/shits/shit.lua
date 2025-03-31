Shit = Rectangle:extend()

function Shit:new(x,y,spriteScale)
	self.shit_1 = love.graphics.newImage("layers/globalObjects/shits/sprites/shit_1.png")
	self:offsetDraw()
	Shit.super.new(self,x,y,50,20,1,2,0,false)--init_scale are wierd
							--so its recommended to not change that for other obj
							--I tried, however i update self:updateScaling
							--move that function on update()
							--it still doesn't update self.w and h as in this
							--iDrawOutlines()
	self.iss = spriteScale--inital sprite scale
	self.spriteScale = spriteScale
	self:updateScaling()

	self.svx = 1 --scale vector x, becomes either negative or positive and it is used in bounce function
	self.svy = 1 -- Shit:slide()
end

function Shit:update(dt)
	Shit.super.update(self,dt)
	self:slide(dt)
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
function Shit:slide(dt)
	--player/npc already interact with this class
	--now im just adding what it can do about it, and that function is gonna be called here
	--Important to know this for future me tryna revisit shit,
	--self.group is very important as it affect conditions which rectangularCollider.lua is applied.
	if #LevelLoader.objects > 0 then -- bounce off npc/players
		for i,v in ipairs(LevelLoader.objects) do
			if v:is(Character) then
				for j,w in ipairs(self.ids) do
					if w == v.id then
						self.v = self.v + v.v*dt
						self.svx,self.svy = Direction.GetVector(v.dx,v.dy,self.dx,self.dy)
					end
				end
			end
		end
	end
	--instead of checking if object is collided == true,
	--i'll just check the list of colliding objects self.ids, and compare their id's to their list of ids
	--if its equal, then that means they're collided
	if #LevelLoader.objects > 0 then --bounce off walls
		for i,v in ipairs(LevelLoader.objects) do
			if v:is(Rectangle) and (v.group == 0 or v.group == 1) then
				for j,w in ipairs(self.ids) do
					if w == v.id then
						self:Walls(v,0,0)
						self:knowWhatSide(v,0,0)
						--must run only once so,
						--table.remove(self.ids,j)
					end
				end
			end
		end
	end
	if #LevelLoader.objects > 0 then
		for i,v in ipairs(LevelLoader.objects) do
			if v:is(Rectangle) and (v.group == 0 or v.group == 1) then
				self:setCollided(v,0,0) --just like mymy --> shit,
				-- for this one, its shit --> walls.
			end
		end
	end
	if self.v > 0 then
		self.dx = self.dx + self.v*self.svx*dt
		self.dy = self.dy + self.v*self.svy*dt
		self.v = self.v - 5*dt --friction like :D
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
