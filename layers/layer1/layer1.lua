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
--		1,--self.id	--//maybe i dont need this, i got reminded of memory object ~= object2
--					yup i was fucking right
		x-100,--self.x
		y+self.waf:getHeight(),--self.y
		100,--init_w
		self.waf:getHeight(),--init_h
		1,--init_scale
		false--set_collider
			--group,
			--velocity,
			--gameDev , set true for control.lua
	))--left side
	table.insert(LevelLoader.objects,Rectangle(
		x+self.waf:getWidth(),	--x
		y+self.waf:getHeight(),	--y
		100,			--init_w
		self.waf:getHeight(),	--init_h
		1,			--init_scale
		false			--set_collider
	))--right side
	table.insert(LevelLoader.objects,Rectangle(
		x-100,
		y,
		self.waf:getWidth()+200,
		100,
		1,
		false
	)) --top side
	--temporarily removed this so player can go outside.
	table.insert(LevelLoader.objects,Rectangle(
		x-100,
		y+self.waf:getHeight()+100,
		self.waf:getWidth()+200,
		100,
		1,
		false
	)) --bottom side

	table.insert(LevelLoader.objects,Rectangle(
		x-100,				--x
		y+self.waf:getHeight()-200,     --y
		self.waf:getWidth()+200,        --init_w
		100,                            --init_h
		1,                              --init_scale
		false,                          --set_collider
		1
	)) --before bottom side

	table.insert(LevelLoader.objects,Camera(0,0,500))

	self.updateScaling(self)
end

function Layer1:update(dt)
	Layer1.super.update(self)
end

function Layer1:draw()
	love.graphics.draw(self.waf,self.x,self.y,nil,self.scale)
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
