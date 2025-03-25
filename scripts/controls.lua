Player = {}

Player.Mouse = {isPressed=false}

Player.Keyboard = {
	mlatch=false,
	mlatch2=false,
	m=false, --toggleMute
	up=false,
	down=false,
	left=false,
	right=false,
	lctrl=false,
	one=false,
	two=false
}

Player.Camera = {
--	velocity = 0,
	base_x = 0, -- use for LevelLoader, love.graphics.translate()
	base_y = 0
}

Player.Camera.ArrowKeys = function(dt, v) -- played inside update(dt) because of loop is(Camera)
--	Player.Camera.velocity = 525*forZoomingIn -- for testing movements
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
	--		if v:is(Rectangle) and v.group == 1 then
			if v:is(Camera) then
--				Player.Camera.ArrowKeys(dt,v)
		--tested on rectangle, cant believe it actually works this time,
		--my guess would be because i am now translating with respect to that LevelLoader.objects
		--and not ui
--				Player.Camera.base_x = -v.dx*forZoomingIn + game.middleX
--				Player.Camera.base_y = -v.dy*forZoomingIn + game.middleY
				Player.Camera.base_x = -v.base_x*forZoomingIn + game.middleX
				Player.Camera.base_y = -v.base_y*forZoomingIn + game.middleY
			end
		end
	end
end

Player.Keyboard.updatePresses = function(dt)
	local rate = 0.5*2
	if Player.Keyboard.lctrl == true and Player.Keyboard.one == true then
		newForZoomingIn = newForZoomingIn + rate*dt
		if newForZoomingIn > 10 then
			newForZoomingIn = 10
		end
	end
	if Player.Keyboard.lctrl == true and Player.Keyboard.two == true then
		newForZoomingIn = newForZoomingIn - rate*dt
		if newForZoomingIn < 0.05 then
			newForZoomingIn = 0.05
		end
	end
	if Player.Keyboard.m == false and Player.Keyboard.mlatch2 == true then
		if Player.Keyboard.mlatch == false then
			Player.Keyboard.mlatch = true
		else
			Player.Keyboard.mlatch = false
		end
		Player.Keyboard.mlatch2 = false
	end
	if Player.Keyboard.m == true then
		Player.Keyboard.mlatch2 = true
		if Player.Keyboard.mlatch == true then
			toggleMute = true
		else
			toggleMute = false
		end
	end
end

function love.keypressed(key)
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
	love.graphics.print("base_x and y :" ..Player.Camera.base_x.." , "..Player.Camera.base_y,game.cartX + 30*gsr, game.cartY+290*gsr)
	love.graphics.print("origin to middleXY :" ..game.middleX-origin.x.." , "..game.middleY-origin.y,game.cartX + 30*gsr, game.cartY+150*gsr)
end
