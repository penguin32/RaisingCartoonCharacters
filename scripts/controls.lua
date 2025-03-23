Player = {}

Player.Mouse = {isPressed=false}

Player.Keyboard = {
	z=false, -- just for testing, remove later
	lctrl=false,
	one=false,
	two=false
}

function Player.update()
	Player.Keyboard.updateCombinePresses()
end

Player.Keyboard.updateCombinePresses = function()
	if Player.Keyboard.lctrl == true and Player.Keyboard.one == true then
		newForZoomingIn = newForZoomingIn + 0.05
		if newForZoomingIn > 10 then
			newForZoomingIn = 10
		end
	end
	if Player.Keyboard.lctrl == true and Player.Keyboard.two == true then
		newForZoomingIn = newForZoomingIn - 0.05
		if newForZoomingIn < 0.05 then
			newForZoomingIn = 0.05
		end
	end
end

function love.keypressed(key)
	if key == 'z' then
		Player.Keyboard.z = true
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
end
