--// what if i create a scale of a unit vector(that origin.x origin.y to a 1 unit) get their ratio, then scale,
--that instead for dx dy (changing x and y)
--basically multiplying forZoomingIn*by 1, it make sense, but it doesnt make sense at the same time >:(

SimpleMovement = Object:extend()

function SimpleMovement:new(base_x,base_y,base_v)
	self.base_x = base_x or 0
	self.base_y = base_y or 0
	self.base_v = base_v or 35 -- remember to scale this by forZoomingIn
	self.base_dai = 430*gsr --idle area
	self.base_cfd = 0 --cursorFocusDistance, magnitude from game.middleX&Y to cursor.x,cursor.y
	self.base_damv = 680*gsr --max distance allowed to limit character's velocity.
	self.base_cos, self.base_sin = 0-- Use to calculate for radians to vector of
					-- mouse cursor to game.middleX,game.middleY(forPlayer)
	self.base_da = self.base_damv*1.2 -- Max acceleration for a given distance.
end

function SimpleMovement:update(dt,animal_x,animal_y,food_x,food_y)
	self.base_cfd = Direction.GetDistance(animal_x,animal_y,food_x,food_y)*forZoomingIn
	self.base_cos,self.base_sin = Direction.GetVector(animal_x,animal_y,food_x,food_y)
	if self.base_cfd > self.base_dai and self.base_cfd < self.base_damv then
		self.base_x = self.base_x + self.base_v*self.base_cos*(self.base_cfd/50)*dt
		self.base_y = self.base_y + self.base_v*self.base_sin*(self.base_cfd/50)*dt
	elseif self.base_cfd >= self.base_damv then
		self.base_x = self.base_x + self.base_v*self.base_cos*(self.base_da/50)*dt
		self.base_y = self.base_y + self.base_v*self.base_sin*(self.base_da/50)*dt
	end
end

--Special Functions:
function SimpleMovement:updateScaling()
	self.base_dai = 430*gsr
	self.base_damv = 680*gsr
end

function SimpleMovement:drawOutlines()
	love.graphics.circle("line",game.middleX,game.middleY,self.base_dai)
	love.graphics.circle("line",game.middleX,game.middleY,self.base_damv)
end
