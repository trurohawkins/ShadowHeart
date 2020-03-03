function makeChar(image, px, py, oxb, oxe, oyb, oye)
	local char = {}
	char.img = love.graphics.newImage(image)
	char.count = 0
	char.sprite = 0
	for i=oxb,oxe do for k=oyb, oye do
		char[char.count] = makeAnim(char.img, 16, 2, px, py, (oxb + char.count) * (16*2), oye*16)
	char.count = char.count + 1
	function char.animate()
		char[char.sprite].animate()
	end
	function char.draw()
		char[char.sprite].draw()
	end
	function char.move(mx, my)
		for i=0,char.count-1 do
			char[i].move(mx, my)--.x = char[i].x + mx
			char[i].move(mx, my)-- = char[i].y + my
		end
	end
	end end
	return char
end

function makeAnim(img, size, frames, x, y, ox, oy)
	local anim = {}
	anim.x = x
	anim.y = y
	anim.speed = 5
	anim.st = 0
	anim.frame = 0
	anim.frames = frames
	anim.size = size
	anim.sx = 1
	anim.ox = 0
	for i=0, frames-1 do
		anim[i] = love.graphics.newQuad(ox + size * i, oy, 8, 8, img:getDimensions())
	end
	function anim.animate()
		anim.st = anim.st + 1
		if anim.st % anim.speed == 0 then
			anim.frame = (anim.frame + 1) % anim.frames
		end
	end
	function anim.draw()
		love.graphics.draw(img, anim[anim.frame], anim.x, anim.y, 0, 10, 10, 0, 0, 0 ,0)
	end
	function anim.draw(x, y)
		if x < anim.x then 
			anim.sx = 1 
			anim.ox = 8	
		elseif x > anim.x then 
			anim.sx = -1 
			anim.ox = 0
		end
		anim.place(x, y)
		love.graphics.draw(img, anim[anim.frame], x, y, 0, anim.sx, 1, anim.ox, 0)
	end
	function anim.move(mx, my)
		anim.x = anim.x + mx
		anim.y = anim.y + my
	end
	function anim.place(mx, my)
		anim.x = mx
		anim.y = my
	end
	return anim

end


