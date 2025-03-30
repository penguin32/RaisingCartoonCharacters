Character = SimpleMovement:extend()
--For SortObjects() in LevelLoader.lua
--It doesn't have to be specifically for characters,
--all kind of things that needed simplemovemnt would do well
--if they wanted to be sorted out like a circle (see SortObject() )
--
-- --It just drawing order, f my naming convention,
-- ill use this for any other movable objects,
function Character:new(x,y,velocity,npc)
	Character.super.new(self,x,y,velocity,npc)
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
	action = action or 0
	if action == 1 then
		Character.super.RandomWalks(self,dt)
	end
end
