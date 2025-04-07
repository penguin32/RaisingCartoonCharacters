Options = Object:extend()
local sT = 0.8--choosen scale, name idea came from "scale text" to test out scaling of width and height
			--button of layer0 text boxes.
--Called by the players using it, which is the camera class, camera.lua

function Options:new()
	self.list = {} --table of options, list of options
	self.circle = {--remember to update its coordinates due to the fact that game.middleX/Y changes in runtime
		x = game.middleX,
		y = game.middleY,
		r = 200*gsr
	}
	self.mov = 300*gsr --move options velocity
	self.directory = "layers/globalAssets/options/"
	self.gA = "layers/globalAssets/"
	self.help={}
	self.help.i = love.graphics.newImage(self.directory.."help.png")
	self.help.ib = love.graphics.newImage(self.directory.."look_for_items.png") --temporary ib for tHover(btn)
							--for testing
	self.help.w = self.help.i:getWidth()*sT*gsr
	self.help.h = self.help.i:getHeight()*sT*gsr
--	self.help.x,self.help.y = self.circle.x+self.circle.r-(self.help.w/2)*gsr,self.circle.y-(self.help.h/2)*gsr
	self.help.x,self.help.y = self.circle.x-(self.help.w/2)*gsr,self.circle.y-(self.help.h/2)*gsr
	self.help.ix,self.help.iy = self.circle.x-(self.help.w/2)*gsr,self.circle.y-(self.help.h/2)*gsr--initial
				--ix,iy, should also be updated in scaling, as stated above reason middleX/Y
				--self.circle.x/y changes in runtime.
	self.help.s = gsr*sT
	self.help.mBrushOnce = true
	self.help.mBrush = love.audio.newSource(self.gA.."brush-sfx-behold.ogg","static")
	self.help.mcb = false
	self.help.ir = -math.pi --initial/ starting radian
	self.help.magnitude = 0
	self.help.setX = 0
	self.help.setY = 0
	--I want to add a new variable that disable rotation(radian adding) for a unique function
	--that is about to be made, and passed as an argument inside the tHover() function's parameter.

	table.insert(self.list,self.help)
	self:updateScaling()
end

function Options:update(dt)
	for i,v in ipairs(self.list) do
		if v.magnitude < self.circle.r then
			v.magnitude = v.magnitude + self.mov*dt
		end
		v.setY = v.magnitude*math.sin(v.ir)
		v.setX = v.magnitude*math.cos(v.ir)
		v.x,v.y = v.ix+v.setX,v.iy+v.setY
		v.ix,v.iy = self.circle.x-(v.w/2)*gsr,self.circle.y-(v.h/2)*gsr--initial
		v.ir = v.ir +0.5*dt
	end
end

function Options:draw()
	for i,v in ipairs(self.list) do
		tHover(v)
	end
end

--Unique functions:
--Special functions:
function Options:mousepressed(mx,my)
end

function Options:mousereleased(mx,my)
end

function Options:updateScaling()
	self.circle.x = game.middleX
	self.circle.y = game.middleY
	for i,v in ipairs(self.list) do
		v.w = v.i:getWidth()*sT*gsr
		v.h = v.i:getHeight()*sT*gsr
		v.s = gsr*sT
	end
end

function Options:drawOutlines()
	love.graphics.setColor(0,0,1)
--	love.graphics.arc("line",game.middleX,game.middleY,100,0,math.pi)
	love.graphics.circle("line",self.circle.x,self.circle.y,self.circle.r)
	love.graphics.setColor(0.5,0,0)
end
