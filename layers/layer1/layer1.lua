Layer1 = ExplorableAreaRectangle:extend() -- The Home
-- sT aka scale now(self.scale), local sT = 3

function Layer1:new(x,y,scale)
	Layer1.super.new(self,x,y,scale)
	self.waf = love.graphics.newImage("layers/layer1/layer1-assets/home_bg.png")
	--Coliders:
	table.insert(LevelLoader.objects,Rectangle(self.x-100,self.y+self.waf:getHeight()+100,100,self.waf:getHeight()+200))--left side
	table.insert(LevelLoader.objects,Rectangle(self.x+self.waf:getWidth(),self.y+self.waf:getHeight()+100,100,self.waf:getHeight()+200))--right side
	table.insert(LevelLoader.objects,Rectangle(self.x-100,self.y,self.waf:getWidth()+200,100)) --top side
	table.insert(LevelLoader.objects,Rectangle(self.x-100,self.y+self.waf:getHeight()+100,self.waf:getWidth()+200,100)) --bot side
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
end

function Layer1:drawOutlines()
	Layer1.super.drawOutlines(self)
	love.graphics.rectangle("line",self.x,self.y,self.waf:getWidth()*self.scale,self.waf:getHeight()*self.scale)
end
