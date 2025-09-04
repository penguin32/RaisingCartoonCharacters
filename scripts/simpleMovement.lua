--// what if i create a scale of a unit vector(that origin.x origin.y to a 1 unit) get their ratio, then scale,
--that instead for dx dy (changing x and y)
--basically multiplying forZoomingIn*by 1, it make sense, but it doesnt make sense at the same time >:(

SimpleMovement = Object:extend()

function SimpleMovement:new(x,y,velocity,group,gameDev)
	self.gameDev = gameDev or false
	self.group = group or 0
	self.x = x or 0  --see layer 1 for explanations, and control.lua near Player.Viewport
	self.y = y or 0
	self.dx = x or 0
	self.dy = y or 0
	self.v = velocity or 35	--as minimum initial velocity
	self.wo_to_dx = x - origin.x
	self.wo_to_dy = y - origin.y
--//Replaced:
--base_x as dx
--base_y as dy
--base_v as v
	self:updateScaling() --Okay, they need to be called,
			-- because updateScaling, generally runs only
			-- during a change in a variable named "newForZoomingIn"
			-- by doing so it "declared the variables first"
			-- and for that, doesn't break.
	self:updateCoordinates()
---random walk attributes:
		self.rwalk = false -- random walk
		self.frwalk = 0.5 --frequency random walk, higher == less frequent, lower value == more frequent
		self.walkTime = 2	--time amount of stopping
		self.rstop = 2		--time amount walking
			--yes, variable name is unconventional, but
			--	it helped me write that function, and because of that,
			--	i rather not have change it, because its more understandable when
			--	trying to read the conditional statements,
			--	very bad excuse, but im in a time contrainst, deadline ya see...
		self.rradian = 0 --random radians
		self.rux = 0 --random unit vector x
		self.ruy = 0 --random unit vector y
		self.svx,self.svy = 1,1
end

function SimpleMovement:update(dt)
	self:updateCoordinates()
end

function SimpleMovement:updateCoordinates()
	self.wo_to_dx = self.dx - origin.x
	self.wo_to_dy = self.dy - origin.y
	self.x = self.wo_to_dx*forZoomingIn
	self.y = self.wo_to_dy*forZoomingIn
end

--Unique functions:
function SimpleMovement:Follow(dt,animal_x,animal_y,food_x,food_y) -- i could reuse this to follow other else.
				--when called, this object will follow the targetted object,
				-- up to a certain point.--that would be base_dai "idle area"
	self.base_cfd = Direction.GetDistance(animal_x,animal_y,food_x,food_y)
	self.base_cos,self.base_sin = Direction.GetVector(animal_x,animal_y,food_x,food_y)
	if self.base_cfd > self.base_dai and self.base_cfd < self.base_damv then
		self.dx = self.dx + (self.v*self.base_cos*(self.base_cfd/50*gsr)*dt)
		self.dy = self.dy + (self.v*self.base_sin*(self.base_cfd/50*gsr)*dt)
	elseif self.base_cfd >= self.base_damv then
		self.dx = self.dx + (self.v*self.base_cos*(self.base_da/50*gsr)*dt)
		self.dy = self.dy + (self.v*self.base_sin*(self.base_da/50*gsr)*dt)
	end
end 


function SimpleMovement:RandomWalks(dt,freq)
	--suv is a function, it switches vector components, but only from the character (mymy.lua) for example
	--switch unit vector, that's because mostly characters inherit RectangularCollider that can call
	--knowWhatSide() function,
	--if suv is nil, then do nothing,
	--nvm, i dont need suv() function, I called setCollided() along with knowWhatSide() on mymy character
	--to change svx,svy, whenever i want.
	self.frwalk = freq or self.frwalk --if no argument pass, just use the default value for frwalk.
	self.walkTime = self.walkTime - dt/self.frwalk
	if self.walkTime > 0 and self.walkTime < self.rstop then
		self.rwalk = true
	elseif self.walkTime > self.rstop then
		self.rwalk = false
	elseif self.walkTime < 0 then
		self.walkTime = math.random((self.frwalk+self.frwalk)*2,(self.frwalk+self.frwalk)*3)
			--extend if i want a long stop time, yup name unconventional
		self.rstop = math.random(self.frwalk*2,self.frwalk*3)
		self.rradian = math.random()*math.pi*2
		self.rux,self.ruy = math.cos(self.rradian),math.sin(self.rradian)
	end
	if self.rwalk then
		self.dx = self.dx + self.rux*self.v*dt*self.svx
		self.dy = self.dy + self.ruy*self.v*dt*self.svy
	end
end

--Special functions:
function SimpleMovement:updateScaling()
	self.base_dai = 200*gsr --idle area
	self.base_damv = 480*gsr --max distance allowed to limit character's velocity.
	self.base_da = self.base_damv*1.2
end

function SimpleMovement:drawOutlines()
	love.graphics.circle("line",self.x,self.y,self.base_dai)
	love.graphics.circle("line",self.x,self.y,self.base_damv)
	love.graphics.print("camera x,y :"..self.x.." , "..self.y,self.x,self.y)
--	if self.rwalk then
--		love.graphics.setColor(1,1,0)
--		love.graphics.rectangle("fill",self.x-50*forZoomingIn,self.y+50*forZoomingIn,100*forZoomingIn,100*forZoomingIn)
--	else
--		love.graphics.rectangle("fill",self.x-50*forZoomingIn,self.y+50*forZoomingIn,100*forZoomingIn,100*forZoomingIn)
--	end
end
