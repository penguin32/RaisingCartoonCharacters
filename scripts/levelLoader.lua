LevelLoader = {
	ui={},
	objects={}
	-- This is how I interpret levels directory,
	-- UIs drawing orders doesn't matter, they scaled with mostly grs,game.middleX etc, game.cartX etc.
	-- Objects on the other hand, their drawing orders will be sorted out, according to SortObjects rules,
	-- and is percieved as isometric map.
}

function LevelLoader.load(level,lvlBool)
	LevelLoader.level = level or 0
	LevelLoader.bool = lvlBool or false -- This need to explicitly told to be 'true' when 
	-- switching level between, so that after the update of moving to a new level, table.insert wouldn't
	-- run a multiple instance of the layers.
end

function LevelLoader.update(dt)
	-- we are in the update, gotta be careful what i set my variables here,
	if LevelLoader.level == 0 and LevelLoader.bool == true then -- The MainMenu
		table.insert(LevelLoader.ui,Layer0()) 
		-- Always empty out your LevelLoader.ui or objects tables
		-- first on the interacted txtbox for example within their if-statement before inserting a
		-- new layers from this LevelLoader's table, then
		LevelLoader.bool = false -- remember to always set this back to false, after if-statements here.
	elseif LevelLoader.level == 1 and LevelLoader.bool == true then -- The Home
		table.insert(LevelLoader.objects,Layer1(-1024,-713.5,1))
		--test (rectangle collisions, collided variable, bugs):
--		table.insert(LevelLoader.objects,Rectangle(0,0,200,200,1,false,0,true,500,true))
		LevelLoader.bool = false
	end

	if #LevelLoader.objects > 0 then
		table.sort(LevelLoader.objects, LevelLoader.SortObjects)
		for i,v in ipairs(LevelLoader.objects)do
			v:update(dt)
		end
	end

	if #LevelLoader.ui > 0 then
		for i,v in ipairs(LevelLoader.ui)do
			v:update(dt)
		end
	end
end

function LevelLoader.draw()
	love.graphics.push()
