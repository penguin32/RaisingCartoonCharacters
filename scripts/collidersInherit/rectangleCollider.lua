RectangleCollider = Object:extend()

function RectangleCollider:Colliders()
	--when calling me, since we're checking the object's position when colliding, you have to call me on
	--the update() function of those classes inheriting me.
	if #LevelLoader.objects > 0 then
		for i, v in ipairs(LevelLoader.objects) do
			-- shit loops throught itself, (costed my 13 fucking hours fuck
			--fuck fuck my iq probably 30 below average
		if v:is(Rectangle) and v.group == self.group and v.set_collider and self ~= v then
			self:CollideToRectangle(v)--this collision works with each other rectangles
		end

		end
	end
end

function RectangleCollider:CollideToRectangle(obj)
	local sLeft = self.x < obj.x+obj.w --self left
	local sRight = self.x+self.w > obj.x
	local sTop = self.y+self.h < obj.y
	local sBot = self.y>obj.y+obj.h
	local ioost = true  --insert object on self.table
	if self.loco ~= nil then
		--does self.loco objects, get updated at runtime? probably not and not a copy
		--and not a memory pointer,
		--i'll just try it either way
		--for now treating self.loco as a memory pointer that changes overtime like addressing to
		--another table of LevelLoader.lua
		--maybe no
		--hmm it actually works, so if i changed some part of the variable inside
		--that self.loco table, it actually changes that variable that
		--LevelLoader table of that objects looped on.
		--so it is a memory address


		--For this part, I really have no idea why it wont let me change the attributes for "self"
--		self.collided = true
		for i,v in ipairs(self.loco) do
			if v == obj then
				ioost = false
			else
				local isLeft = self.x < v.x+v.w --inner self left
				local isRight = self.x+self.w > v.x
				local isTop = self.y+self.h < v.y
				local isBot = self.y>v.y+v.h
				if not(isLeft and isRight and isTop and isBot) then
					v.collided = false -- I can't fix the flickering
					table.remove(self.loco,i)
				elseif isLeft and isRight and isTop and isBot then
					self.collided = true
				end
			end
		end
--	else
--		self.collided = false
	end
	if sBot and sTop and sLeft and sRight and ioost then
		obj.collided = true
		table.insert(self.loco,obj)
	end

	--//Every object that has a collider gonna need some id, or lets just say every object just incase
	-- new problem(march 27 2025): this function fight over each objects, so
	-- when an object interact with my object, that objects run functions on both rectangle objects.
	-- what i need is to prioritize object that has collided, but how...
	-- maybe i need a latch() that self.collided becomes false
	-- only if that object let go(goes out boundary)
	-- nah, i just need to identify which objects are collided with my object self.list of object?
	-- how bout just turn this to another Object:update that detect collisions?
	-- forget about inheritance? what ya say?
	-- nope, it going to be just a nested for loops and that object is going to iterate that table again
	-- and see itself, thus running the function to it self(that is fix) but trouble for multiple objects will
	-- still persist.
	-- ahaha fuck yeah, solved it
	-- fuck nvm
end

--Special Functions:
function RectangleCollider:iupdateScaling() --inherited updateScaling()
	--//Well, I should already know that self.w and self.h are
	--already being scaled from their respective classes,
	--
	--variables that are called here is indeed from those classes that inherits this class.
	---maybe i can remove this, delete later in future, and treat class that are
	---inherited differently from now on
end

function RectangleCollider:idrawOutlines() --inherited drawOutlines() -- remember theres a difference between
						-- dx,dy and self.x,y
	love.graphics.rectangle("fill",self.x+5*forZoomingIn,self.y-5*forZoomingIn, self.w-10*forZoomingIn, self.h+10*forZoomingIn)
	love.graphics.setColor(0,0,100)
	love.graphics.circle("fill",self.x,self.y,10*forZoomingIn) 
	love.graphics.circle("fill",self.x+self.w,self.y,10*forZoomingIn)
	love.graphics.circle("line",self.x,self.y+self.h,10*forZoomingIn)
	love.graphics.circle("fill",self.x+self.w,self.y+self.h,10*forZoomingIn)
	love.graphics.print("self.y-h: "..self.y-self.h,self.x,self.y+60*gsr)
	love.graphics.print("self.y: "..self.y,self.x,self.y+80*gsr)

	love.graphics.print("top side: "..self.y+self.h,self.x,self.y+self.h+80*gsr)

	love.graphics.setColor(0.5,0,0)
end
