Character = SimpleMovement:extend()
--For SortObjects() in LevelLoader.lua
--It doesn't have to be specifically for characters,
--all kind of things that needed simplemovemnt would do well
--if they wanted to be sorted out like a circle (see SortObject() )
--
--nvm, it may not be true at all since it also has an affect of collisions, be wary of that.
function Character:new(x,y,velocity,npc)
	Character.super.new(self,x,y,velocity,npc)
end

function Character:update(dt)
	Character.super.update(self,dt)
end

function Character:updateScaling()
	Character.super.updateScaling(self)
end
