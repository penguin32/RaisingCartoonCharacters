--works by having some single bool to toggle on/off like a button(flip switch) doesn't have to be just keyboard
-- when trying to use this, you need a table ready with a 1.bool var(that's flip switch) and 2.two latches, and 3.set all those to false first (wrong)
-- correction: switch == false	, then outside-force-thefinger-to-flipit=false aka outsideForce=false
-- 		latch 1 == true
-- 		latch 2 == false
-- 	for it to work!
--	switch,latch1,latch2 = latch( outsideForce, latch1, latch2, switch)
-- run this function on update() and it will return you a boolean variable that has been toggled
function latch(flip,vlatch,vlatch2,tcs) 	--tcs stands for toggle current states, I need that so I'll have something to return
	if flip == false and vlatch2 == true then
		if vlatch == false then
			vlatch = true
		else
			vlatch = false
		end
		vlatch2 = false
		return tcs, vlatch, vlatch2
	elseif flip == true then
		vlatch2 = true
		if vlatch == true then
			return true, vlatch, vlatch2 	--returns true (that toggled bool), then save those two vlatches
		else					-- vlatches stands for variable latches
			return false, vlatch, vlatch2
		end
	end
	return tcs, vlatch, vlatch2
end --because i doubt my future self if i have made this as clear as possible, flip arguement, means that
	--when i have a variable that is set to true, it has to go back to false, before im able to toggle the variable that im trying to toggle
	--or else it wont work as the name 'toggle' implies

function randomTrue(chance)--return true, chance means probability when it'll set true
	--chance, discrete value
	--if chance is given 1, that means 1 to 1 == 1 , 100 percent
	--if chance is given 6, that means 1 to 6 == 6 , means 1 out of 6 percent
	--if chance is given 100, that means 1 to 100 == 100, meants 1 percent chance
	if math.random(1,chance) == chance then
		return true
	end
end

function tHoverUIDraw(button)
	if cursor.x > button.x and cursor.x < button.x + button.w and cursor.y > button.y and cursor.y < button.y + button.h then
		if button.mcb == true and button.runOnce == false and not(love.mouse.isDown(1)) then
			love.graphics.setColor(0,0,100) -- just testing, it shows up for main menu
			love.graphics.draw(button.ib,button.x,button.y,0,button.s,button.s,(button.ib:getWidth()-button.i:getWidth())/2,(button.i:getHeight()-button.ib:getHeight())/2)
			love.graphics.setColor(1,1,1) -- only for this drawing, setting it back

			--this shows you that hovering over the selected area, to be precise, not pressing down on it
			--will draw the image blue, which means this part of the if-statements runs, and that
			--mcb_func_true() does runs.
		else
			love.graphics.draw(button.ib,button.x,button.y,0,button.s,button.s,(button.ib:getWidth()-button.i:getWidth())/2,(button.i:getHeight()-button.ib:getHeight())/2)
		end
	else
		love.graphics.draw(button.i,button.x,button.y,0,button.s)
	end
end

function tHoverUI(button,object,object2)
	object = object or nil --put an object/list here that I want to interact with it on my mcb_func_true()
	if cursor.x > button.x and cursor.x < button.x + button.w and cursor.y > button.y and cursor.y < button.y + button.h then
		if button.mcb == true and button.runOnce == false and not(love.mouse.isDown(1)) then
			button.mcb_func_true(object)
			button.runOnce = true --set true if a function is ran
			button.mcb = false
		else
			if button.mBrushOnce then
				if not(toggleMute) then
					button.mBrush:play()
				end
				button.mBrushOnce = false
			end
			if love.mouse.isDown(1) and not(button.mcb) then
				button.mcb = true
			elseif not(love.mouse.isDown(1)) then
				button.mcb = false
				button.runOnce = false
			end
		end
	else
		button.mBrushOnce = true
		if not(love.mouse.isDown(1)) and button.mcb then
			button.mcb = false
			button.runOnce = false  --set false if a mouse button is released
		end
	end
end 
