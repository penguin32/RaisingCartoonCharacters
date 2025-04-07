Options = Object:extend()
--Called by the players using it, which is the camera class, camera.lua

function Options:new()
	self.list = {} --table of options, list of options

	self.directory = "layers/globalAssets/options/"
	self.gA = "layers/globalAssets/"
	self.help={}
	self.help.i = love.graphics.newImage(self.directory.."help.png")
	self.help.x,self.help.y = game.cartX, game.cartY
	self.help.w = self.help.i:getWidth()
	self.help.h = self.help.i:getHeight()
	self.help.s = gsr
	self.help.mBrushOnce = true
	self.help.mBrush = love.audio.newSource(self.gA.."brush-sfx-behold.ogg","static")
	self.help.mcb = false
	table.insert(self.list,self.help)
end

function Options:update(dt)
end

function Options:draw()
end

--Unique functions:
--Special functions:
function Options:mousepressed(mx,my)
end

function Options:mousereleased(mx,my)
end

function Options:updateScaling()
end

function Options:drawOutlines()
	love.graphics.arc("line",game.middleX,game.middleY,100,0,math.pi)
end
