draw_set_circle_precision(8)
os_set_orientation_lock(true, false)
gml_pragma("forceinline")
gml_pragma("UnityBuild", "true")
gml_pragma("optimise", "js_array_check", "push, false")
gml_pragma("optimise", "js_error_check", "push, false")
gml_pragma("optimise", "js_check_index", "push, false")
gml_pragma("optimise", "js_pre_post_no_long", "push, true")
gml_pragma("optimise", "js_use_infix_ops", "push, true")
gml_release_mode(true)
texturegroup_set_mode(true, false, spr_error)
scheduler_resolution_set(16)
gc_target_frame_time(-100)
gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_inv_src_alpha)
gmlvm_init()

global.assetsfolder = (GM_build_type == "run" ? working_directory : program_directory) + "assets/"
global.fpsMult = 0
global.gameSizeW = 1280
global.gameSizeH = 720

global.sD_comfirm_room = rm_mainGamePlay
global.sD_cancel_room = rm_titleScreen

global.fnt_bold00spr = -4
global.fnt_bold01spr = -4
global.fnt_bold00fnt = -4
global.fnt_bold01fnt = -4

if file_exists(global.assetsfolder + "images/ui/fonts/bold00.png")
{
	global.fnt_bold00spr = spritepool_load(global.assetsfolder + "images/ui/fonts/bold00.png", 40, 50, 50)
	global.fnt_bold00fnt = font_add_sprite_ext(global.fnt_bold00spr, "#$%(),-!.?':;ABCDEFGHIJKLMNOPQRSTUVWXYZ_", true, -55)
}
if file_exists(global.assetsfolder + "images/ui/fonts/bold01.png")
{
	global.fnt_bold01spr = spritepool_load(global.assetsfolder + "images/ui/fonts/bold01.png", 40, 50, 50)
	global.fnt_bold01fnt = font_add_sprite_ext(global.fnt_bold01spr, "#$%(),-!.?':;ABCDEFGHIJKLMNOPQRSTUVWXYZ_", true, -55)
}

global.sfx_mnu_cancel = soundpool_load(global.assetsfolder + "sounds/cancelMenu.ogg")
global.sfx_mnu_scroll = soundpool_load(global.assetsfolder + "sounds/scrollMenu.ogg")
global.sfx_mnu_confirm = soundpool_load(global.assetsfolder + "sounds/confirmMenu.ogg")


function draw_text_boldfont(xx,yy,txt,xscale=1,yscale=1,angle=0)
{
	txt = string_upper(txt)
	var ogcol = draw_get_colour()
	var ogfont = draw_get_font()
	var val = floor(current_time/75) mod 2 == 0
	draw_set_colour(c_white)
	var _e1 = font_exists(global.fnt_bold00fnt)
	var _e2 = font_exists(global.fnt_bold01fnt)
	if _e1 && _e2
		draw_set_font(val?global.fnt_bold00fnt : global.fnt_bold01fnt)
	else if !_e1 && !_e2
		draw_set_font(fnt_debug)
	else if _e1 && !_e2
		draw_set_font(global.fnt_bold00fnt)
	else if !_e1 && _e2
		draw_set_font(global.fnt_bold01fnt)
	for (var i = 0; i <= string_length(txt); i++)
		draw_text_transformed(xx+(15*xscale)+(i*xscale*50),yy+(100*yscale),string_char_at(txt,i+1),xscale,yscale,angle)
	draw_set_colour(ogcol)
	draw_set_font(ogfont)
}
function resize2gamesize()
{
	surface_resize(application_surface, global.gameSizeW, global.gameSizeH)
	display_set_gui_size(global.gameSizeW, global.gameSizeH)
	camera_set_view_size(view_camera[0], global.gameSizeW, global.gameSizeH)
	view_set_wport(0, global.gameSizeW)
	view_set_hport(0, global.gameSizeH)
	room_width = global.gameSizeW
	room_height = global.gameSizeH
}
function is_path_absolute(path)
{
	if string_length(path) >= 3 && string_char_at(path, 2) == ":" && string_char_at(path, 3) == "\\"
		return true
	return false
}
function file_string(path)
{
	if !file_exists(path)
		return ""
	var __str = ""
	var __file = file_text_open_read(path)
	while (!file_text_eof(__file))
	{
		__str += file_text_read_string(__file) + "\n"
		file_text_readln(__file)
	}
	file_text_close(__file)
	return __str
}
function get_song_audio(songname = global.mGP_name, loadinst = true, loadvoices = true)
{
	inst = -4
	instPATH = ""
	if variable_instance_exists(id, "instID") && audio_exists(instID)
		audio_stop_sound(instID)
	instID = -4
	vocals = -4
	vocalsPATH = ""
	if variable_instance_exists(id, "vocalsID") && audio_exists(vocalsID)
		audio_stop_sound(vocalsID)
	vocalsID = -4
	vocals1 = -4
	vocals1PATH = ""
	if variable_instance_exists(id, "vocals1ID") && audio_exists(vocals1ID)
		audio_stop_sound(vocals1ID)
	vocals1ID = -4
	vocals2 = -4
	vocals2PATH = ""
	if variable_instance_exists(id, "vocals2ID") && audio_exists(vocals2ID)
		audio_stop_sound(vocals2ID)
	vocals2ID = -4
	
	var _pitch = 1
	
	var _loaded = false
	if loadinst
	{
		if file_exists(global.assetsfolder + "songs/" + songname + "/Inst.ogg")
		{
			_loaded = true
			instPATH = global.assetsfolder + "songs/" + songname + "/Inst.ogg"
			instID = soundpool_load(instPATH)
			inst = audio_play_sound(instID, 10, false, 1,0,_pitch)
		}
	}
	if loadvoices
	{
		if file_exists(global.assetsfolder + "songs/" + songname + "/Voices.ogg")
		{
			_loaded = true
			vocalsPATH = global.assetsfolder + "songs/" + songname + "/Voices.ogg"
			vocalsID = soundpool_load(vocalsPATH)
			vocals = audio_play_sound(vocalsID, 10, false, 1,0,_pitch)
		}
		if file_exists(global.assetsfolder + "songs/" + songname + "/Voices-Opponent.ogg")
		{
			_loaded = true
			vocals1PATH = global.assetsfolder + "songs/" + songname + "/Voices-Opponent.ogg"
			vocals1ID = soundpool_load(vocals1PATH)
			vocals1 = audio_play_sound(vocals1ID, 10, false, 1,0,_pitch)
		}
		if file_exists(global.assetsfolder + "songs/" + songname + "/Voices-Player.ogg")
		{
			_loaded = true
			vocals2PATH = global.assetsfolder + "songs/" + songname + "/Voices-Player.ogg"
			vocals2ID = soundpool_load(vocals2PATH)
			vocals2 = audio_play_sound(vocals2ID, 10, false, 1,0,_pitch)
		}
	}
	return _loaded
}