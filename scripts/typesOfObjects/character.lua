Character = SimpleMovement:extend()
--For SortObjects() in LevelLoader.lua
--It doesn't have to be specifically for characters,
--all kind of things that needed simplemovemnt would do well
--if they wanted to be sorted out like a circle (see SortObject() )
--
-- --It just drawing order, f my naming convention,
-- ill use this for any other movable objects,
function Character:new(x,y,velocity,group,gameDev)
	Character.super.new(self,x,y,velocity,group,gameDev)
--	self.group = group or 0				-- tells how it should collided with LoadLevel.objects
--	self.gameDev = gameDev or false			--tells if its gonna be control by player
	self.collided = false
	self.id = math.random()
	self.ids = {}	--table of interacted objects

end

function Character:update(dt)
	Character.super.update(self,dt)
end

function Character:updateScaling()
	Character.super.updateScaling(self)
end

function Character:selectAction(dt,action)
--	action = action or 0
--	if action == 1 then
--		Character.super.RandomWalks(self,dt)
--	end --discarded because I could just called it straight from the SimpleMovement's functions using super.
--	--not sure if i may group common function from SimpleMovement to here.
end
