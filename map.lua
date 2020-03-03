function makeMap(name)
	local m = {}
	m.floor = {}
	m.name = name
	for i=0,worldX do
		m[i] = {}
		m.floor[i] = {}
		for j=0,worldY do
			m[i][j] = nil
			m.floor[i][j] = nil
		end
	end
	if name == "light" then
		m.bg = 1
	elseif name == "dark" then
		m.bg = 1
	end
	return m
end


function ray(curMap, player, dirX, dirY, dist)
	for i=0,dist do
		local x = math.floor(player.x + (dirX * i))
		local y = math.floor(player.y + (dirY * i))
		
		if x >= 0 and x <= worldX and y >= 0 and y <= worldY then
			obj = curMap[x][y]
			fObj = curMap.floor[x][y]
			local info = {}
			local flInfo = {}
			if mainScr[x][y] ~= nil then info = mainScr[x][y] else mainScr[x][y] = info end
			if floorScr[x][y] ~= nil then flInfo = floorScr[x][y] else floorScr[x][y] = flInfo end
			--if info.r ~= nil and info.b ~= nil then green = 1 else green = 0 end
			al = ((dist*.5) / (i + 1)) / dist
			
			if curMap == map then 	
				mInfo(flInfo, fObj, al, 1)
				mInfo(info, obj, al, 1)
			elseif curMap == sMap then
				mInfo(flInfo, fObj, al, 0)
				mInfo(info, obj, al, 0)
			end

			if obj ~= nil and obj ~= player then break end
		end
	end
end

function mInfo(info, obj, al, r)
	if obj ~= nil then
		if r == 1 then
			if info.r == nil then
				info.r = obj.r
				if info.b ~= nil then info.g = obj.g end
			end
		else
			if info.b == nil then
				info.b = obj.b
				if info.r ~= nil then info.g = obj.g end
			end
		end
		if obj.anim ~= nil then info.an = obj.anim end
	end
	-- maybe needs to be in above if
	if info.a ~= nil then
		info.a = info.a + al 
	else
		info.a = al
	end
end

function drawSprite(an, x, y, r, g, b, alpha)
		love.graphics.setColor(r, g, b, alpha)
		x = ((love.graphics.getWidth() / 2) - ((worldX/2) * gridSize)) + (x * gridSize)
		y = ((love.graphics.getHeight() / 2) - ((worldY/2) * gridSize)) + (y * gridSize)
		an.draw(x, y)
end

function drawSquare(x, y, r, g, b, alpha)
		love.graphics.setColor(r, g, b, alpha)
		x = ((love.graphics.getWidth() / 2) - ((worldX/2) * gridSize)) + (x * gridSize)
		y = ((love.graphics.getHeight() / 2) - ((worldY/2) * gridSize)) + (y * gridSize)
		love.graphics.rectangle("fill", x, y, gridSize, gridSize)

end

function drawScreen(curScr)
	for i=0,worldX do
		for j=0,worldY do
			local pix = curScr[i][j]
			if pix ~= nil then
				if pix.r ~= nil then r = pix.r else r = 0 end
				if pix.g ~= nil then g = pix.g else g = 0 end
				if pix.b ~= nil then b = pix.b else b = 0 end
				if pix.a ~= nil then a = pix.a else a = 0 end
--				love.graphics.setColor(r, g, b, a)
				local x = ((love.graphics.getWidth() / 2) - ((worldX/2) * gridSize)) + (i * gridSize)
				local y = ((love.graphics.getHeight() / 2) - ((worldY/2) * gridSize)) + (j * gridSize)
					love.graphics.setColor(r, g, b, a)
				--love.graphics.rectangle("fill", x, y, gridSize, gridSize)
				if pix.an ~= nil then
					pix.an.draw(x, y)
				end
			end
		end
	end
end

function drawMap()
	mainScr = makeMap( )
	floorScr = makeMap ( )

	for i=0,6.2,.1 do
		x = (math.cos(i))
		y = (math.sin(i))
			if sMap ~= nil and sP ~= nil then
				ray(sMap, sP, x, y, 10)
				--ray(sMap.floor, floorScr, sP, x, y, 100)
			end
			if map ~= nil and p ~= nil then
				ray(map, p, x, y, 10)
--				ray(map.floor, floorScr, p, x, y, 100)
			end
	end
	drawScreen(floorScr)
	drawScreen(mainScr)
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
	bushImg = love.graphics.newImage("sprites/bush.png")
	for i=0,worldX do
		for j=0,worldY do
			if love.math.random() > 0.9 then
			--makeObj(curMap, i, j, .45, .45, .45)
				local o = makeObj(curMap, i, j, .1, .5, .3)
				if o ~= nil then o.anim = makeAnim(bushImg, 8, 1, i, j, 0, 0) end
				--sMap[i][j] = o
			end
		end
	end
end

function makeFloor()
	grassImg = love.graphics.newImage("sprites/grass.png")
	for i=0,worldX do
		for j=0,worldY do
			local o = makeObj(map.floor, i, j, .3, .9, .2)	
			if o ~= nil then o.anim = makeAnim(grassImg, 8, 1, i, j, 0, 0) end
			sMap.floor[i][j] = o
		end
	end
end
