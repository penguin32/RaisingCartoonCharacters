RectangleCollider = Object:extend()

function RectangleCollider:Colliders()
--	--when calling me, since we're checking the object's position when colliding, you have to call me on
--	--the update() function of those classes inheriting me.
--	if #LevelLoader.objects > 0 then
--		for i, v in ipairs(LevelLoader.objects) do
--			-- shit loops throught itself, (costed my 13 fucking hours fuck
--			--fuck fuck my iq probably 30 below average
--		if v:is(Rectangle) and v.group == self.group and v.set_collider and self ~= v then
--			self:CollideToRectangle(v)--this collision works with each other rectangles
--		end
--
--		end
--	end
--	--usually this function is specifically for testing, 
--	-- because everything that happens here, affects other classes that extends from rectangle class whom
--	-- inherited this class.
--	-- set_collided = true, would have start this function running, see objectShapes/rectangle.lua
--	--if i want a specific thing to happen, i just
--	--have to call the function below at here at other file inheriting this.
--
--dont need this anymore, just leaving this here for reference
end

function RectangleCollider:setCollided(obj,ox,oy) --//The perfect collider, but im worried with resources
				--because of many for loops as it checkes each 
				--self's table and that obj's table
				--self.ids
				--obj.ids
				--how it works?
				--objects have id and ids,
				--id are their unique seeds used to uniquely identify themselves.
				--ids are table/list of id's they interacted with each other.
				--if #ids count drop to zero, i set their "collided" to false
				--if #ids is more than one, then their var "collided" is set to true
				--#ids count are named "collisions" that you'd see printed on drawOutline()
				--
				--This way, in my first example for this git commit im gonna make,
				--is that npc(mymy) calling this function under theirs(update function)
				-- causes it to add values to attributes that is being looped at
				-- that is Mymy --> Shit, which means
				-- 	"check if mymy class" interacts with an object "shits"
				-- hence only mymy can do that,
				-- 	if shit interact with other shits, nothing gonna change.
				-- and if there's two mymy in the game, it 
				-- 			just add to their objs list of ids
				-- and that mymys doesnt interact with one another as i made sure of that in
				-- their update()
	local sLeft = self.dx+ox < obj.dx+obj.init_w
	local sRight = self.dx+ox+self.init_w > obj.dx
	local sTop = self.dy+oy-self.init_h < obj.dy
	local sBot = self.dy+oy>obj.dy-obj.init_h
	if not(sLeft and sRight and sTop and sBot)then
		for i,v in ipairs(obj.ids) do
			if v == self.id then
				table.remove(obj.ids,i)
			end
		end
		if #obj.ids == 0 then
			obj.collided = false
		end
		for i,v in ipairs(self.ids) do
			if v == obj.id then
				table.remove(self.ids,i)
			end
		end
		if #self.ids == 0 then
			self.collided = false
		end
	end 
	if sLeft and sRight and sTop and sBot then
			local doesExist = false
			for i,v in ipairs(self.ids) do
				if v == obj.id then
					doesExist = true
					break
				end
			end
			if not(doesExist) then
				table.insert(self.ids,obj.id)
			end
		if #self.ids > 0 then
			self.collided = true
		end
			local doesExist = false
			for i,v in ipairs(obj.ids) do
				if v == self.id then
					doesExist = true
					break
				end
			end
			if not(doesExist) then
				table.insert(obj.ids,self.id)
			end
		if #obj.ids > 0 then
			obj.collided = true
		end
	end
end

function RectangleCollider:Walls(obj,ox,oy) --ox, offset x
	local sLeft = self.dx+ox < obj.dx+obj.init_w --self left
	local sRight = self.dx+ox+self.init_w > obj.dx
	local sTop = self.dy+oy-self.init_h < obj.dy
	local sBot = self.dy+oy>obj.dy-obj.init_h
	if sLeft and sRight and sTop and sBot then
		--contain sLeft from top and bottom, then
	local ifrsoor = self.dx+ox+self.init_w > obj.dx+obj.init_w
			-- if self's right side is on obj's right side.
	local iflsool =	self.dx+ox < obj.dx --if self's left on object's left side.
	local iftsoot = self.dy+oy-self.init_h < obj.dy-obj.init_h	--if top self on object's top
	local ifbsoob = self.dy+oy > obj.dy --if bottom self on object's bottom
	--okay i give up, im going to right this uglier code, so...
	--self middle part compare to object's vertices in abscissa.
	local smiddle = self.dy+oy-self.init_h/2
		if sTop and ifbsoob and smiddle > obj.dy then
			self.dy = obj.dy+self.init_h - oy
		elseif sBot and iftsoot and smiddle < obj.dy-obj.init_h then
			self.dy = obj.dy-obj.init_h - oy
		elseif sLeft and (sTop or sBot) and ifrsoor then
			self.dx = obj.dx+obj.init_w - ox
		elseif sRight and (sTop or sBot) and iflsool then
			self.dx = obj.dx-self.init_w - ox
		end
	end
end

function RectangleCollider:knowWhatSide(obj,ox,oy)--know what side of the object you're bouncing from
			--if the self collided with a wall, only call this function to check what side
			--,it does't have to be a wall, just an example
			--check if collided
			--check if both object has the same id
			--	tells which side of the object by using this function
			--	end
			--	--for bouncing sliding shit.lua
			--	This function only works if self objects has svx and svy, see shit.lua
			--	must run only once
			--function written mostly for slide() here
	local yourMiddleX = self.dx+ox + self.init_w/2
	local yourMiddleY = self.dy+oy - self.init_h/2
	--corners is bugging shit out, i cant use yourmiddleX/y anymore
	--change later
	local oRight = yourMiddleX > obj.dx+obj.init_w --"self" is at the left side of that obj
	local oLeft = yourMiddleX < obj.dx	--right side of that obj
	local oBot = yourMiddleY > obj.dy --bottom of that obj
	local oTop = yourMiddleY<obj.dy-obj.init_h --youre on top of that obj
	if not(oTop) and not(oBot) then
		if oLeft or oRight then
			self.svx = -1*self.svx
		end
	elseif not(oRight) and not(oLeft) then
		if oTop or oBot then
			self.svy = -1*self.svy
		end
	end
end

function RectangleCollider:slide(dt,gh,gl,f,doStuff)
	doStuff = doStuff or nil
	--a function thats not accurate mimic of sliding object irl(real life)
			--affect by npc/character to an object "rectangle" kind
			--and bouncing off walls and themselves, walls being "rectangle" also
			--reminder that those walls aka rectangles, should have their
			--v.group assigned within the parameter gh > v.group > gl
			--and that includes the object that is sliding.
			--
			--The object's class calling this must have self.svx,svy variables
			--	we use that when we want to toggle directions(components) to their
			--	opposite sides when they bounce off walls.
			--
			--	That is function within function that also uses it, named
			--		knowWhatSide()
			--
			--maybe i'll just add them at rectangle class as default
			--since we only call this functions slid(), knowWhatSide(), to those
			--	objects that are only affected and is able to slide off, not
			--	on those walls.

	--player/npc already interact with this class
	--now im just adding what it can do about it, and that function is gonna be called here
	--Important to know this for future me tryna revisit shit,
	--self.group is very important as it affect conditions which rectangularCollider.lua is applied.


--	if #LevelLoader.objects > 0 then -- bounce off npc/players
--		for i,v in ipairs(LevelLoader.objects) do
--			if v:is(Character) then
--				for j,w in ipairs(self.ids) do
--					if w == v.id then
--						self.v = self.v + v.v*dt
--						self.svx,self.svy = Direction.GetVector(v.dx,v.dy,self.dx,self.dy)
--					end
--				end
--			end
--		end
--	end	--moved this within a single loop of LevelLoader.objects instead
	--instead of checking if object is collided == true,
	--i'll just check the list of colliding objects self.ids, and compare their id's to their list of ids
	--if its equal, then that means they're collided
	if #LevelLoader.objects > 0 then --bounce off walls
		for i,v in ipairs(LevelLoader.objects) do
			if v:is(Rectangle) and (v.group < gh and v.group > gl) then
				for j,w in ipairs(self.ids) do
					if w == v.id then
						self:Walls(v,0,0)
						self:knowWhatSide(v,0,0)
						--knowWhatSide() must run only once so, 
				--		table.remove(self.ids,w) --not working :(
						--no need, setCollided() took cares of it.
						--wrong, turns out thats not the case, see drawOutlines at runtime
				--maybe i can also bounce them from one another.
						v.v = self.v
						--best i could do,
					end
				end
					if self.id ~= v.id then --this works :D
						self:setCollided(v,0,0)
					end

--				self:setCollided(v,0,0) --just like mymy --> shit,
				-- for this one, its shit --> walls.
				-- 	because Shit:is(Rectangle) therefore, it also affects shit
			end
			if v:is(Character) then
				for j,w in ipairs(self.ids) do
					if w == v.id then
						self.v = self.v + v.v*dt
						self.svx,self.svy = Direction.GetVector(v.dx,v.dy,self.dx,self.dy)
					end
				end
			end
		end
	end
--	if #LevelLoader.objects > 0 then
--		for i,v in ipairs(LevelLoader.objects) do
--			if v:is(Rectangle) and (v.group < gh and v.group > gl) then
--				self:setCollided(v,0,0) --just like mymy --> shit,
--				-- for this one, its shit --> walls.
--			end
--		end
--	end  --moved this within a single loop of LevelLoader.objects instead
	if self.v > 0 then
		self.dx = self.dx + self.v*self.svx*dt
		self.dy = self.dy + self.v*self.svy*dt
		self.v = self.v - f*dt --friction like :D
		if doStuff ~= nil then
			doStuff()
		end
	end
end

function RectangleCollider:CollideToRectangle(obj)--i think this is redundant, but may i'd use this in future.
						-- or just reference
	local sLeft = self.dx < obj.dx+obj.init_w --self left
	local sRight = self.dx+self.init_w > obj.dx
	local sTop = self.dy-self.init_h < obj.dy
	local sBot = self.dy>obj.dy-obj.init_h
	local ioost = true  --insert object on self.table
	if #self.loco > 0 then
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
--
--		okay at this commit, i had to reverse value for self.init_h
--		because the last self.h variable last commit is multiplied by a negative because 
--		it was put there to accomodate with the love.graphics.drawing()
--		and since init_h (initial height) therefore it has not been tampered, normally in this code.
--
--		Another PROBLEM arise, "if theres one 1 to 1 object exist on that table" I have to give it some
--		conditions
		for i,v in ipairs(self.loco) do
			if v == obj and #self.loco ~= 1 then
				ioost = false
			else
				local isLeft = self.dx < v.dx+v.init_w --inner self left
				local isRight = self.dx+self.init_w > v.dx
				local isTop = self.dy-self.init_h < v.dy
				local isBot = self.dy>v.dy-v.init_h
				if not(isLeft and isRight and isTop and isBot) then
					if #v.loco > 0 then
						v.collided = true
					else
						v.collided = false
					end
					table.remove(self.loco,i)
					if #self.loco > 0 then
						self.collided = true
					end
				elseif isLeft and isRight and isTop and isBot then
					self.collided = true
				end
			end
		end
	else
		self.collided = false
	end
	if sBot and sTop and sLeft and sRight and ioost and #self.loco ~= 1 then
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
	love.graphics.setColor(0,0,100)
	love.graphics.rectangle("line",self.x+5*forZoomingIn,self.y-5*forZoomingIn, self.w-10*forZoomingIn, self.h+10*forZoomingIn)
--	love.graphics.print("self.collided: "..tostring(self.collided),self.x,self.y+80*gsr)

--	love.graphics.print("top side: "..self.y+self.h,self.x,self.y+self.h+80*gsr)
--	love.graphics.print("loco table: "..#self.loco,self.x,self.y+self.h+120*gsr)

	love.graphics.setColor(0.5,0,0)
end