--	love.graphics.scale(forZoomingIn) -- test phase --iremember now why i stopped using this
--		it only works on drawings :(
	love.graphics.translate(Player.Viewport.base_x,Player.Viewport.base_y)
	if #LevelLoader.objects > 0 then
		for i,v in ipairs(LevelLoader.objects)do
--			if v:is(Circle) or v:is(Rectangle) or v:is(Isometric) then
--				--To see the collider as black outline.
--				love.graphics.setColor(0,0,0)
--				v:draw()--im planning to replace thems as drawOutlines, in the future
--				love.graphics.setColor(1,1,1)
--			else
				v:draw()
--			end
		end
	end
	love.graphics.pop()

	if #LevelLoader.ui > 0 then
		for i,v in ipairs(LevelLoader.ui)do
			v:draw()
		end
	end
end

-- Double check drawing order, March 2025, because of the new changes and understanding
-- with love.graphics.translate, simpleMovements.lua, shit forZoomingIn function may have an affect on it.

function LevelLoader.SortObjects(a,b)
        if a:is(Isometric) and b:is(Isometric) then -- Just objectShapes below
                return b.y > a.y
        elseif a:is(Isometric) and b:is(Rectangle) then
                if  b.y > a.y2 and b.y > (a.ml*(b.x-a.x)+a.y) then
                        return true
                elseif b.y > a.y3 and b.y > (a.mr*(b.x-a.x)+a.y) then
                        return true
                else
                        return false
                end
        elseif a:is(Rectangle) and b:is(Isometric) then
                if a.y > b.y2 and a.y > (b.ml*(a.x-b.x)+b.y) then
                        return false
                elseif a.y > b.y3 and a.y > (b.mr*(a.x-b.x)+b.y) then
                        return false
                else
                        return true
                end
                                        -- Rectangle,Circle/Character,Isometric (HEREE)
        elseif a:is(Isometric) and (b:is(Circle) or b:is(Character)) then
                if  b.y > a.y2 and b.y > (a.ml*(b.x-a.x)+a.y) then
                        return true
                elseif b.y > a.y3 and b.y > (a.mr*(b.x-a.x)+a.y) then
                        return true
                else
                        return false
                end
        elseif (a:is(Circle) or a:is(Character)) and b:is(Isometric) then
                if a.y > b.y2 and a.y > (b.ml*(a.x-b.x)+b.y) then
                        return false
                elseif a.y > b.y3 and a.y > (b.mr*(a.x-b.x)+b.y) then
                        return false
                else
                        return true
                end
        elseif a:is(Rectangle) and b:is(Rectangle) then
                return b.y > a.y
        elseif a:is(Rectangle) and (b:is(Circle) or b:is(Character)) then
                return b.y > a.y
        elseif (a:is(Circle) or a:is(Character)) and b:is(Rectangle) then
                return b.y > a.y
        elseif (a:is(Circle) or a:is(Character)) and (b:is(Circle) or b:is(Character)) then
                return b.y > a.y
        elseif a:is(FlooredIsometricObject) and b:is(FlooredIsometricObject) then
                                        --For the FlooredIsometricObject (HEREE)
                return b.y > a.y

        elseif a:is(FlooredIsometricObject) and b:is(Rectangle) then
                return true
        elseif a:is(Rectangle) and b:is(FlooredIsometricObject) then
                return false

        elseif a:is(FlooredIsometricObject) and b:is(Circle) then
                return true
        elseif a:is(Circle) and b:is(FlooredIsometricObject) then
                return false

        elseif a:is(FlooredIsometricObject) and b:is(Isometric) then
                return true
        elseif a:is(Isometric) and b:is(FlooredIsometricObject) then
                return false

        elseif a:is(FlooredIsometricObject) and b:is(Character) then
                return true
        elseif a:is(Character) and b:is(FlooredIsometricObject) then
                return false

        elseif a:is(ExplorableArea) and b:is(FlooredIsometricObject)  then
                        --For the floor to drawn first on the canvas   ExplorableArea (HEREE)
                return true
        elseif a:is(FlooredIsometricObject) and b:is(ExplorableArea)  then
                return false
        elseif a:is(ExplorableArea) and b:is(Isometric) then
                return true
        elseif a:is(Isometric) and b:is(ExplorableArea) then
                return false
        elseif a:is(ExplorableArea) and b:is(Rectangle) then
                return true
        elseif a:is(Rectangle) and b:is(ExplorableArea) then
                return false
        elseif a:is(ExplorableArea) and b:is(Circle) then
                return true
        elseif a:is(Circle) and b:is(ExplorableArea) then
                return false
        elseif a:is(ExplorableArea) and b:is(Character) then
                return true
        elseif a:is(Character) and b:is(ExplorableArea) then
                return false
        elseif a:is(ExplorableArea) and b:is(ExplorableArea) then
                return b.y > a.y
	else
		--do nothing, it maybe the camera, when ui to objects now
        end
end

-- Functions below are compartmentalized, for the reason to give main.lua the ability to either
-- enable or disable those functions or just to group them together inside a single if-statement.

function LevelLoader.updateLevelScaling()--ran inside main.lua updateEveryScale()'if-statement
	--checks UIs and Objects table scaling
	if #LevelLoader.objects > 0 then
		for i,v in ipairs(LevelLoader.objects)do
			v:updateScaling()
		end
	end

	if #LevelLoader.ui > 0 then
		for i,v in ipairs(LevelLoader.ui)do
			v:updateScaling()
		end
	end
end

function LevelLoader.drawOutlines()
	--cant add objects.drawOutlines here, they don't get translated :(, not sure how i would compartmentalize
	--but they get covered under images because of drawing order so... ill just add another if statements
	love.graphics.push()
--	love.graphics.scale(forZoomingIn) -- test phase
	if #LevelLoader.objects > 0 then
	love.graphics.translate(Player.Viewport.base_x,Player.Viewport.base_y)
		for i,v in ipairs(LevelLoader.objects)do
--			if not(v:is(Camera)) then
--				v:drawOutlines()
--			end
			v:drawOutlines()
		end
	end
	love.graphics.circle("fill",origin.x,origin.y,15*gsr)
	love.graphics.pop()

--	if #LevelLoader.objects >0 then -- i just made an exception to this Camera, Im testing out
--			-- if it could collides with the rectangles regardless of wierd translation.
--			-- for now im deciding wether i should extend objectShapes rectangle from Objects classic
--			-- I should save first before trying that
--			-- now that im atleast a bit confident that zoom functionality wouldnt affect npc movement
--		for i,v in ipairs(LevelLoader.objects)do
--			if v:is(Camera) then
--				v:drawOutlines()
--			end
--		end
--	end
	if #LevelLoader.ui > 0 then
		for i,v in ipairs(LevelLoader.ui)do
			v:drawOutlines()
		end
	end
end
