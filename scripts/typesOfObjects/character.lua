Character = SimpleMovement:extend()
--For SortObjects() in LevelLoader.lua

function Character:new(x,y,velocity,npc)
	Character.super.new(self,x,y,velocity,npc)
end

function Character:update(dt)
	Character.super.update(self,dt)
end

function Character:updateScaling()
	Character.super.updateScaling(self)
end
