--// March 2025, need refactoring

Circle = Object:extend()
function Circle:new(x,y,velocity,init_r,init_scale,group,gameDev)
	self.collided = false
	self.id = math.random()
	self.ids = {}
	self.gameDev = gameDev or false
	self.v = velocity or 0
	self.group = group or 0 
	self.loco = {} --not sure about this, check rectangle.lua to investigate this.
			--list of colliding objects (loco) while I already have (ids) table of interacted objects
			--kinda overkill,
 	self.x = x or 0
	self.y = y or 0
	self.dx = x or 0
	self.dy = y or 0
	self.wo_to_dx = x - origin.x
	self.wo_to_dy = y - origin.y
	self.init_scale = init_scale or 1
	self.init_r = init_r or 20

	self:updateScaling()
	self:updateCoordinates()

	self.svx,self.svy = 1,1	--use by setColliders thingy maybe to imitate bounce in shit
end

function Circle:update(dt)--Exist to stay consistent with Environment.update(dt) loops
	self:updateCoordinates()
end

function Circle:draw()
end

function Circle:updateCoordinates()-- Dont need this if I can just call it from :implement(SimpleMovemnt) class
					--but up to you, if you want to implement or just inherit
	self.wo_to_dx = self.dx - origin.x
	self.wo_to_dy = self.dy - origin.y
	self.x,self.y = self.wo_to_dx*forZoomingIn,self.wo_to_dy*forZoomingIn
end

--Unique functions:

--Special functions:
function Circle:updateScaling()
	self.scale = self.init_scale*forZoomingIn
	self.r = self.init_r*self.scale
end

function Circle:drawOutlines()
	love.graphics.circle("fill", self.x, self.y, self.r)
end
