Camera = SimpleMovement:extend() -- View game's environment, like not used in mainmenu, see levelLoader.lua

function Camera:new(base_x,base_y,base_v)
	self.base_x = base_x or 0
	self.base_y = base_y or 0
	self.base_v = base_v or 35
	self.base_dai = 630*gsr --idle area
end

function Camera:update()
end

function Camera:draw()
end

--Special Functions:
function Camera:mousepressed(mx,my,btn)
end

function Camera:mousereleased(mx,my,btn)
end

function Camera:updateScaling()
end

function Camera:drawOutlines()
--	love.graphics.circle("fill",game.middleX,game.middleY,50) -- yup it works
	love.graphics.circle("line",game.middleX,game.middleY,self.base_dai)
end
