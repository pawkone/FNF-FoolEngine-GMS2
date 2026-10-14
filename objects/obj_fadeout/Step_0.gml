var _oldy = y

image_xscale = global.gameSizeW
image_yscale = (global.gameSizeH/155)
x = 0
y += (1280 / (60/global.fpsMult)) * (global.gameSizeH/720)

if _oldy <= global.gameSizeH/2 && y > global.gameSizeH/2
{
	if room == roomTarget
		room_restart()
	else
		room_goto(roomTarget)
}
if y > global.gameSizeH + sprite_height/2
	instance_destroy()