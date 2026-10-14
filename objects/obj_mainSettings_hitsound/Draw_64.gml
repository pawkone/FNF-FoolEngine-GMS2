draw_set_alpha(0.8)
draw_set_color(c_black)
draw_rectangle(0,0,global.gameSizeW,global.gameSizeH,false)
draw_set_alpha(1)
draw_set_color(c_white)
gpu_set_texfilter(0)
draw_set_alpha(1)
draw_set_halign(0)
draw_set_valign(1)
draw_set_font(fnt_score)
if !toggle
{
	draw_text(160 + ((current_time mod 1000) < 500) * -8, 200, "<")
	draw_text(220 + string_width(name) + ((current_time mod 1000) < 500) * 8, 200, ">")
}
draw_text(200, 200, name)
draw_text(200, 300, desc)
draw_text(200, 350, cred)
if toggle
{
	for (var i = 0; i <= 3; i++)
	{
		var _hit = keyboard_check(global.mGP_keys[i])
		if keyboard_check_pressed(global.mGP_keys[i])
		{
			hitsoundDir = i+4
			gmlvm_vm(global.mS_hitsoundScript)
			hitsoundDir = -4
		}
		draw_set_colour(_hit ? [c_fuchsia, c_aqua, c_lime, c_red][i] : c_white)
		draw_text(200+i*48 + (_hit ? [-8, 0, 0, 8][i] : 0), 500 + (_hit ? [0, 8, -8, 0][i] : 0), ["<", "v", "^", ">"][i])
	}
}
else
	draw_text(200, 500, "(Use shift to toggle the 'hitsound test mode' that you can\ncheck out with your keybinds!)")
draw_set_valign(0)
gpu_set_texfilter(1)