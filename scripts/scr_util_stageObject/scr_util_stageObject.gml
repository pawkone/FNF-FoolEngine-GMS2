function stageObject_create(_tagname, _x, _y, _spr)
{
	var _obj = instance_create_depth(_x, _y, 0, obj_stageobj)
	with _obj
	{
		tag = _tagname
		sprite_index = spritepool_load(global.assetsfolder + "images/" + (is_string(global.mGP_stage) ? $"bgs/{global.mGP_stage}/" : "") + _spr + ".png")
	}
	return _obj
}



function stage_clear(BFobj = -4, DADobj = -4, GFobj = -4)
{
	if instance_exists(obj_stageobj) { with obj_stageobj instance_destroy() }
	if object_exists(BFobj) && instance_exists(BFobj) { with BFobj instance_destroy() }
	if object_exists(DADobj) && instance_exists(DADobj) { with DADobj instance_destroy() }
	if object_exists(GFobj) && instance_exists(GFobj) { with GFobj instance_destroy() }
}




function stageHelper_bool(txt)
{
	var _ptxt = stageHelper_string(txt)
	if _ptxt == "true" || _ptxt == "1"
		return 1
	else if _ptxt == "false" || _ptxt == "0"
		return 0
	return 0
}
function stageHelper_asset(txt)
{
	try{return asset_get_index(stageHelper_string(txt))}
	catch(e){return -4}
}
function stageHelper_real(txt)
{
	try{return real(stageHelper_string(txt))}
	catch(e){return 0}
}
function stageHelper_string(txt)
{
	return string_replace_all(string_replace_all(string_trim(txt), @'"', ""), "'", "")
}
function stageHelper_stringLower(txt)
{
	return string_lower(stageHelper_string(txt))
}


