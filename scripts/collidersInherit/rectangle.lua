RectangleColliders = Object:extend()

function RectangleColliders:Colliders()
	if #LevelLoader.objects > 0 then
		for i, v in ipairs(LevelLoaders.objects) do
			if v:is(Rectangle) then
				if not(v.group == self.group) then
					self:CollideToRectangle(v)
				end
			end
		end
	end
end

function RectangleColliders:CollideToRectangle(obj)
	--collide left and bottom sides(bottom-left vertex):
	local labs = self.x < obj.x+obj.w and self.y > obj.y+obj.h
	--collide top and right sides(top-right vertex):
	local tars = self.x+self.w > obj.x and self.y+self.h < obj.y
	--collide left and top sides(left-top vertex):
	local lats = self.x < obj.x+obj.w and self.y+self.h < obj.y
	--collide bottom and right sides(bottom-right vertex)
	local bars = self.x+self.w > obj.x and self.y > obj.y+obj.h
	if  labs == true or tars == true or lats == true or bars == true then
		return true
	end
end

--Special Functions:
function RectangleColliders:updateScaling()
end

function RectangleColliders:drawOutlines()
end
