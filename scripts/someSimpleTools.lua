--works by having some single bool to toggle on/off like a button(flip switch) doesn't have to be just keyboard
-- when trying to use this, you need a table ready with a 1.bool var(that's flip switch) and 2.two latches, and 3.set all those to false first
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
