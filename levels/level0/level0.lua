Level0 = Object:extend()
local sT = 3 --scale of textboxes

function Level0:new()
	self.directory = "levels/level0/level0-assets/"
	self.music = love.audio.newSource(self.directory.."Boku No Senpai_Ongzellig.ogg","stream")
	self.music:setLooping(true)
	self.music:play()
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
	self.btn.newgame.sD = 0
	self.btn.newgame.t = 0
	self.btn.options = {}
	self.btn.options.i = love.graphics.newImage(self.directory.."t_options.png")
	self.btn.options.ib = love.graphics.newImage(self.directory.."tb_options.png")
	self.btn.options.x = self.btn.newgame.x
	self.btn.options.y = self.btn.newgame.y + 150*gsr
	self.btn.options.w = self.btn.options.i:getWidth()*sT*gsr
	self.btn.options.h = self.btn.options.i:getHeight()*sT*gsr
	self.btn.options.s = sT*gsr
	self.btn.options.sD = 0
	self.btn.options.t = 0
	self.btn.album = {}
	self.btn.album.i = love.graphics.newImage(self.directory.."t_album.png")
	self.btn.album.ib = love.graphics.newImage(self.directory.."tb_album.png")
	self.btn.album.x = self.btn.options.x
	self.btn.album.y = self.btn.options.y + 150*gsr
	self.btn.album.w = self.btn.album.i:getWidth()*sT*gsr
	self.btn.album.h = self.btn.album.i:getHeight()*sT*gsr
	self.btn.album.s = sT*gsr
	self.btn.album.sD = 0
	self.btn.album.t = 0
end

function Level0:mousepressed(mx,my)
end

function Level0:update(dt)
end

function Level0:tHover(button) --textBoxHover Highlight
	if cursor.x > button.x and cursor.x < button.x + button.w and cursor.y > button.y and cursor.y < button.y + button.h then
		love.graphics.draw(button.ib,button.x,button.y,0,button.s)
	else
		love.graphics.draw(button.i,button.x,button.y,0,button.s)
	end
end

function Level0:draw()
	love.graphics.draw(self.titleImage.i,self.titleImage.x,self.titleImage.y,0,gsr)
	self:tHover(self.btn.newgame)
	self:tHover(self.btn.options)
	self:tHover(self.btn.album)
end

-- Functions below are called with the loops of LevelLoader, then that LevelLoader function will be called
-- on main.lua, this way is for compartmentalizing it within only a single if-statement or by having an ability
-- of disabling or enabling a specific functions globaly, which means it affects all other levels,
-- I have a feeling its necessary also to write these functions out, wether it has none.
function Level0:updateScaling()
	self.titleImage.x,self.titleImage.y = game.cartX,game.cartY
	self.titleImage.w = self.titleImage.i:getWidth()
	self.titleImage.h = self.titleImage.i:getHeight()
	self.btn.newgame.x = game.middleX - 135*gsr
	self.btn.newgame.y = game.middleY + 100*gsr
	self.btn.newgame.w = self.btn.newgame.i:getWidth()*sT*gsr
	self.btn.newgame.h = self.btn.newgame.i:getHeight()*sT*gsr
	self.btn.newgame.s = sT*gsr
	self.btn.newgame.sD = 0
	self.btn.newgame.t = 0
	self.btn.options.x = self.btn.newgame.x
	self.btn.options.y = self.btn.newgame.y + 150*gsr
	self.btn.options.w = self.btn.options.i:getWidth()*sT*gsr
	self.btn.options.h = self.btn.options.i:getHeight()*sT*gsr
	self.btn.options.s = sT*gsr
	self.btn.options.sD = 0
	self.btn.options.t = 0
	self.btn.album.x = self.btn.options.x
	self.btn.album.y = self.btn.options.y + 150*gsr
	self.btn.album.w = self.btn.album.i:getWidth()*sT*gsr
	self.btn.album.h = self.btn.album.i:getHeight()*sT*gsr
	self.btn.album.s = sT*gsr
	self.btn.album.sD = 0
	self.btn.album.t = 0
end

function Level0:drawOutlines()
	love.graphics.rectangle('line',self.btn.newgame.x,self.btn.newgame.y,self.btn.newgame.w,self.btn.newgame.h)
	love.graphics.rectangle('line',self.btn.options.x,self.btn.options.y,self.btn.options.w,self.btn.options.h)
	love.graphics.rectangle('line',self.btn.album.x,self.btn.album.y,self.btn.album.w,self.btn.album.h)
end
