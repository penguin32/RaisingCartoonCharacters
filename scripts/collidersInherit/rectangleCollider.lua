RectangleCollider = Object:extend()

function RectangleCollider:Colliders()
	--when calling me, since we're checking the object's position when colliding, you have to call me on
	--the update() function of those classes inheriting me.
	if #LevelLoader.objects > 0 then
		for i, v in ipairs(LevelLoader.objects) do
			self:CollideToRectangle(v)
		end
	end
end

function RectangleCollider:CollideToRectangle(obj)
	local similar = self.id == obj.id -- shit loops throught itself, (costed my 13 fucking hours fuck
					--fuck fuck my iq probably 30 below average
	if obj:is(Rectangle) and obj.group == self.group and obj.set_collider and not(similar) then
		local sLeft = self.x < obj.x + obj.w --self left
		local sRight = self.x+self.w > obj.x
		local sTop = self.y+self.h < obj.y
		local sBot = self.y>obj.y+obj.h
		if sBot and sTop and sLeft and sRight then
			self.collided = true
		else
			self.collided = false
		end
	end
	--//Every object that has a collider gonna need some id, or lets just say every object just incase
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
