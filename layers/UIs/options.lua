Options = Object:extend()
local sT = 1--choosen scale, name idea came from "scale text" to test out scaling of width and height
			--button of layer0 text boxes.
--Called by the players using it, which is the camera class, camera.lua

function Options:new()
	self.selectedOption = ""
	self.list = {} --table of options, list of options
	self.circle = {--remember to update its coordinates due to the fact that game.middleX/Y changes in runtime
		x = game.middleX,
		y = game.middleY,
		r = 300*gsr
	}
	self.mov = 800*gsr --move options velocity
	self.directory = "layers/globalAssets/options/"
	self.gA = "layers/globalAssets/"


	self.help={}
	self.help.name = "help"
	self.help.i = love.graphics.newImage(self.directory.."help.png")
	self.help.ib = love.graphics.newImage(self.directory.."help1.png")
	self.help.w = self.help.i:getWidth()*sT*gsr
	self.help.h = self.help.i:getHeight()*sT*gsr
	self.help.x,self.help.y = self.circle.x-(self.help.w/2)*gsr,self.circle.y-(self.help.h/2)*gsr
	self.help.ix,self.help.iy = self.circle.x-(self.help.w/2)*gsr,self.circle.y-(self.help.h/2)*gsr--initial
				--ix,iy, should also be updated in scaling, as stated above reason middleX/Y
				--self.circle.x/y changes in runtime.
	self.help.s = gsr*sT
	self.help.mBrushOnce = true
	self.help.mBrush = love.audio.newSource(self.gA.."brush-sfx-behold.ogg","static")
	self.help.mcb = false
	self.help.ir = -math.pi --initial/ starting radian
			--just incase my future self wants to appends options or manage list of options in-game
			--then you(my future self) must write automated manager for object.ir
			--what i meant to say is divide it by some value by 3, 3 objects within 0 to math.pi
			--if list is more than 6 maximum maybe then add "next page" that'll switch list options
			--like pages of a book.
	self.help.magnitude = 0
	self.help.setX = 0
	self.help.setY = 0
	self.help.ssm = false --stop scaling magnitude (use in camera.lua) when exiting options
	--I want to add a new variable that disable rotation(radian adding) for a unique function
	--that is about to be made, and passed as an argument inside the tHover() function's parameter.
	--Nvr mind, we have button.mcb, no need to pass function inside parameter since I could just run them
	--here, and they works like actual button, when clicked it'll be true, when keyreleased it'll be false,
	--good example of this is the starting first game menu NewGame button
	self.help.runOnce = false
	self.help.selected = false
	self.help.latch = false
	self.help.latch2 = true
	self.help.mcb_func_true = function ()
	end

	self.look={}
	self.look.name = "look"
	self.look.i = love.graphics.newImage(self.directory.."look_for_items.png")
	self.look.ib = love.graphics.newImage(self.directory.."look_for_items1.png")
	self.look.w = self.look.i:getWidth()*sT*gsr
	self.look.h = self.look.i:getHeight()*sT*gsr
	self.look.x,self.look.y = self.circle.x-(self.look.w/2)*gsr,self.circle.y-(self.look.h/2)*gsr
	self.look.ix,self.look.iy = self.circle.x-(self.look.w/2)*gsr,self.circle.y-(self.look.h/2)*gsr
	self.look.s = gsr*sT
	self.look.mBrushOnce = true
	self.look.mBrush = love.audio.newSource(self.gA.."brush-sfx-behold.ogg","static")
	self.look.mcb = false
	self.look.ir = -math.pi/2
	self.look.magnitude = 0
	self.look.setX = 0
	self.look.setY = 0
	self.look.ssm = false
	self.look.runOnce = false
	self.look.selected = false
	self.look.latch = false
	self.look.latch2 = true
	self.look.mcb_func_true = function ()
	end


	self.bag={}
	self.bag.name = "bag"
	self.bag.i = love.graphics.newImage(self.directory.."bag.png")
	self.bag.ib = love.graphics.newImage(self.directory.."bag1.png")
	self.bag.w = self.bag.i:getWidth()*sT*gsr
	self.bag.h = self.bag.i:getHeight()*sT*gsr
	self.bag.x,self.bag.y = self.circle.x-(self.bag.w/2)*gsr,self.circle.y-(self.bag.h/2)*gsr
	self.bag.ix,self.bag.iy = self.circle.x-(self.bag.w/2)*gsr,self.circle.y-(self.bag.h/2)*gsr
	self.bag.s = gsr*sT
	self.bag.mBrushOnce = true
	self.bag.mBrush = love.audio.newSource(self.gA.."brush-sfx-behold.ogg","static")
	self.bag.mcb = false
	self.bag.ir = 0
	self.bag.magnitude = 0
	self.bag.setX = 0
	self.bag.setY = 0
	self.bag.ssm = false
	self.bag.runOnce = false
	self.bag.selected = false
	self.bag.latch = false
	self.bag.latch2 = true
	self.bag.mcb_func_true = function ()
	end

	self.gBB = {} --goBackButton
	self.gBB.i = love.graphics.newImage(self.directory.."goBack.png")
	self.gBB.ib = love.graphics.newImage(self.directory.."goBack1.png")
	--------------
	self.gBB.w = self.gBB.i:getWidth()*sT*gsr
	self.gBB.h = self.gBB.i:getHeight()*sT*gsr
	self.gBB.x = game.cartX+(game.width*9/10)*gsr - self.gBB.w
	self.gBB.y = game.cartY+(game.height*9/10)*gsr - self.gBB.h
	self.gBB.s = sT*gsr	--note to self: keep this things updating because of gsr
	self.gBB.mBrushOnce = true
	self.gBB.mBrush = love.audio.newSource(self.gA.."brush-sfx-behold.ogg","static")
	self.gBB.mcb = false
	self.gBB.runOnce = false
	self.gBB.mcb_func_true = function (object)
		for i,v in ipairs(object.list) do
			if v.selected == true then
				v.selected = false
				v.latch = false
				v.latch2 = true
				object.selectedOption = ""
			end
		end
	end

	table.insert(self.list,self.help)
	table.insert(self.list,self.look)
	table.insert(self.list,self.bag)
	self:updateScaling()
