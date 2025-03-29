Player = {}

Player.Mouse = {isPressed=false}

Player.Keyboard = {
	m=false, --toggleMute, Keyboard
	mlatch=false,--toggleMute's latch
	mlatch2=false,
	up=false, --use for testing movements, for now theyre uncommented out
	down=false, --including down left right
	left=false,
	right=false,
	lctrl=false,
	one=false,
	two=false
}

Player.Viewport = { -- The main focus of love.graphics.translate()
--	velocity = 0,
	base_x = 0, -- use for LevelLoader, love.graphics.translate()
	base_y = 0
}--edited a variable name: the difference with Player.Camera and Player.Viewport is that
--Player.Viewport can move any objects or just move at all without any objects,
--with a camera, it has a rectangle that should collides the bondary of any given layer if provided.

Player.Viewport.ArrowKeys = function(dt, v) -- played inside update(dt) because of loop is(Camera)
--	Player.Viewport.velocity = 525*forZoomingIn -- for testing movements
--	--recently tested on rectangle movement,
--	long story short:
--	dy, dx is used in wo_to_x, wo_to_y variables
--	wo_to_x = dx - origin.x,	see where im getting at?
--	after that, that distance is being scaled by forZoomingIn
--	and is equated to self.x and y,
--	the reason it works this time, is because I inserted that object that is the player moving it
--	to the LevelLoader.objects this time,
--
--	last time it didnt work probably because i added camera on the LevelLoader.ui table which fucks up the
--	love.graphics.translation()
	if Player.Keyboard.up == true then
		v.dy = v.dy - v.v*dt
	end
	if Player.Keyboard.down == true then
		v.dy = v.dy + v.v*dt
	end
	if Player.Keyboard.left == true then
		v.dx = v.dx - v.v*dt
	end
	if Player.Keyboard.right == true then
		v.dx = v.dx + v.v*dt
	end
end -- i may re use this, so don't delete

function Player.update(dt)
	Player.Keyboard.updatePresses(dt)
	if #LevelLoader.objects > 0 then
		for i,v in ipairs(LevelLoader.objects)do
--			if v:is(Rectangle) and v.gameDev == true then
--				Player.Viewport.ArrowKeys(dt,v)
--				Player.Viewport.base_x = -v.x + game.middleX
--				Player.Viewport.base_y = -v.y + game.middleY
			if v:is(Camera) then
				Player.Viewport.base_x = -v.x + game.middleX
				Player.Viewport.base_y = -v.y + game.middleY
--			if v:is(Mymy) then
--				Player.Viewport.ArrowKeys(dt,v)
--				Player.Viewport.base_x = -v.x + game.middleX
--				Player.Viewport.base_y = -v.y + game.middleY


			--//EUREKA!
--	I fully understand it now! think of objects with and height,
--they need to be scaled by forZoomingIn variable, right,
--their coordinates however can also be scaled as forZoomingIn(scalar),
--to make the thoughts easier, think of the triangle-equality postulate,
--
--yeah i already know them from the start when i begun coding this shit,
--what makes it difficult is how i should implement it, not understanding love.graphics.translate() and
--only as a blackbox,
--
--i came up for a solution after multiple attempts of hypothising this shit for the last year of 2022,
--
--we have an origin.x&y to be (0,0) and they kept it the same value after love.graphics.translate,
--so I've decided to use that get the vectors of those objects
--		those objects's vectors is represented as self.dx, self.dy
--	their values should stay true regardless of love.graphics.translate,
--	meaning that if a stationary object on a coordinate with respect to the world origin(0,0)
--	and love.graphics.translate() is used LevelLoader.lua
--	it wouldn't affect their values,
--
--	so the conclusion that I came up would be to use that vector and scale it with forZoomingIn variable,

--	but i came across with a problem that updating a variable that is being multiplied to itself is not a
--	good idea as it changes that value during runtime.
--		self.dx = (self.dx - origin.x)*forZoomingIn   which is a bitch
--
--	so a better idea  would be create a new variable(self.x,y) that is after being scaled by a scalar
--		self.wo_to_dx = self.dx-origin.x --x-component from dx(change in x) to origin.x
--		self.wo_to_dy = self.dy-origin.y
--		self.x = self.wo_to_dx*forZoomingIn
--		self.y = self.wo_to_dy*forZoomingIn
--
--
--self.x and self.y are only use in love.graphics.draw() etc...
--	for position as their new-coordinates after zoom function,
--	while self.dx and self.dy acts as their original coordinate that can be change and affected,
--	hence not needing of scaling the object's velocity anymore, like those java games tutorial that
--	i couldn't bare to watch for some reason.
--
--	as for the usage of love.graphics.translate()
--	it translate toward the objects on the screen the thing we see, windows pixel, i dont' actually know what
--	it calls but once i understand that it follows the objects that im trying to follow,
--	i had an ephiphany of using self.x and self.y as the focus of that function translate() because
--	that scaled new-coordiantes is that object's position, and that dx,dy are just information hidden
--	 from our eyes.
			end
		end
	end
