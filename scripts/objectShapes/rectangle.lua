Rectangle = Object:extend()
Rectangle:implement(RectangleColliders)

function Rectangle:new(x,y,init_w,init_h,init_scale,set_collider)
	self.set_collider = set_collider or false
	self.x = x or 0				-- variables use in implement(RectangleColliders)
	self.y = y or 0				--
	self.init_scale = init_scale or 1
	self.scale = init_scale or 1		--
	self.init_w = init_w or 100
	self.init_h = init_h or 100
	self.w = (init_w or 100)*self.scale	--
	self.h = (init_h or 100)*-self.scale	--
	self.wo_to_x = x - origin.x
	self.wo_to_y = y - origin.y
	self.updateScaling(self)
end

function Rectangle:update(dt)--Exist to stay consistent with Environment.update(dt) loops
end

function Rectangle:draw()
end

--Unique functions:

--Special Functions
function Rectangle:updateScaling()
	self.x,self.y = self.wo_to_x*forZoomingIn,self.wo_to_y*forZoomingIn
	self.scale = self.init_scale*forZoomingIn
	self.w = self.init_w*self.scale
	self.h = self.init_h*-self.scale
end

function Rectangle:drawOutlines()
	-- Just for testing... see collision shape.
	love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
end
