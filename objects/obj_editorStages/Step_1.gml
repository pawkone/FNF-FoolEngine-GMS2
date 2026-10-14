if mouse_check_button_pressed(mb_left)
{
	camoffset = [
		global.mGP_gameX - -device_mouse_x_to_gui(0),
		global.mGP_gameY - -device_mouse_y_to_gui(0)
	]
}
if mouse_check_button(mb_left)
{	
	global.mGP_gameX = camoffset[0] + -device_mouse_x_to_gui(0)
	global.mGP_gameY = camoffset[1] + -device_mouse_y_to_gui(0)
}