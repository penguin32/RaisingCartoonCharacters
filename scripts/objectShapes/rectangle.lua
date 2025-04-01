Rectangle = Object:extend()
Rectangle:implement(RectangleCollider)
--not tested for moving rectangles during zoom function.
--			1,2,3,	  ,4    ,5         ,6     ,7      ,8
function Rectangle:new(x,y,init_w,init_h,init_scale,group,velocity,gameDev)
	self.collided = false
	self.id = math.random()
	self.ids = {} -- table of interacted objects

	self.gameDev = gameDev or false --temporary variable,
					--for testing out collission so that i could control them,
					--to differentiate among the tables of objects when being loop by
					--control.lua at Player.update(dt)
				--parameters are added in order on how commonly theyre going to be use.
	self.v = velocity or 0
	self.group = group or 0 --variable use in collidersInherit, objs the in same groups does not collide
	self.loco = {} --list of colliding objects
	self.x = x or 0
	self.y = y or 0
	self.dx = x or 0
	self.dy = y or 0
	self.wo_to_dx = x - origin.x
	self.wo_to_dy = y - origin.y
	self.init_scale = init_scale or 1
	self.init_w = init_w or 100
	self.init_h = init_h or 100
--	self.scale = init_scale or 1		--
--	self.w = (init_w or 100)*self.scale	-- --These 3 statements are called within the function
--	self.h = (init_h or 100)*-self.scale	--		updateScaling()
	self:updateScaling() --see explanation on simpleMovement.lua
	self:updateCoordinates()

	-- why name variable such a way?
	-- x,y alone, are just arguments that is from the function's parameter
	-- self.x,self.y is the variable that is use in graphics functions
	-- while
	-- self.dx,self.dy are the coordinates that is allowed to be change during runtime
	-- variable being named velocity, are just to be more apparent that its is velocity
	-- 	assinged to self.v
	-- 	--further explanation on how these movements, coordinates, scaling ties well together
	-- 	can be read on controls.lua near Player.Viewport
	self.svx,self.svy = 1,1
end

function Rectangle:update(dt)--Exist to stay consistent with Environment.update(dt) loops
--updating movements here:
	self:updateCoordinates()
end

function Rectangle:updateCoordinates()
	self.wo_to_dx = self.dx - origin.x 
	self.wo_to_dy = self.dy - origin.y
	self.x,self.y = self.wo_to_dx*forZoomingIn,self.wo_to_dy*forZoomingIn
end

function Rectangle:draw()
end

--Unique functions:

--Special functions
function Rectangle:updateScaling()
--updating scaling here: (reminder, use for zoom functionality only)
--if I plant to update its width and height not because of zoom function,
--					then update those in the Rectangle:update(dt)
	self.scale = self.init_scale*forZoomingIn
	self.w = self.init_w*self.scale
	self.h = self.init_h*-self.scale--the reason that its negative, is for the drawing order SortOrder()
					--long story, since 2022, now what is my work around this shit for
					--colliders functions?
					--and for love.graphics.draw() offset, making
					--x,y as point closer below the viewport screen,
					--and that for drawing images offset upright, long story short,
					--now its going to take a week, maybe months, tryna refactor that
					--Character Sprite from scratch, so I'll just work around rectangle's
					--colliders, 
					--its a lot of trouble trying to fix that isometric drawing order
					--back in 2022, so i wouldnt change many things.
	--im going to test movement while zoom function is affecting and without love.graphics.translate
end

function Rectangle:drawOutlines()
	-- Just for testing... see collision shape.
	love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
--	love.graphics.circle("fill",self.x,self.y,10*forZoomingIn)
--	love.graphics.print("dx,dy: "..self.dx.." , "..self.dy ,self.x,self.y)
	love.graphics.print("collided: "..tostring(self.collided),self.x,self.y)
	love.graphics.print("collisions: "..#self.ids,self.x,self.y+30)
--	love.graphics.print("seed: "..self.id,self.x,self.y+60)
	--colliders
	if self.collided then
		love.graphics.setColor(0,100,0)
		self:idrawOutlines()
		love.graphics.setColor(0.5,0,0)
	else
		self:idrawOutlines()
	end
	love.graphics.setColor(0.5,0,0)
end
