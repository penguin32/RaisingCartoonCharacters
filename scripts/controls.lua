Player = {}

Player.Mouse = {isPressed=false}

Player.Keyboard = {
	z=false, -- just for testing, remove later
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
	base_y = 0,
}

--Player.Camera.ArrowKeys = function(dt, v) -- played inside update(dt) because of loop is(Camera)
--	Player.Camera.velocity = 525*forZoomingIn -- for testing movements
--	if Player.Keyboard.up == true then
--		v.base_y = v.base_y - Player.Camera.velocity*dt
--	end
--	if Player.Keyboard.down == true then
--		v.base_y = v.base_y + Player.Camera.velocity*dt
--	end
--	if Player.Keyboard.left == true then
--		v.base_x = v.base_x - Player.Camera.velocity*dt
--	end
--	if Player.Keyboard.right == true then
--		v.base_x = v.base_x + Player.Camera.velocity*dt
--	end
--end -- i may re use this, so don't delete

function Player.update(dt)
	Player.Keyboard.updatePresses(dt)
	if #LevelLoader.ui > 0 then
		for i,v in ipairs(LevelLoader.ui)do
			if v:is(Camera) then
--				Player.Camera.ArrowKeys(dt,v)
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
end

function love.keypressed(key)
	if key == 'z' then
		Player.Keyboard.z = true
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
	if key == 'z' then
		Player.Keyboard.z = false
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
	if Player.Keyboard.z == true then
		love.graphics.print("z active: pressed",game.cartX+30*gsr,game.cartY)
	else
		love.graphics.print("z active: released",game.cartX+30*gsr,game.cartY)
	end
	-- Others:
	love.graphics.print("forZoomingIn: "..forZoomingIn,game.cartX+30*gsr,game.cartY+30*gsr)
	love.graphics.print("origin x:"..origin.x.." ,origin y: "..origin.y ,game.cartX+30*gsr,game.cartY+60*gsr)
	love.graphics.print("base_x and y :" ..Player.Camera.base_x.." , "..Player.Camera.base_y,game.cartX + 30*gsr, game.cartY+290*gsr)
	love.graphics.print("origin to middleXY :" ..game.middleX-origin.x.." , "..game.middleY-origin.y,game.cartX + 30*gsr, game.cartY+150*gsr)
end