end

function updateSwitch(thisThing) --"thisThing" aka "one of the Options" here, aka help, look, bag...
	--will continually update the options that is given, base on mcb
	--Because having this function run within mcb_func_true, always gets cut abruptly :(
	--for it to work, it needed to be continually updated for as long as it can, which is why its
	--preferable to just kept this running inside update(),
	if thisThing.ssm then --ssm, it works! it prevent selected variable from being activated while the cursor
		--hovers over it during its rotating animation.
		thisThing.selected,thisThing.latch,thisThing.latch2 = latch( thisThing.mcb, thisThing.latch,thisThing.latch2,thisThing.selected)
	end
end
function Options:update(dt)
	if self.selectedOption == "" then
		for i,v in ipairs(self.list) do
			if v.magnitude < self.circle.r and not(v.ssm) then
				v.magnitude = v.magnitude + self.mov*dt
			else
				v.ssm = true --the reason why I have no need to set them back to its default value
						--is because when I close the options,
						--and re-opens them, v.ssm will be set initially back to false
						--here, setting it true is for the camera.lua
						--when its closes it has its animation base on that bool.
						--
				--Sept 1 2025:
				--now needed for updateSwitch(v) and/or Camera:update() --> options == 1
				--im gonna be also using this for preventing setting off boolean on ui options
				--while the options animation is currently playing.
			end
			v.setY = v.magnitude*math.sin(v.ir)
			v.setX = v.magnitude*math.cos(v.ir)
			v.x,v.y = v.ix+v.setX,v.iy+v.setY
			v.ix,v.iy = self.circle.x-(v.w/2)*gsr,self.circle.y-(v.h/2)*gsr--initial
			v.ir = v.ir +0.5*dt
		end
		for i,v in ipairs(self.list) do
			tHoverUI(v)
			updateSwitch(v)
			if v.selected == true then
				self.selectedOption = v.name
			end
		end
	else
		self.gBB.w = self.gBB.i:getWidth()*sT*gsr
		self.gBB.h = self.gBB.i:getHeight()*sT*gsr
		self.gBB.x = game.cartX+(game.width*9/10)*gsr - self.gBB.w
		self.gBB.y = game.cartY+(game.height*9/10)*gsr - self.gBB.h
		self.gBB.s = sT*gsr	--note to self: keep this things updating because of gsr
		tHoverUI(self.gBB,self)
	end
end

function Options:draw()
	if self.selectedOption == "" then
		for i,v in ipairs(self.list) do
			tHoverUIDraw(v)
			if showOutlines == true then
				love.graphics.setColor(0,0,0)
				love.graphics.print("selected: "..tostring(v.selected),v.x,v.y+v.w+20)
				love.graphics.print("mcb: "..tostring(v.mcb),v.x,v.y+v.w+40)
				love.graphics.setColor(1,1,1)
			end
		end
	else
		tHoverUIDraw(self.gBB)
	end
end

--Unique functions:
--Special functions:
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
