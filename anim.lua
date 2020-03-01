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
			char[i].x = char[i].x + mx
			char[i].y = char[i].y + my
		end
	end
	end end
	return char
end

function makeAnim(img, size, frames, x, y, ox, oy)
	local anim = {}
	anim.x = x
	anim.y = y
	anim.speed = 20
	anim.frame = 0
	anim.size = size
	for i=0, frames-1 do
		anim[i] = love.graphics.newQuad(ox + size * i, oy, 16, 16, img:getDimensions())
	end
	function anim.animate()
		if time % anim.speed == 0 then
			anim.frame = (anim.frame + 1) % 2
		end
	end
	function anim.draw()
		love.graphics.draw(img, anim[anim.frame], anim.x, anim.y)
	end
	return anim

end


