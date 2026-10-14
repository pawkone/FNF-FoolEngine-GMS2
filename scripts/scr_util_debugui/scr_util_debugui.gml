function debugui_checkbox(xx,yy,variable,isGlobal,txt=variable,xscale=1,yscale=1)
{
	if !is_string(variable)
		exit
	if !is_bool(isGlobal)
		exit
	var _old = [draw_get_halign(), draw_get_valign(), draw_get_colour(), draw_get_font(), draw_get_alpha()]
	
	gpu_set_texfilter(false)
	draw_set_alpha(1)
	draw_set_halign(0)
	draw_set_valign(1)
	draw_set_colour(c_black)
	draw_set_font(fnt_score)
	
	draw_sprite_ext(spr_debugui_box, 0, xx, yy, xscale, yscale, 0, c_white, 1)
	if point_in_rectangle(mouse_x, mouse_y, xx-(10*xscale), yy-(10*yscale), xx+(10*xscale), yy+(10*yscale)) && mouse_check_button_pressed(mb_left)
	{
		if isGlobal
			variable_global_set(variable, !variable_global_get(variable))
		else
			variable_instance_set(id,variable,!variable_instance_get(id,variable))
	}
	if isGlobal
	{
		if variable_global_get(variable) == 1
			draw_sprite_ext(spr_debugui_checkmark, 0, xx, yy, xscale, yscale, 0, c_white, 1)
	}
	else
	{
		if variable_instance_get(id,variable) == 1
			draw_sprite_ext(spr_debugui_checkmark, 0, xx, yy, xscale, yscale, 0, c_white, 1)
	}
	draw_text_transformed(xx + (14*xscale), yy, txt, 0.5, 0.5, 0)
	gpu_set_texfilter(true)
	
	draw_set_halign(_old[0]);draw_set_valign(_old[1]);draw_set_colour(_old[2]);draw_set_font(_old[3]);draw_set_alpha(_old[4])
}