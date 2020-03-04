require("input")
require("obj")
require("map")
require("anim")

function love.load()
	--love.graphics.setBackgroundColor(.1, .05, .2)
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setBackgroundColor(0, 0, 0, 0)	
	scrWid = 30
	scrHei = 30
	worldX = 50
	worldY = 50
	gridSize = 16
	map = makeMap("light")
	p = makeMob(map, worldX/2, worldY/2)
	spriSheet = love.graphics.newImage("sprites/player.png")
	p.anim = makeAnim(spriSheet, 8, 1, p.x, p.y, 0, 0)
  fillMap(map)
	sMap = makeMap("dark")
	sP = makeMob(sMap, worldX/2, worldY/2)
	sP.anim = makeAnim(spriSheet, 8, 1, p.x, p.y, 0, 0)
	fillMap(sMap)
	makeFloor()
	shadow = 0
end

function love.update()
		input(p, map)
		input(sP, sMap)
end

function love.draw()
	--love.graphics.scale(2,2)
	drawMap()	
	--p.anim.draw()
	--wholeMap()
end
