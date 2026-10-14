function sprw_exists(objid)
{
	var _count = 0
	if variable_instance_exists(objid, "sprw_animnames") _count++
	if variable_instance_exists(objid, "sprw_offsets") _count++
	if variable_instance_exists(objid, "sprw_offset_keys") _count++
	if variable_instance_exists(objid, "sprw_anims") _count++
	if variable_instance_exists(objid, "sprw_animnames") _count++
	if variable_instance_exists(objid, "sprw_anim_keys") _count++
	if variable_instance_exists(objid, "sprw_frames") _count++
	if variable_instance_exists(objid, "sprw_frame_rate") _count++
	if variable_instance_exists(objid, "sprw_frame_index") _count++
	if variable_instance_exists(objid, "sprw_frame_timer") _count++
	if variable_instance_exists(objid, "sprw_cur_anim") _count++
	if variable_instance_exists(objid, "sprw_cur_anim_frames") _count++
	if variable_instance_exists(objid, "sprw_sprite") _count++
	if variable_instance_exists(objid, "sprw_loop") _count++
	return _count == 14
}
function sprw_load(path, fpps)
{
	sprw_animnames = []
    sprw_offsets = ds_map_create()
    sprw_offset_keys = ds_list_create()
    sprw_anims = ds_map_create()
    sprw_anim_keys = ds_list_create()
    sprw_frames = []
    sprw_frame_rate = fpps
    sprw_frame_index = 0
    sprw_frame_timer = 0
	sprw_loop = false
    sprw_cur_anim = ""
    sprw_cur_anim_frames = ds_list_create()
	if !file_exists(path + ".png")
	{
		show_debug_message(object_get_name(object_index) + " : No " + path + ".png found.")
		exit
	}
	if !file_exists(path + ".xml")
	{
		show_debug_message(object_get_name(object_index) + " : No " + path + ".xml found.")
		exit
	}
	sprw_sprite = spritepool_load(path + ".png")
	sprite_index = sprw_sprite
    var file = file_text_open_read(path + ".xml")
    while !file_text_eof(file)
	{
        var line = string_trim(file_text_readln(file))
        if line == "" || string_starts_with(line, "<!--")
			continue
        if string_starts_with(line, "<SubTexture")
		{
            var attr = "name"
            var pattern = attr + "=\""
            var start = string_pos(pattern, line)
            var name = ""
            if start > 0
			{
                var val_start = start + string_length(pattern)
                var substr = "\""
                var len = string_length(line)
                var val_end = 0
                for (var i = val_start; i <= len; i++)
				{
                    if string_copy(line, i, 1) == substr
					{
                        val_end = i
                        break
                    }
                }
                name = string_copy(line, val_start, val_end - val_start)
				var _eac = function(line, len, attr_name)
				{
	                var pat = attr_name + "=\""
	                var st = string_pos(pat, line)
	                var str_val = ""
	                if st > 0
					{
	                    var val_st = st + string_length(pat)
	                    var val_en = 0
	                    for (var j = val_st; j <= len; j++)
						{
	                        if string_copy(line, j, 1) == "\""
							{
	                            val_en = j
	                            break
	                        }
	                    }
	                    str_val = string_copy(line, val_st, val_en - val_st)
	                }
	                if string_length(str_val) == 0
						return 0
					try{return real(str_val)}
					catch(e){return str_val}
	            }
	            var xx = _eac(line, len, "x")
	            var yy = _eac(line, len, "y")
	            var w = _eac(line, len, "width")
	            var h = _eac(line, len, "height")
	            var fx = _eac(line, len, "frameX")
	            var fy = _eac(line, len, "frameY")
	            var fw = _eac(line, len, "frameWidth")
				if fw == 0
					fw = w
	            var fh = _eac(line, len, "frameHeight")
				if fh == 0
					fh = h
				var rotated = _eac(line, len, "rotated")
	            if fw == 0
					fw = w
	            if fh == 0
					fh = h
	            var frame_index = array_length(sprw_frames)
	            array_push(sprw_frames, [name, xx, yy, w, h, fx, fy, fw, fh, rotated == "true" || rotated == 1])
	            var prefix = ""
	            for (var i = 1; i <= string_length(name) - 4; i++)
				{
	                var ch = string_char_at(name, i)
	                prefix += ch
	            }
	            if !ds_map_exists(sprw_anims, prefix)
				{
	                var newlist = ds_list_create()
	                ds_map_add(sprw_anims, prefix, newlist)
	                ds_list_add(sprw_anim_keys, prefix)
	            }
	            var anim_list = ds_map_find_value(sprw_anims, prefix)
	            ds_list_add(anim_list, frame_index)
			}
        }
    }
    file_text_close(file)
    if ds_list_size(sprw_anim_keys) > 0
	{
        var first_anim = sprw_anim_keys[| 0]
        sprw_play(first_anim, true)
    }
}
function sprw_add(xmlname, arr, animname = "", loop = false)
{
	if !sprw_exists(id)
		exit
	if animname != ""
		array_push(sprw_animnames, [animname, xmlname, loop])
	ds_map_add(sprw_offsets, xmlname + "0", arr)
	ds_list_add(sprw_offset_keys, xmlname + "0")
}
function sprw_is_anim_playing(name)
{
	if !sprw_exists(id)
		exit
	if sprw_cur_anim == sprw_get_anim_name(name)
		return true
	return false
}
function sprw_get_anim_name(name)
{
	if !sprw_exists(id)
		exit
	for (var i = 0; i < array_length(sprw_animnames); i++)
	{
		if name == sprw_animnames[i][0]
			return sprw_animnames[i][1]
	}
	return name
}
function sprw_play(anim_name, force = false)
{
	if !sprw_exists(id)
		exit
	if !force && sprw_cur_anim == anim_name && !(sprw_frame_index < ds_list_size(sprw_cur_anim_frames) - 1)
		exit
	sprw_loop = false
	var chosen_name = ""
	for (var i = 0; i < array_length(sprw_animnames); i++)
	{
		if anim_name == sprw_animnames[i][0]
		{
			sprw_loop = sprw_animnames[i][2]
			anim_name = sprw_animnames[i][1]
			break
		}
	}
	if ds_map_exists(sprw_anims, anim_name)
		chosen_name = anim_name
	else
	{
		var best_score = -1
		var best_match = ""
		for (var i = 0; i < ds_list_size(sprw_anim_keys); i++)
		{
			var key = sprw_anim_keys[| i]
			var sscore = 0
			if string_starts_with(key, anim_name)
				sscore += 10
			sscore -= abs(string_length(key) - string_length(anim_name))
			if sscore > best_score
			{
				best_score = sscore
				best_match = key
			}
		}
		if best_match == ""
			exit
		chosen_name = best_match
	}
	sprw_cur_anim = chosen_name
	sprw_cur_anim_frames = ds_map_find_value(sprw_anims, chosen_name)
	sprw_frame_index = 0
	sprw_frame_timer = 0
}
function sprw_draw(xx, yy, xscale = 1, yscale = 1, angle = 0, colour = c_white, alpha = 1)
{
    if !sprw_exists(id)
    {
        draw_sprite(spr_error, 0, xx, yy)
        exit
    }
    if sprw_frame_index < ds_list_size(sprw_cur_anim_frames) - 1
    {
        sprw_frame_timer += sprw_frame_rate * global.fpsMult/60
        if sprw_frame_timer >= 1
        {
            sprw_frame_timer = 0
            sprw_frame_index += 1
        }
    }
    else if sprw_loop
        sprw_frame_index = 0
    var frame_i = ds_list_find_value(sprw_cur_anim_frames, sprw_frame_index)
    var f = sprw_frames[frame_i]
    var rotated = f[9]
    var offset_x = 0
    var offset_y = 0
    for (var i = 0; i < ds_list_size(sprw_offset_keys); i++)
    {
        var key = sprw_offset_keys[| i]
        if string_starts_with(f[0], key)
        {
            var off = sprw_offsets[? key]
            offset_x = off[0]
            offset_y = off[1]
            break
        }
    }
	var draw_x = xx - ((offset_x + f[5]) * xscale)
	var draw_y = yy - ((offset_y + f[6]) * yscale)
	if rotated
		draw_y += f[8]
	draw_sprite_general(sprite_index, 0, f[1], f[2], f[3], f[4], draw_x, draw_y, xscale, yscale, angle + rotated ? 90 : 0, colour, colour, colour, colour, alpha)
}

