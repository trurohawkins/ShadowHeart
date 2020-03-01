function makeMap(name)
	local m = {}
	m.name = name
	for i=0,worldX do
		m[i] = {}
		for j=0,worldY do
			m[i][j] = nil
		end
	end
	if name == "light" then
		m.bg = 0
		m.col = 1
	else
		m.bg = 1
		m.col = 0
	end
	return m
end

function ray(curMap, player, dirX, dirY, dist)
	for i=0,dist do
		local x = math.floor(player.x + (dirX * i))
		local y = math.floor(player.y + (dirY * i))
		
		if x >= 0 and x <= worldX and y >= 0 and y <= worldY then
			alpha = ((dist*1.5) / (i + 1)) / dist
			obj = curMap[x][y]
			
			--if obj == player then print(player.r) end
--			if obj == nil then 
--				love.graphics.setColor(curMap.bg, curMap.bg, curMap.bg, alpha)
--			else
--				love.graphics.setColor(obj.r, obj.g, obj.b, alpha)
--				--love.graphics.setColor(curMap.col, curMap.col, curMap.col, alpha)
--			end
--			x = ((love.graphics.getWidth() / 2) - ((worldX/2) * gridSize)) + (x * gridSize)
--			y = ((love.graphics.getHeight() / 2) - ((worldY/2) * gridSize)) + (y * gridSize)
--			love.graphics.rectangle("fill", x, y, gridSize, gridSize)
			if obj == nil then 
				drawSquare(x, y, curMap.bg, curMap.bg, curMap.bg, alpha)
			elseif obj.anim ~= nil then
				drawSquare(x, y, curMap.bg, curMap.bg, curMap.bg, alpha)
				drawSprite(obj.anim, x, y, obj.r, obj.g, obj.b, alpha)
			else
				drawSquare(x, y, obj.r, obj.g, obj.b, alpha)
			end
				
			if obj ~= nil and obj ~= player then break end
		end
	end
end
function drawSprite(an, x, y, r, g, b, alpha)
		love.graphics.setColor(r, g, b, alpha)
		x = ((love.graphics.getWidth() / 2) - ((worldX/2) * gridSize)) + (x * gridSize)
		y = ((love.graphics.getHeight() / 2) - ((worldY/2) * gridSize)) + (y * gridSize)
		an.draw(x, y)
		
		--love.graphics.rectangle("fill", x, y, gridSize, gridSize)

end

function drawSquare(x, y, r, g, b, alpha)
			love.graphics.setColor(r, g, b, alpha)
		x = ((love.graphics.getWidth() / 2) - ((worldX/2) * gridSize)) + (x * gridSize)
		y = ((love.graphics.getHeight() / 2) - ((worldY/2) * gridSize)) + (y * gridSize)
		love.graphics.rectangle("fill", x, y, gridSize, gridSize)

end

function drawMap()
	for i=0,6.2,.1 do
		x = (math.cos(i))
		y = (math.sin(i))
		--if shadow == 0 then
		--	drawSquare(sP.x, sP.y, sP.r, sP.g, sP.b, 1)
		--else
			if sMap ~= nil and sP ~= nil then
				ray(sMap, sP, x, y, 100)
			end
			if map ~= nil and p ~= nil then
				ray(map, p, x, y, 100)
			end
		--	drawSquare(p.x, p.y, p.r, p.g, p.b, 1)
		--end
	end
end

function wholeMap()
	for i=0,worldX do
		for j=0,worldY do
			local alpha = 1
			local obj = map[i][j]
			if obj == nil then 
				--love.graphics.setColor(0.5, 0, 0.5, alpha)
				drawSquare(i, j, map.bg, map.bg, map.bg,alpha)
			elseif obj.anim == nil then
				--love.graphics.setColor(obj.r, obj.g, obj.b, alpha)
				drawSquare(i, j, obj.r, obj.g, obj.b,alpha)
			else
				drawSquare(i, j, map.bg, map.bg, map.bg,alpha)
				drawSprite(obj.anim, i, j, 1, 1, 1, 1)
			end
			--[[local x = ((love.graphics.getWidth() / 2) - ((worldX/2) * gridSize)) + (i * gridSize)
			local y = ((love.graphics.getHeight() / 2) - ((worldY/2) * gridSize)) + (j * gridSize)
			
			love.graphics.rectangle("fill", x - gridSize, y - gridSize, gridSize, gridSize)
			end
		]]--
		end
	end
end

function fillMap(curMap)
	for i=0,worldX do
		for j=0,worldY do
			if love.math.random() > 0.9 then
				makeObj(curMap, i, j, 1, 0, 0)
			end
		end
	end
end
