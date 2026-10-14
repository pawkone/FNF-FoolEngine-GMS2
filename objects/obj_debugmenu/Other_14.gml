if !surface_exists(sur)
	sur = surface_create(global.gameSizeW,global.gameSizeH)
surface_set_target(sur)
draw_clear(c_black)
draw_set_font(fnt_debug)
draw_set_halign(0)
draw_set_valign(1)
var yy = (global.savedebugmenu_selected * -35) + global.gameSizeH/2
for (var i = 0; i < array_length(global.savedebugmenu_items);i++)
{
	draw_set_colour(i == global.savedebugmenu_selected ? c_white : c_grey)
	var txt = global.savedebugmenu_items[i]
	var pos = 35
	if global.savedebugmenu_menu == debugmenu_scrtype.selectsong
	{
		if i == global.savedebugmenu_selected && audio_is_playing(inst)
			draw_set_colour(c_aqua)
		if i != 0
		{
			var num = i-1
			var str = string(num)
			while (string_length(str) < 3)
			    str = "0"+str
			txt = str+" : '"+txt+"'"
		}
	}
	draw_text_transformed(floor(pos), floor(yy + i*35), txt, 1.3, 1.3, 0)
}
draw_set_colour(c_dkgrey)
draw_rectangle(0,global.gameSizeH-100,global.gameSizeW,global.gameSizeH,false)
draw_set_valign(0)
draw_set_colour(c_white)
draw_text_ext_transformed(20, global.gameSizeH-85, global.savedebugmenu_distxt, 45, (global.gameSizeW/2)-50, 2, 2, 0)
surface_reset_target()