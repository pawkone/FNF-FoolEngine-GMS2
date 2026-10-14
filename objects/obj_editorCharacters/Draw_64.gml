if instance_exists(obj_editorCharacters_delete)
	exit

draw_set_alpha(0.5)
draw_set_colour(c_black)
draw_rectangle(900,0,1280,720,false)
draw_set_alpha(1)
draw_set_colour(c_white)

var _old = editorchar_playableCharacter
debugui_checkbox(50, 200, "editorchar_playableCharacter", false, "Playable Character (test)")
if _old != editorchar_playableCharacter
	event_user(1)
draw_set_font(fnt_score)
if buttonslimit < array_length(things)
{
	var f = sprw_frames[ds_list_find_value(sprw_cur_anim_frames, sprw_frame_index)]
	var offsets = ["?","?"]
	for (var i = 0; i < ds_list_size(sprw_offset_keys); i++)
	{
		var key = sprw_offset_keys[| i]
		if string_starts_with(f[0], key)
		{
			offsets = sprw_offsets[? key]
			break
		}
	}
	draw_text_transformed(35, 35, string_concat(things[selected], "\n(", sprw_cur_anim, ")\n\n", offsets), 1.4, 1.4, 0)
}
var _hover = -4
var _xx = 1280-310
var _yy = 50
for (var i = 0; i < array_length(things); i++)
{
    var item_x1 = _xx + 4
    var item_y1 = _yy + 4
    var item_x2 = _xx + (i <= (buttonslimit-1) ? 120 : 250)
    var item_y2 = _yy + 37
    if point_in_rectangle(mouse_x, mouse_y, item_x1, item_y1, item_x2, item_y2)
	{
		_hover = i
        if mouse_check_button_pressed(mb_left)
		{
			if i == 0
			{
				var _png = get_open_filename("PNG File|*.png", "")
				if _png == ""
					exit
				var _xml = get_open_filename("XML File|*.xml", "")
				if _xml == ""
					exit
				var _fps = get_string("Character's FPS", "24")
				if string_letters(_fps) != "" || string_digits(_fps) == ""
				{
					show_message("New Char: 'FPS' value empty")
					exit
				}
				if real(_fps) <= -1
				{
					show_message("New Char: 'FPS' value can't be less than or equal -1")
					exit
				}
				var _spr = filename_name(_xml)
				_spr = string_delete(_spr, -4, 4)
				var _spr2 = string(assetsfolder + "images/characters/" + _spr)
				var buf_png = buffer_load(_png)
				buffer_save(buf_png, _spr2 + ".png")
				buffer_delete(buf_png)
				var buf_xml = buffer_load(_xml)
				buffer_save(buf_xml, _spr2 + ".xml")
				buffer_delete(buf_xml)
				jsonData_character_editor_empty(assetsfolder + "images/characters/" + _spr, real(_fps))
				event_user(2)
			}
			else if i == 1
				event_user(0)
			else if i == 2
			{
				var filename = get_open_filename("JSON|*.json", character + ".json")
				if filename != ""
				{
					character = filename
					event_user(1)
				}
			}
			else if i == 3
			{
				var _name = get_string("Enter anim name:", "idle")
				if _name == ""
				{
					show_message("New Anim: 'Name' value empty")
					exit
				}
				var _recommend = _name
				if _name == "singLEFT"
					_recommend = "left"
				if _name == "singDOWN"
					_recommend = "down"
				if _name == "singUP"
					_recommend = "up"
				if _name == "singRIGHT"
					_recommend = "right"
				var _xmlPrefix = get_string("Enter anim xml prefix:", _recommend)
				if _xmlPrefix == ""
				{
					show_message("New Anim: 'Xml Prefix' value empty")
					exit
				}
				var _loop = get_string("Does anim loop? (0 or 1)", "0")
				if _loop != "0" && _loop != "1"
				{
					show_message("New Anim: 'Loop' value malformed or empty")
					exit
				}
				sprw_add(_xmlPrefix, [0,0], _name, bool(_loop))
				array_push(things, _name)
				selected = array_length(things)-1
				sprw_play(things[selected], true)
			}
			else if i == 4
			{
				if 8 < array_length(things)
					instance_create_depth(0,0,0,obj_editorCharacters_delete)
			}
			else if i == 6
			{
				if array_length(things) > buttonslimit
				{
					instance_destroy(obj_editorCharacters_ghost)
					instance_create_depth(x,y,depth+1,obj_editorCharacters_ghost)
				}
			}
			else if i == 7
				instance_destroy(obj_editorCharacters_ghost)
			else
			{
				selected = i
				sprw_play(things[i], true)
			}
		}
    }
	draw_set_colour(c_black)
    draw_rectangle(item_x1, item_y1, item_x2, item_y2, false)
	draw_set_colour(c_white)
	draw_set_halign(1)
	draw_set_valign(1)
	draw_text_transformed((item_x1+item_x2)/2, ((item_y1+item_y2)/2), things[i], (i <= (buttonslimit-1) ? 0.5 : 1.2), (i <= (buttonslimit-1) ? 0.5 : 1.2), 0)
	draw_set_halign(0)
	draw_set_valign(0)
    if _hover == i
	{
        draw_set_alpha(0.15)
        draw_set_colour(c_aqua)
        draw_rectangle(item_x1, item_y1, item_x2, item_y2, false)
        draw_set_alpha(1)
    }
    draw_set_colour(c_black)
	draw_set_colour(c_white)

	if i < buttonslimit
	{
		if i mod 2 == 0
			_xx += 130
		else if i mod 2 == 1
		{
			_xx += -130
			_yy += 42
		}
	}
	else
		_yy += 42
}