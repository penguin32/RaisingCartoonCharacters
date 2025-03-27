Layer1 = ExplorableAreaRectangle:extend() -- The Home

function Layer1:new(x,y,init_scale)
	Layer1.super.new(self,x,y,init_scale)
	self.x = x or 0
	self.y = y or 0
	self.init_scale = init_scale or 1
	self.waf = love.graphics.newImage("layers/layer1/layer1-assets/home_bg.png")
	--Coliders:
	table.insert(LevelLoader.objects,
	Rectangle(
		1,
		x-100,
		y+self.waf:getHeight(),
		100,
		self.waf:getHeight(),
		1,
		true
	))--left side
--	table.insert(LevelLoader.objects,Rectangle(
--		x+self.waf:getWidth(),
--		y+self.waf:getHeight(),
--		100,
--		self.waf:getHeight(),
--		1,
--		true
--	))--right side
--	table.insert(LevelLoader.objects,Rectangle(
--		x-100,
--		y,
--		self.waf:getWidth()+200,
--		100,
--		1,
--		true
--	)) --top side
	--temporarily removed this so player can go outside.
--	table.insert(LevelLoader.objects,Rectangle(
--		x-100,
--		y+self.waf:getHeight()+100,
--		self.waf:getWidth()+200,
--		100,
--		1,
--		true
--	)) --bottom side

	self.updateScaling(self)
end

function Layer1:update(dt)
	Layer1.super.update(self)
end

function Layer1:draw()
--	love.graphics.draw(self.waf,self.x,self.y,nil,self.scale)
end

-- Unique functions:

-- Special functions:
function Layer1:mousepressed(mx,my,btn)
end

function Layer1:mousereleased(mx,my,btn)
end

function Layer1:updateScaling()
	Layer1.super.updateScaling(self)
	self.scale = self.init_scale*forZoomingIn
end

function Layer1:drawOutlines()
	Layer1.super.drawOutlines(self)
	love.graphics.rectangle("line",self.x,self.y,self.waf:getWidth()*self.scale,self.waf:getHeight()*self.scale)
end