function stage_create(txt = "", BFobj = -4, DADobj = -4, GFobj = -4)
{
	global.mGP_camSpd = 1
	global.mGP_gameZoomDef = 1
	global.mGP_gameZoom = 1
	var lines = string_split(string_trim(txt), "\n")
	for (var i = 0; i < array_length(lines); i++)
	{
		try
		{
			var line = string_trim(string_replace_all(lines[i], " ", ""))
			var arg_start = string_pos("(", line)
			var arg_end = string_pos(")", line)
			var arg_str = string_copy(line, arg_start + 1, arg_end - arg_start - 1)
			var args = string_split(arg_str, ",")
			if string_starts_with(line, "stageGlobal_setDefaultZoom")
			{
				var zoom = stageHelper_real(args[0])
				global.mGP_gameZoomDef = zoom
				global.mGP_gameZoom = zoom
			}
			if string_starts_with(line, "stageGlobal_cameraSpeed")
				global.mGP_camSpd = stageHelper_real(args[0])
			if string_starts_with(line, "stageGlobal_setGlobalShaderScript")
				global.mGP_shaderScript = stageHelper_asset(args[0])
			if string_starts_with(line, "stageGlobal_setGlobalShader")
				global.mGP_shader = stageHelper_asset(args[0])
			if string_starts_with(line, "stageGlobal_setDefaultColour")
			{
				var colour_input = stageHelper_string(args[0])
				var colour = c_white
				if string_length(colour_input) == 6 || (string_length(colour_input) == 7 && string_char_at(colour_input, 1) == "#")
				{
					if string_char_at(colour_input, 1) == "#"
						colour_input = string_delete(colour_input, 1, 1)
					var r = real("0x" + string_copy(colour_input, 1, 2))
					var g = real("0x" + string_copy(colour_input, 3, 2))
					var b = real("0x" + string_copy(colour_input, 5, 2))
					colour = make_color_rgb(r,g,b)
				}
				else
				{
					switch string_lower(colour_input)
					{
						case "c_aqua": colour = c_aqua break
						case "c_black": colour = c_black break
						case "c_blue": colour = c_blue break
						case "c_dkgray": colour = c_dkgray break
						case "c_fuchsia": colour = c_fuchsia break
						case "c_gray": colour = c_gray break
						case "c_green": colour = c_green break
						case "c_lime": colour = c_lime break
						case "c_ltgray": colour = c_ltgray break
						case "c_maroon": colour = c_maroon break
						case "c_navy": colour = c_navy break
						case "c_olive": colour = c_olive break
						case "c_orange": colour = c_orange break
						case "c_purple": colour = c_purple break
						case "c_red": colour = c_red break
						case "c_silver": colour = c_silver break
						case "c_teal": colour = c_teal break
						case "c_white": colour = c_white break
						case "c_yellow": colour = c_yellow break
						default: colour = c_white break
					}
				}
				var lay = layer_get_id("Background")
				var bg = layer_background_get_id(lay)
				layer_background_blend(bg, colour)
			}
			if string_starts_with(line, "stageObject_create")
			{
				var tagname = stageHelper_string(args[0])
				var xx = stageHelper_real(args[1])
				var yy = stageHelper_real(args[2])
				var spr_name = stageHelper_string(args[3])
				stageObject_create(tagname, xx, yy, spr_name)
			}
			if string_starts_with(line, "stageObject_setDepth")
			{
				var tagname = stageHelper_string(args[0])
				var ddepth = stageHelper_real(args[1])
				with obj_stageobj
				{
					if tag == tagname
					{
						depth = ddepth
						break
					}
				}
			}
			if string_starts_with(line, "stageObject_setAlpha")
			{
				var tagname = stageHelper_string(args[0])
				var aalpha = stageHelper_real(args[1])
				with obj_stageobj
				{
					if tag == tagname
					{
						image_alpha = aalpha
						break
					}
				}
			}
			if string_starts_with(line, "stageObject_setDepth")
			{
				var tagname = stageHelper_string(args[0])
				var ddepth = stageHelper_real(args[1])
				with obj_stageobj
				{
					if tag == tagname
					{
						depth = ddepth
						break
					}
				}
			}
			if string_starts_with(line, "stageObject_setTextureFilter")
			{
				var tagname = stageHelper_string(args[0])
				var ttexfilter = stageHelper_bool(args[1])
				with obj_stageobj
				{
					if tag == tagname
					{
						texfilter = ttexfilter
						break
					}
				}
			}
			if string_starts_with(line, "stageObject_setVisible")
			{
				var tagname = stageHelper_string(args[0])
				var vvisible = stageHelper_bool(args[1])
				with obj_stageobj
				{
					if tag == tagname
					{
						visible = vvisible
						break
					}
				}
			}
			if string_starts_with(line, "stageObject_setScale")
			{
				var tagname = stageHelper_string(args[0])
				var xxscale = stageHelper_real(args[1])
				var yyscale = stageHelper_real(args[2])
				with obj_stageobj
				{
					if tag == tagname
					{
						image_xscale = xxscale
						image_yscale = yyscale
						break
					}
				}
			}
			if string_starts_with(line, "stageObject_setBlendmode")
			{
				var tagname = stageHelper_string(args[0])
				var bblendmode = stageHelper_string(args[1])
				switch bblendmode
				{
					case "bm_normal": bblendmode = bm_normal break
					case "bm_add": bblendmode = bm_add break
					case "bm_subtract": bblendmode = bm_subtract break
					case "bm_reverse_subtract": bblendmode = bm_reverse_subtract break
					case "bm_min": bblendmode = bm_min break
					case "bm_max": bblendmode = bm_max break
					default: bblendmode = bm_normal break
				}
				with obj_stageobj
				{
					if tag == tagname
					{
						blendmode = bblendmode
						break
					}
				}
			}
			if string_starts_with(line, "stageObject_setScroll")
			{
				var tagname = stageHelper_string(args[0])
				var xxs = stageHelper_real(args[1])
				var yys = stageHelper_real(args[2])
				with obj_stageobj
				{
					if tag == tagname
					{
						scroll = [xxs, yys]
						break
					}
				}
			}
			if string_starts_with(line, "stageObject_setShader")
			{
				var tagname = stageHelper_string(args[0])
				var sshader = stageHelper_asset(args[1])
				with obj_stageobj
				{
					if tag == tagname
					{
						shader = sshader
						break
					}
				}
			}
			if string_starts_with(line, "stageObject_char")
			{
				var xx = stageHelper_real(args[0])
				var yy = stageHelper_real(args[1])
				var char = stageHelper_stringLower(args[2])
				if char == "bf" && object_exists(BFobj)
					instance_create_depth(xx,yy,-102,BFobj)
				if char == "dad" && object_exists(DADobj)
					instance_create_depth(xx,yy,-101,DADobj)
				if char == "gf" && object_exists(GFobj)
					instance_create_depth(xx,yy,-100,GFobj)
			}
		}
		catch(e)
		{
			//show_debug_message("STAGE PARSER - ERROR : " + e.longMessage)
			show_debug_message("STAGE PARSER - ERROR : ERROR BELOW vvv")
			show_debug_message(e.longMessage)
		}
	}
	if !instance_exists(BFobj) && object_exists(BFobj)
		instance_create_depth(900,400,-102,BFobj)
	if !instance_exists(DADobj) && object_exists(DADobj)
		instance_create_depth(600,400,-101,DADobj)
}