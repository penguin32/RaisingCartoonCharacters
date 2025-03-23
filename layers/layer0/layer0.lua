Layer0 = Object:extend() -- The MainMenu
local sT = 3

function Layer0:new()
	self.directory = "layers/layer0/layer0-assets/"
	self.gA = "layers/globalAssets/"
	self.music = love.audio.newSource(self.directory.."Boku No Senpai_Ongzellig.ogg","stream")
	self.music:setLooping(true)
	self.music:setVolume(0.1)
	self.music:play()
	self.sfx_mClicked = love.audio.newSource(self.gA.."clicked-sfx-behold.ogg","static")
	self.btn = {}
	self.btn.freq = 0.25
	self.titleImage={}
	self.titleImage.i = love.graphics.newImage(self.directory.."mainmenu.png")
	self.titleImage.x,self.titleImage.y = game.cartX,game.cartY
	self.titleImage.w = self.titleImage.i:getWidth()
	self.titleImage.h = self.titleImage.i:getHeight()
	self.btn.newgame = {}
	self.btn.newgame.i = love.graphics.newImage(self.directory.."t_newgame.png")
	self.btn.newgame.ib = love.graphics.newImage(self.directory.."tb_newgame.png")
	self.btn.newgame.x = game.middleX - 135*gsr
	self.btn.newgame.y = game.middleY + 100*gsr
	self.btn.newgame.w = self.btn.newgame.i:getWidth()*sT*gsr
	self.btn.newgame.h = self.btn.newgame.i:getHeight()*sT*gsr
	self.btn.newgame.s = sT*gsr
	self.btn.newgame.mBrushOnce = true -- play only once
	self.btn.newgame.mBrush = love.audio.newSource(self.gA.."brush-sfx-behold.ogg","static")
	self.btn.newgame.mcb = false -- mouse clicked bool
	self.btn.options = {}
	self.btn.options.i = love.graphics.newImage(self.directory.."t_options.png")
	self.btn.options.ib = love.graphics.newImage(self.directory.."tb_options.png")
	self.btn.options.x = self.btn.newgame.x
	self.btn.options.y = self.btn.newgame.y + 150*gsr
	self.btn.options.w = self.btn.options.i:getWidth()*sT*gsr
	self.btn.options.h = self.btn.options.i:getHeight()*sT*gsr
	self.btn.options.s = sT*gsr
	self.btn.options.mBrushOnce = true
	self.btn.options.mBrush = love.audio.newSource(self.gA.."brush-sfx-behold.ogg","static")
	self.btn.options.mcb = false
	self.btn.album = {}
	self.btn.album.i = love.graphics.newImage(self.directory.."t_album.png")
	self.btn.album.ib = love.graphics.newImage(self.directory.."tb_album.png")
	self.btn.album.x = self.btn.options.x
	self.btn.album.y = self.btn.options.y + 150*gsr
	self.btn.album.w = self.btn.album.i:getWidth()*sT*gsr
	self.btn.album.h = self.btn.album.i:getHeight()*sT*gsr
	self.btn.album.s = sT*gsr
	self.btn.album.mBrushOnce = true
	self.btn.album.mBrush = love.audio.newSource(self.gA.."brush-sfx-behold.ogg","static")
	self.btn.options.mcb = false
	self.updateScaling(self)
end

function Layer0:update(dt)
end

function Layer0:draw()
	love.graphics.draw(self.titleImage.i,self.titleImage.x,self.titleImage.y,0,gsr)
	self:tHover(self.btn.newgame)
	self:tHover(self.btn.options)
	self:tHover(self.btn.album)
end

-- Unique functions:
function Layer0:tHover(button) --textBoxHover Highlight, I could have use this to other layers
	-- guess its not so unique, I may have to create a new files, that I can call it whenever I want to.
	if cursor.x > button.x and cursor.x < button.x + button.w and cursor.y > button.y and cursor.y < button.y + button.h then
		if button.mcb == true then -- wondering what mcb is for? its basically for this...
			love.graphics.setColor(0.5,1,0)		--changes color when clicked
			love.graphics.draw(button.ib,button.x,button.y,0,button.s)
			love.graphics.setColor(1,1,1)
		else
			love.graphics.draw(button.ib,button.x,button.y,0,button.s)
			if button.mBrushOnce then
				button.mBrush:play()
				button.mBrushOnce = false
			end
			if love.mouse.isDown(1) then --if mouse.isDown is being click
				return true -- then so...
			end
		end
	else
		love.graphics.draw(button.i,button.x,button.y,0,button.s)
		button.mBrushOnce = true
		return false -- changes mcb values if mouse.isDown is not clicked
	end
end

-- Special functions:
function Layer0:mousepressed(mx,my)
	self.btn.newgame.mcb = self:tHover(self.btn.newgame)
	self.btn.options.mcb = self:tHover(self.btn.options)
	self.btn.album.mcb = self:tHover(self.btn.album)
end

function Layer0:mousereleased(mx,my) -- btn == 1 is not working :(
	if self.btn.newgame.mcb == true then
		self.sfx_mClicked:play()
		self.btn.newgame.mcb = false
		self.music:stop()
		table.remove(LevelLoader.ui,#LevelLoader.ui)
		LevelLoader.load(1,true)
	elseif self.btn.options.mcb == true then
		self.sfx_mClicked:play()
		self.btn.options.mcb = false
	elseif self.btn.album.mcb == true then
		self.sfx_mClicked:play()
		self.btn.album.mcb = false
	end
end

function Layer0:updateScaling()
	self.titleImage.x,self.titleImage.y = game.cartX,game.cartY
	self.titleImage.w = self.titleImage.i:getWidth()
	self.titleImage.h = self.titleImage.i:getHeight()
	self.btn.newgame.x = game.middleX - 135*gsr
	self.btn.newgame.y = game.middleY + 100*gsr
	self.btn.newgame.w = self.btn.newgame.i:getWidth()*sT*gsr
	self.btn.newgame.h = self.btn.newgame.i:getHeight()*sT*gsr
	self.btn.newgame.s = sT*gsr
	self.btn.newgame.mcb = false
	self.btn.options.x = self.btn.newgame.x
	self.btn.options.y = self.btn.newgame.y + 150*gsr
	self.btn.options.w = self.btn.options.i:getWidth()*sT*gsr
	self.btn.options.h = self.btn.options.i:getHeight()*sT*gsr
	self.btn.options.s = sT*gsr
	self.btn.options.mcb = false
	self.btn.album.x = self.btn.options.x
	self.btn.album.y = self.btn.options.y + 150*gsr
	self.btn.album.w = self.btn.album.i:getWidth()*sT*gsr
	self.btn.album.h = self.btn.album.i:getHeight()*sT*gsr
	self.btn.album.s = sT*gsr
	self.btn.album.mcb = false
end

function Layer0:drawOutlines()
	love.graphics.rectangle('line',self.btn.newgame.x,self.btn.newgame.y,self.btn.newgame.w,self.btn.newgame.h)
	love.graphics.rectangle('line',self.btn.options.x,self.btn.options.y,self.btn.options.w,self.btn.options.h)
	love.graphics.rectangle('line',self.btn.album.x,self.btn.album.y,self.btn.album.w,self.btn.album.h)
end
