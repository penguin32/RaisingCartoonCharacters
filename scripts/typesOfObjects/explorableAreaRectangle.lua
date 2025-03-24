ExplorableAreaRectangle = Object:extend()

function ExplorableAreaRectangle:new(x,y,init_scale)
	self.x = x or 0
	self.y = y or 0
	self.scale = init_scale or 1
	self.init_scale = init_scale or 1
	self.wo_to_x = x - origin.x --world origin.x to self.x
	self.wo_to_y = y - origin.y --this thing should be updated in runtime if an object is moving actively
					--with respect to the world origin.
					--if so, i need to figure out Player.Camera.base_x/y first, its a
					--similar problem.
	self.updateScaling(self)
end

function ExplorableAreaRectangle:update(dt)
end

function ExplorableAreaRectangle:draw()
end

--Unique functions:

-- Special functions:
function ExplorableAreaRectangle:updateScaling()
	--scaling distances from world origin to this object inital instantiated distance
	self.x,self.y = self.wo_to_x*forZoomingIn,self.wo_to_y*forZoomingIn
	--width,height should be done the same aswell as to give the illusion of zooming in/out.
	self.scale = self.init_scale*forZoomingIn
end

function ExplorableAreaRectangle:drawOutlines()
	love.graphics.print("obj coord with respect to world origin: "..self.x - origin.x.." , "..self.y - origin.y ,self.x,self.y)
	love.graphics.print("dx/dy : "..(self.x - origin.x)/(self.y - origin.y) ,self.x,self.y+30*gsr)
end
