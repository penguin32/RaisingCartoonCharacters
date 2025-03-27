--// what if i create a scale of a unit vector(that origin.x origin.y to a 1 unit) get their ratio, then scale,
--that instead for dx dy (changing x and y)
--basically multiplying forZoomingIn*by 1, it make sense, but it doesnt make sense at the same time >:(

SimpleMovement = Object:extend()

function SimpleMovement:new(x,y,velocity)
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
	self:updateCoordinates()
end

function SimpleMovement:update(dt,animal_x,animal_y,food_x,food_y)
	self.base_cfd = Direction.GetDistance(animal_x,animal_y,food_x,food_y)
	self.base_cos,self.base_sin = Direction.GetVector(animal_x,animal_y,food_x,food_y)
	if self.base_cfd > self.base_dai and self.base_cfd < self.base_damv then
		self.dx = self.dx + (self.v*self.base_cos*(self.base_cfd/50*gsr)*dt)
		self.dy = self.dy + (self.v*self.base_sin*(self.base_cfd/50*gsr)*dt)
	elseif self.base_cfd >= self.base_damv then
		self.dx = self.dx + (self.v*self.base_cos*(self.base_da/50*gsr)*dt)
		self.dy = self.dy + (self.v*self.base_sin*(self.base_da/50*gsr)*dt)
	end
	self:updateCoordinates()
end

function SimpleMovement:updateCoordinates()
	self.wo_to_dx = self.dx - origin.x
	self.wo_to_dy = self.dy - origin.y
	self.x = self.wo_to_dx*forZoomingIn
	self.y = self.wo_to_dy*forZoomingIn
end

--Special Functions:
function SimpleMovement:updateScaling()
	self.base_dai = 200*gsr --idle area
	self.base_damv = 480*gsr --max distance allowed to limit character's velocity.
	self.base_da = self.base_damv*1.2
end

function SimpleMovement:drawOutlines()
	love.graphics.circle("line",self.x,self.y,self.base_dai)
	love.graphics.circle("line",self.x,self.y,self.base_damv)
	love.graphics.print("camera x,y :"..self.x.." , "..self.y,self.x,self.y)
end
