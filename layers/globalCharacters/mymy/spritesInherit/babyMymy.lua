--//How does this work?
--character has simpleMovement
--	--> they inherits chosen colliders
--	--> here they inherit specific class of sprites
--why not just create a function that specific for loading sprites?
--because while that may be sound like a good idea, when a character is wearing
--a skin, i tend to plan on giving them certain unique function that is only usable
--when a character is wearing this skin,
--and also that its pretty useful to just refer to the self.variables that inherited it
--and i could just call off this function if i wanted to, and its group together so neatly 
--	simpleMovement(for moving) --> character(for drawing order, for now) --> mymy --> (now here) which
--		skins to wear and what functions it can call upon at mymy.lua
--
--mymy.lua is not gonna be a baby forever
BabyMymy = Object:extend()

function BabyMymy:loadImgSprite(init_scale)
	self.init_scale = init_scale or 1
	self.scale = init_scale or 1
	self.skin = love.graphics.newImage("layers/globalCharacters/mymy/sprites_babyMymy/idle_1.png")
--	self.ofdx = self.skin:getWidth()*forZoomingIn/2	--offset for draw, self.x
--	self.ofdy = self.skin:getHeight()*forZoomingIn
	self:updateScalingSprite() -- need to be called once
			--because of LevelLoader.updateLevelScaling() at main.lua
			--it runs only when zoom function happens,
			--so i better watch out for bugs if i need to make some exception
			--for scaling during run time.
end

function BabyMymy:drawSprite()
	love.graphics.draw(self.skin,self.x-self.ofdx,self.y-self.ofdy,nil,self.scale)
end

--Unique functions:
function BabyMymy:defacate()
	table.insert(LevelLoader.objects,Shit(self.dx,self.dy,1/2)) --shit init_scale, 1/2 is a must,
								--i must fix this to make this argument changable
end

--Special functions:
function BabyMymy:updateScalingSprite()
	if self.init_scale ~= nil then
		self.scale = self.init_scale*forZoomingIn
	end
	if self.skin ~= nil then
		self.ofdx =self.skin:getWidth()*self.scale/2 --self.skin:getWidth()*forZoomingIn/2
		self.ofdy =(self.skin:getHeight()-30)*self.scale --(self.skin:getHeight()-20)*forZoomingIn
	end
end
