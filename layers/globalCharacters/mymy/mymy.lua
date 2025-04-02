--// in LevelLoader.lua
--SortObject()
--	Character classes are treated as Circle classes by default
--	now that i have a kind of Character that is a rectangle, should have treated it
--	as rectangle for now in that sorting function.,
--	nope, ill just extend any character like a circle class for no....
--	no again, extend it as Character class, then give it circle attributes for SortObj
--	treating it like a circle, but we know for now this Mymy inherits RectangleCollider for now.

Mymy = Character:extend()
Mymy:implement(RectangleCollider)
Mymy:implement(BabyMymy)

function Mymy:new(x,y,velocity,init_scale,action,gameDev)
--	self.gameDev = gameDev or false--to differentiate with other npc when testing with multiple chars
						--during colliders test
	Mymy.super.new(self,x,y,velocity,1,gameDev)
	self:loadImgSprite(init_scale)
	self.action = action or 0 --if 0, it means no action will be acted.
end

function Mymy:update(dt)
	Mymy.super.update(self,dt)
	self:ugCollider()
	self:gCollider()

	--action belows are from inherited types:
	--like babyMymy, they will be called here.

	--action belows are from Character/SimpleMovement:
	--which are commonly use by other objects that are "character types"
--	Mymy.super.selectAction(self,dt,self.action) -- huh, just learn now that i can just call it straight from
						--	the root (SimpleMovement)
	if self.action == 1 then
		Mymy.super.RandomWalks(self,dt,0.5)
	end
end

function Mymy:draw()
	self:drawSprite()	--you can implement only 1 character(babyMymy.lua) from  spritesInherit
				--and it will call this function, assuming their names for drawing sprites
				--are the same.
end

--Unique functions:
function Mymy:ugCollider()--unscaled ground collider, for now, simple game, so rectangle for that
	self.init_w = 130
	self.init_h = 40
	self.odx = -1*(self.init_w-self.init_w/2)--offset dx , (not a coordinate, thats length)
	self.ody = (self.init_h-self.init_h/2) -- rewrite later this thing, some of odx is redundant
	if #LevelLoader.objects > 0 then
		for i,v in ipairs(LevelLoader.objects) do
			if v:is(Shit) then--simple collision check, unsure, what
				--gonna happen if there's two npc
				self:setCollided(v,self.odx,self.ody)
			elseif v:is(Rectangle) and (v.group == 0 or v.group == 1) then
				self:setCollided(v,self.odx,self.ody) -- added because
									--properties, use for RandomWalk()
				--group 0, usually walls for camera,
				--group 1 walls for objects like this

				for j,w in ipairs(self.ids) do
					if w == v.id then
						self:Walls(v,self.odx,self.ody)
						self:knowWhatSide(v,self.odx,self.ody)
					end
				end
--				if self.collided == true then
--					self:knowWhatSide(v,self.odx,self.ody)
--				end
			end
		end
	end
end

function Mymy:gCollider()	--ground collider, but scaled for drawing
	self.ox = self.x+self.odx*forZoomingIn	--offset x, (a new coordinate, that's offsetted)
	self.oy = self.y-self.ody*forZoomingIn
	self.w = self.init_w*forZoomingIn
	self.h = self.init_h*forZoomingIn
end

--Special functions:
function Mymy:mousepressed(mx,my,btn)
end

function Mymy:mousereleased(mx,my,btn)
end

function Mymy:updateScaling()
	Mymy.super.updateScaling(self) -- i should probably edit that simpleMovement.lua
	self:updateScalingSprite() --similar to Mymy:draw()
end

function Mymy:drawOutlines()
	love.graphics.setColor(0,100,1)
	love.graphics.rectangle("line",self.ox,self.oy,self.w,self.h)
	love.graphics.setColor(0,0,0)
	love.graphics.print("dx,dy :"..self.dx.." , "..self.dy,self.ox,self.oy)
	love.graphics.print("collided: "..tostring(self.collided),self.ox,self.oy+30)
	love.graphics.print("collision: "..#self.ids,self.ox,self.oy+60)
--	love.graphics.print("seed: "..self.id,self.ox,self.oy+90)

end
