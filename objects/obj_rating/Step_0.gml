y += vsp * global.fpsMult
x += hsp * global.fpsMult
vsp += 0.2 * global.fpsMult
timer -= delta_time/1000000
if timer < 0
	image_alpha -= (1/45) * global.fpsMult
if image_alpha <= 0
	instance_destroy()