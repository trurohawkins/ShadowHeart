require("input")
require("obj")
require("map")

function love.load()
	love.graphics.setBackgroundColor(.1, .05, .2)	
	worldX = 20
	worldY = 20
	gridSize = 16
	map = makeMap("light")
	p = makeMob(map, worldX/2, worldY/2)
	fillMap(map)
	sMap = makeMap("dark")
	sP = makeMob(sMap, worldX/2, worldY/2)
	fillMap(sMap)
	shadow = 0
end

function love.update()
		input(p, map)
		input(sP, sMap)
end

function love.draw()
	drawMap()	
end
