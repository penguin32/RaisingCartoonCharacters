Camera = SimpleMovement:extend() -- View game's environment, like not used in mainmenu, see levelLoader.lua
				--rememeber that this is added at LevelLoader.objects
				--that means objects is getting translated respect to it.
				--so making UI, should be outside that pop()
Camera:implement(RectangleCollider)

function Camera:new(x,y,velocity)
	Camera.super.new(self,x,y,velocity,2,true)
	self.screen = {} --viewport's scaled variable for drawOutlines, testing
				--I don't need this, remove later
				--nah just leave that, it the scaled version of self.init_h,init_w for
				--camera collisions, so that we may see them.
	self.tcv = {	--tc,tap count variables
		Follow=false,-- that action Follow()
		mlatch=true,
		mlatch2=false
	}
	--table.insert(LevelLoader.ui,Options())
	self.options = 0 --to add only single of this object
	--there should only be 1 running object like "Options()" when camera's SimpleMovement is stopped
	--but i could also use this variable at selecting which UIs should I run aside from Options() kind
	--
	--example here is self.options = 0, that means no Options() has been added
	--setting it 1 after it has been added
	--if the camera is moving aka "self.tcv.Follow" then it will remove the Options()
	--and set it to 0 zero,
	--the reason behind this is the update() function tends to run unless it was told to stop
	--so it need to be told that the object has been removed by this method so that it doesn't
	--repeatedly keep on adding objects or keep on running extra loops looking for Options() objects
	--that has already been removed.
end

function Camera:update(dt)
	Camera.super.update(self,dt)
	self:viewport()
	self:uviewport()
	self.tcv.Follow,self.tcv.mlatch,self.tcv.mlatch2=latch(Player.Mouse.ptapCount==3 and Player.Mouse.timer<0,self.tcv.mlatch,self.tcv.mlatch2,self.tcv.Follow)
	if self.tcv.Follow then
		self:Follow(dt,game.middleX,game.middleY,cursor.x,cursor.y)
		if self.options == 1 then
			for i,v in ipairs(LevelLoader.ui) do --to disable options
				if v:is(Options) then
					for j,k in ipairs(v.list) do
						if k.magnitude > 0 and k.ssm then
							k.magnitude = k.magnitude - v.mov*dt
						else
							table.remove(LevelLoader.ui,i)
							self.options = 0
						end
					end
--					table.remove(LevelLoader.ui,i)
--					self.options = 0
				end
			end
		end
	else
		if self.options == 0 then
			table.insert(LevelLoader.ui,Options())
			self.options = 1
		end--if I want to change what pops out the UI when the players stop moving
		--I just have to change self.options value here, and the ability to undo it same as above
		--								the if-statements
	end
end

function Camera:draw()
end

--Unique Functions:
function Camera:uviewport() -- unscaled coordinates, renamed for RectangleCollider inherits.
			--its unscaled, because we'd want our collisions functions to have an easier time.
			--talk about collisions, this is what we want.
	local adjust = 4
	--dx,dy, (checked) SimpleMovement already has it
	self.ox = -1*(game.width-game.width/2)/adjust
	self.oy = (game.height-game.height/2)/adjust	-- i gotta rename variables 
	self.init_w = game.width/adjust			--follow mymy.lua
	self.init_h = game.height/adjust
	if #LevelLoader.objects > 0 then
		for i,v in ipairs(LevelLoader.objects) do
			if v:is(Rectangle) and v.group == 0 then
				self:Walls(v,self.ox,self.oy)
			end
		end
	end
end

function Camera:viewport()--updates scaling viewport's window view affected by layer's wall.
	local adjust = 4	--test: for drawOutlines(),
			--nvm, this part is actually handful in showing scaled drawing for collision,
			--	(dont remove this)
			--	nvm, i really dont need a specific table for this, fix this later too
	self.screen.x = self.x-forZoomingIn*(game.width-game.width/2)/adjust -- i really gotta stay consitent
		--what the hell, screen.x when multiplied by negative forZoomingIn, it works,
		--but unlike mymylua, has opposite situation for that specific signage, 
		--need check on this part!
	self.screen.y = self.y-forZoomingIn*(game.height-game.height/2)/adjust -- change this later!
	self.screen.w = game.width*forZoomingIn/adjust		---no,no i think this is important for
	self.screen.h = game.height*forZoomingIn/adjust		--drawing with scaled offset
end -- i dont know how to lock the camera inside a box and stop forZoomingIn scaling if collided returns true
	--so ill just put wall() collision on that thing, to lock the player within the playground.

--Special Functions:
function Camera:mousepressed(mx,my,btn)
end

function Camera:mousereleased(mx,my,btn)
end

function Camera:updateScaling()
	Camera.super.updateScaling(self)
end

function Camera:drawOutlines() 
	Camera.super.drawOutlines(self)
--	love.graphics.circle("line",self.base_x,self.base_y,20)

--	I need a rectangled that follows game.middleX&Y, it'll be the camera's viewport
--	love.graphics.setColor(0,100,0)
	--okay im a test this shit if i could contain(as collider) this inside layer1
--	local adjust = 30
--	love.graphics.rectangle("line",game.cartX+adjust,game.cartY+adjust,window.width-game.cartX*2-adjust*2,window.height-game.cartY*2-adjust*2)
--	Okay, this rectangle is perfect!, now i just have to attach this to self.x and self.y
	love.graphics.setColor(0,0,1)
	love.graphics.rectangle("line",self.screen.x,self.screen.y,self.screen.w,self.screen.h)
end
