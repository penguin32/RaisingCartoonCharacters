Player = {}

Player.Keyboard = {z=false}

function love.keypressed(key)
	if key == "z" then
		Player.Keyboard.z = true
	end
end

local pressedBool = false -- used in drawOutlines
function love.mousepressed(mx,my)
	pressedBool = true
	if #LevelLoader.ui > 0 then
		for i,v in ipairs(LevelLoader.ui)do
			if v:is(Level0) then
				v:mousepressed(mx,my)
			end
		end
	end
end

function love.mousereleased(mx,my)
	pressedBool = false
	if #LevelLoader.ui > 0 then
		for i,v in ipairs(LevelLoader.ui)do
			if v:is(Level0) then
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
	if pressedBool == true then
		love.graphics.circle("fill",cursor.x,cursor.y,5)
	end

end
