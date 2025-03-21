Player = {}

Player.Keyboard = {z=false}

function love.keypressed(key)
	if key == "z" then
		Player.Keyboard.z = true
	end
end

function love.mousepressed(mx,my)
	if #LevelLoader.ui > 0 then
		for i,v in ipairs(LevelLoader.ui)do
			if v:is(Level0) then
				v:mousepressed(mx,my)
			end
		end
	end
end

function Player.drawOutlines() -- See player activity for testings.
	-- Mouse activites:
	love.graphics.circle("line",cursor.x,cursor.y,5)
end
