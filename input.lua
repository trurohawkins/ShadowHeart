
function input(player, curMap)
	if love.keyboard.isDown("w") then
		move(player, curMap, 0, -1)
	end
	if love.keyboard.isDown("s") then
		move(player, curMap, 0, 1)
	end
	if love.keyboard.isDown("a") then
		move(player, curMap, -1, 0)
	end
	if love.keyboard.isDown("d") then
		move(player, curMap, 1, 0)
	end

end

function love.keypressed(key)
	if key == "space" then
		if shadow == 0 then
			shadow = 1
		else
			shadow = 0
		end
	elseif key == "return" then
		print(p.x)
		print(p.y)
		print(sP.x)
		print(sP.y)
	end
end


