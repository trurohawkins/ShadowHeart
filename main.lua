require("input")
require("obj")
require("map")
require("anim")

function love.load()
	--love.graphics.setBackgroundColor(.1, .05, .2)	
	love.graphics.setBackgroundColor(0, 0, 0, 0)	
	worldX = 20
	worldY = 20
	gridSize = 16
	map = makeMap("light")
	p = makeMob(map, worldX/2, worldY/2)
	spriSheet = love.graphics.newImage("unknown.png")
	p.anim = makeAnim(spriSheet, 16, 2, p.x, p.y, 0, 0)
	fillMap(map)
	sMap = makeMap("dark")
	sP = makeMob(sMap, worldX/2, worldY/2)
	sP.anim = makeAnim(spriSheet, 16, 2, p.x, p.y, 32, 0)
	fillMap(sMap)
	shadow = 0
end

function love.update()
		input(p, map)
		input(sP, sMap)
end

function love.draw()
	drawMap()	
	--p.anim.draw()
	--wholeMap()
end
