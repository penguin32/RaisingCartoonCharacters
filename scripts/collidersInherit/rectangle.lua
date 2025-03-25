RectangleColliders = Object:extend()

function RectangleColliders:Colliders()
	if #LevelLoader.objects > 0 then
		for i, v in ipairs(LevelLoaders.objects) do
			if v:is(Rectangle) then
				--self:CollideToRectangle(v)
			end
		end
	end
end

function RectangleColliders:CollideToRectangle(obj)
end

--Special Functions:
function RectangleColliders:updateScaling()
end

function RectangleColliders:drawOutlines()
end
