
function makeMob(curMap, x, y)
	if curMap[x][y] == nil then
		local obj = makeObj(curMap, x, y, 1, 1, 1)
		obj.inertiaTimer = 0
		obj.inertia = 10
		obj.acceleration = 1
		return obj
	else
		return nil
	end
end

function makeObj(curMap, x, y, r, g, b)
	if curMap[x][y] == nil then
		local obj = {}
		obj.x = x
		obj.y = y
		curMap[obj.x][obj.y] = obj
		obj.r = r
		obj.g = g
		obj.b = b
		return obj
	else
		return nil
	end
end

function move(obj, curMap,  x, y)
	for i=0,obj.acceleration do
		if obj.inertia == obj.inertiaTimer then
			newX = obj.x + x
			newY = obj.y + y
			if newY >= 0 and newY <= worldY then
				if newX >= 0 and newX <= worldX then
						if obj.anim ~= nil then
							obj.anim.animate()
						end
					if curMap[newX][newY] == nil then
						curMap[obj.x][obj.y] = nil
						obj.x = newX
						obj.y = newY
						curMap[obj.x][obj.y] = obj
					end
				end
			end
			obj.inertiaTimer = 0
		else 
			obj.inertiaTimer = obj.inertiaTimer + 1
		end
	end

end