end

Player.Keyboard.updatePresses = function(dt)
	local rate = 0.5*2
	if Player.Keyboard.lctrl == true and Player.Keyboard.one == true then
		newForZoomingIn = newForZoomingIn + rate*dt
		if newForZoomingIn > 1.5 then --at start of the game, this should be maxed zoom value :)
			newForZoomingIn = 1.5
		end
	end
	if Player.Keyboard.lctrl == true and Player.Keyboard.two == true then
		newForZoomingIn = newForZoomingIn - rate*dt
		if newForZoomingIn < 0.05 then
			newForZoomingIn = 0.05
		end
	end
	toggleMute, Player.Keyboard.mlatch, Player.Keyboard.mlatch2 = latch( Player.Keyboard.m, Player.Keyboard.mlatch, Player.Keyboard.mlatch2, toggleMute)
end

local fullscreen = false
function love.keypressed(key)
	if key == "f11" then  --HEHE I don't need toggle "latch() function" for keyboard!
				--but it doesn't works on combine presses because the moment
				--love.keyboard.isDown() is run on update(), it will switch so fast like
				--light flickering when a keys is held down.
				--but i didn't use isDown, i went with just check each individuals keys long
				--story short, at updatePresses()
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen,"exclusive")
	end
	if key == 'm' then
		Player.Keyboard.m = true
	end
	if key == "up" then
		Player.Keyboard.up = true
	end
	if key == "down" then
		Player.Keyboard.down = true
	end
	if key == "left" then
		Player.Keyboard.left = true
	end
	if key == "right" then
		Player.Keyboard.right = true
	end
	if key == "lctrl" then
		Player.Keyboard.lctrl = true
	end
	if key == '1' then
		Player.Keyboard.one = true
	end
	if key == '2' then
		Player.Keyboard.two = true
	end
end

function love.keyreleased(key)
	if key == 'm' then
		Player.Keyboard.m = false
	end
	if key == "up" then
		Player.Keyboard.up = false
	end
	if key == "down" then
		Player.Keyboard.down = false
	end
	if key == "left" then
		Player.Keyboard.left = false
	end
	if key == "right" then
		Player.Keyboard.right = false
	end

	if key == "lctrl" then
		Player.Keyboard.lctrl = false
	end
	if key == '1' then
		Player.Keyboard.one = false
	end
	if key == '2' then
		Player.Keyboard.two = false
	end
end

function love.mousepressed(mx,my)
	Player.Mouse.isPressed = true
	if #LevelLoader.ui > 0 then
		for i,v in ipairs(LevelLoader.ui)do
			if v:is(Layer0) then
				v:mousepressed(mx,my)
			end
		end
	end
--	if #LevelLoader.objects > 0  -- STOP! note to self, not all objects, should be clickable!,
--					don't bloat shit.
end

function love.mousereleased(mx,my)
	Player.Mouse.isPressed = false
	if #LevelLoader.ui > 0 then
		for i,v in ipairs(LevelLoader.ui)do
			if v:is(Layer0) then
				v:mousereleased(mx,my)
			end
		end
	end
end

function love.mousemoved(mx,my,mdx,mdy)
	cursor.x,cursor.y = mx,my
end

function Player.drawOutlines() -- See player activity for testings.
	-- Mouse activites:
	love.graphics.circle("line",cursor.x,cursor.y,5)
	if Player.Mouse.isPressed == true then
		love.graphics.circle("fill",cursor.x,cursor.y,5)
	end
	-- Keyboard activities:
	if Player.Keyboard.m == true then
		love.graphics.print("m active: pressed",game.cartX+30*gsr,game.cartY)
	else
		love.graphics.print("m active: released",game.cartX+30*gsr,game.cartY)
	end
	-- Others:
	love.graphics.print("forZoomingIn: "..forZoomingIn,game.cartX+30*gsr,game.cartY+30*gsr)
	love.graphics.print("origin x:"..origin.x.." ,origin y: "..origin.y ,game.cartX+30*gsr,game.cartY+60*gsr)
	love.graphics.print("base_x and y :" ..Player.Viewport.base_x.." , "..Player.Viewport.base_y,game.cartX + 30*gsr, game.cartY+290*gsr)
	love.graphics.print("origin to middleXY :" ..game.middleX-origin.x.." , "..game.middleY-origin.y,game.cartX + 30*gsr, game.cartY+150*gsr)
end
