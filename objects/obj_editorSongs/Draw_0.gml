draw_set_alpha(1)
draw_set_colour(c_white)
draw_set_font(fnt_debug)
draw_set_halign(2)
draw_set_valign(1)
var _timebpm = time_bpm_to_seconds(global.mGP_bpm)


gpu_set_texfilter(false)
draw_sprite_ext(spr_editorSongs_gridnote, 0, 128, -((_current_time/1000 / _timebpm)*(128*mult)), 2, 5000, 0, c_white, 0.5)
gpu_set_texfilter(true)


var _beat_length = _timebpm * 1000
var _scroll_offset = (_current_time / _beat_length) * (128 * mult)
var visible_lines = ceil(global.gameSizeH / (128 * mult)) + 2;
var base_index = floor(_scroll_offset / (128 * mult));
for (var i = base_index; i <= base_index + visible_lines; i++)
{
    var y_pos = (i * (128 * mult)) - _scroll_offset - ((mult-1)*128);
	var _colour = ((i - 1) mod 4 == 0) ? c_blue : c_white;
	draw_rectangle_colour(
	    128, y_pos - 1,
	    256 + 128, y_pos + 1,
	    _colour, _colour, _colour, _colour, false
	);
	if ((i - 1) mod 4 == 0)
	{
	    repeat 6
			draw_text_transformed(90, y_pos, floor(i / 4), 0.5, 0.5, 0);
	    draw_arrow(96, y_pos, 118, y_pos, 32);
	}
}


draw_set_colour(c_red)
for (var i = 0; i < array_length(notes); i++)
{
	var _note = notes[i]
	var _y = ((_note[0]/1000 - _current_time/1000) / _timebpm)*(128*mult)+128
	if _note[0] == selected_note[0] && _note[1] == selected_note[1]
	{
		draw_set_colour(c_fuchsia)
		if keyboard_check_pressed(ord("E"))
			_note[2] += (_note[2] == 0 ? (35*6) : (35*3))/mult
		else if keyboard_check_pressed(ord("Q"))
			_note[2] -= (_note[2] <= (((35*6)+5)/mult) ? 100000 : (35*3))/mult
		if _note[2] < 0
			_note[2] = 0
	}
	if _current_time >= _note[0] && oldcurrentime < _note[0] && !audio_is_paused(inst)
		audio_play_sound(global.sfx_hitsound, 1, false)
	if mouse_check_button(mb_right) && point_in_rectangle(mouse_x, mouse_y, 128+(_note[1]*32),_y,128+(_note[1]*32)+32,_y+32)
		array_delete(notes, i, 1)
	
	draw_rectangle(128+(_note[1]*32),_y,128+(_note[1]*32)+32,_y+32,false)
	draw_set_colour(c_white)
	if _note[2] > 0
		draw_rectangle(128+(_note[1]*32)+12,_y+16,128+(_note[1]*32)+20,_y+((_note[2]*0.3)*mult),false)
	draw_set_colour(c_red)
}


draw_set_colour(c_white)
draw_rectangle_colour(128, 0, 129, global.gameSizeH, c_blue, c_blue, c_blue, c_blue, false)
draw_rectangle_colour(256, 0, 257, global.gameSizeH, c_blue, c_blue, c_blue, c_blue, false)
draw_rectangle_colour(256+128, 0, 257+128, global.gameSizeH, c_blue, c_blue, c_blue, c_blue, false)
draw_rectangle_colour(128, 126, 256+128, 130, c_red, c_red, c_red, c_red, false)


if mouse_check_button_pressed(mb_left)
{
	var lane = floor(mouse_x / 32) - 4
	if lane >= 0 && lane <= 7
	{
		var y_offset = mouse_y - 128
		var time_offset_sec = (y_offset / (128 * mult)) * _timebpm
		var raw_time_ms = ((_current_time/1000) + time_offset_sec) * 1000
		var subdivision = 4*mult
		var grid_unit = (_timebpm * 1000) / subdivision
		var snapped_time_ms = floor(raw_time_ms / grid_unit) * grid_unit
		for (var i = 0; i < array_length(notes); i++)
		{
			var _note = notes[i]
			if round(_note[0]/10) == round(snapped_time_ms/10) && _note[1] == lane
				array_delete(notes, i, 1)
		}
		var note = [snapped_time_ms, lane, 0]
		array_push(notes, note)
		selected_note = [note[0], note[1]]
	}
}

oldcurrentime = _current_time