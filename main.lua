function love.load()
	showOutlines = false	--Show shape outlines, colliders, interact and text attributes.
	newForZoomingIn = 2
	forZoomingIn = 2	--Is used for attribs in game objects' like scaling/distances.
				--multiplied beside game.scale,
				--	Because game.scale take care of the in-game objects if the
				--	viewport is small.
				--	Multiplying forZoomingIn beside it, takes care which objects
				--	we want to scale,
				--	and dividing game.scale with it, follows the scaling of the
				--	viewport,
				--	which negates that "zooming" effect and only follows
				--	viewport's scaling.
	window = { width = love.graphics.getWidth(), height = love.graphics.getHeight() }--runtime update!
	window.newWidth = 0
	window.newHeight = 0
	game = { width = 2048, height = 1427, cartX = 0, cartY = 0 }
	game.scale = getScale(window.width,window.height) -- Is for configuring ratios of in-game objs.
				-- Is dependent of the viewport's resolution.
				-- Use to compensate with the devices(android's screen, desktop)
	--Do not repeat mathematic operations dumb ass,
	gsr = game.scale/forZoomingIn -- global scale ratio
		--use by cartScale, so gsr should be ran first,before cartScale, and during update.
	game.cartX,game.cartY = cartScale(game.cartX,game.cartY) -- Is for telling visible coord(0,0),
				-- Regardless of viewport's width & height ratio.
	game.middleX = game.cartX + game.width*(gsr)/2
	game.middleY = game.cartY + game.height*(gsr)/2 -- Middle part of viewport,
				-- Regardless of viewport's width & height ratio.
	cursor = { x = 0, y = 0, visible = true }
	cursor.x, cursor.y = game.middleX, game.middleY
--	love.mouse.setRelativeMode(true) -- Hides mouse cursor and lock mouse inside window,
					-- not sure if I want to make an in game mouse.
					-- note(wiki) if setRelativeMode == true, x,y are not guaranteed to...
	love.mouse.setPosition(game.middleX,game.middleY) -- shit stopped working after multiple attempts of 
							--debugging along love.mouse.getPosition()
							--nvm, I switch to using love.mousemoved at controls.lua
							--maybe it works on windows.
	font = love.graphics.newFont(34*(gsr)) --runtime update!
--modules
	Object = require "modules.classic.classic"
	require "modules.modulesOutsideLove2d.strict"
--scripts
	require "scripts.controls"
	require "scripts.gameData"
--objectShapes
	require "scripts.objectShapes.circle"
	require "scripts.objectShapes.isometric"
	require "scripts.objectShapes.isometricBeta"
	require "scripts.objectShapes.isometricInteract"
	require "scripts.objectShapes.rectangle"
--typesOfObjects
	require "scripts.typesOfObjects.explorableArea"
	require "scripts.typesOfObjects.flooredIsometricObject"

--levels
	require "levels.level0.level0"
	require "scripts.levelLoader" --require the levels first before the levelLoader.
	LevelLoader.load(0)
end

function love.update(dt)
	LevelLoader.update(dt)
	updateEveryScale()
end

function love.draw()
	LevelLoader.draw()

	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.setColor(0,0,0)
	drawOutlines()
	drawBorders()
        love.graphics.setColor(1,1,1)

	--Draw Player's controllers below here, if Im going to add android joystick etc,draw-orders matters...
end

function getScale(w,h)
	local sx,sy = w*forZoomingIn/game.width, h*forZoomingIn/game.height
	if sx <= sy then return sx else return sy end
end

function cartScale(x,y)
	local sx,sy = window.width/game.width, window.height/game.height
	if sx < sy then return x,y+(window.height - game.height*(gsr))/2 else return x+(window.width - game.width*(gsr))/2,y end
end

function updateEveryScale()
	window.newWidth = love.graphics.getWidth()
	window.newHeight = love.graphics.getHeight()
	if window.newWidth ~= window.width or window.newHeight ~= window.height or newForZoomingIn ~= forZoomingIn then
		forZoomingIn = newForZoomingIn
		window.width = window.newWidth
		window.height = window.newHeight
		game = { width = 2048, height = 1427, cartX = 0, cartY = 0 }
		game.scale = getScale(window.width,window.height)
		gsr = game.scale/forZoomingIn -- global scale ratio, run first before cartScale
		game.cartX,game.cartY = cartScale(game.cartX,game.cartY)
		game.middleX = game.cartX + game.width*(gsr)/2
		game.middleY = game.cartY + game.height*(gsr)/2
		font = love.graphics.newFont(34*(gsr))
		love.graphics.setFont(font)
		LevelLoader.updateLevelScaling()
	end
end

function drawOutlines()
	if showOutlines == true then
		love.graphics.setColor(0.5,0,0)
	-- it tells where is game.middleX and middleY
		love.graphics.rectangle("fill",game.middleX,game.middleY,10,10)
	-- show top left side, new origin, that is visible in the game, after translated by borders
		love.graphics.rectangle("fill",game.cartX,game.cartY,10,10)
	-- shows Player activities like mouse cursor clicked buttons coordinates etc..
		Player.drawOutlines()
	-- for Levels, hitbox, click area etc..
		LevelLoader.drawOutlines()
		love.graphics.setColor(0,0,0)
	end
end

function drawBorders()
	-- Four rectangles below acts as borders.
        love.graphics.rectangle("fill",0,0,game.cartX,window.width)
        love.graphics.rectangle("fill",game.cartX+game.width*(gsr),0,game.cartX,window.width)
        love.graphics.rectangle("fill",0,0,window.width,game.cartY)
        love.graphics.rectangle("fill",0,game.cartY+game.height*(gsr),game.width,game.cartY)
end
