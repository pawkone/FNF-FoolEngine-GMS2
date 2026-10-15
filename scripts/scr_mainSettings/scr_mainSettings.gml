global.mS_savePath = game_save_id + "wiptempFE_settings.ini"

mS_load(true)

function mS_load(_open_ini = false)
{
	if _open_ini
	{
		ini_open(global.mS_savePath)

		global.mS_hitSounds = ini_read_real("Gameplay", "Hitsounds", false)
		global.mS_hitsoundName = ini_read_string("Gameplay", "HitsoundsName", "foolengine")
		global.mS_ghostTapping = ini_read_real("Gameplay", "ghostTapping", true)
		global.mS_botPlay = ini_read_real("Gameplay", "Botplay", false)
		
		global.mS_noteSplashes = ini_read_real("Visuals", "noteSplashes", true)

		global.mS_vSync = ini_read_real("Graphics", "vSync", false)
		global.mS_maxFps = ini_read_real("Graphics", "maxFps", 60)
		
		global.mGP_keys[0] = ini_read_real("Controls", "mGP_keys_0", ord("A"))
		global.mGP_keys[1] = ini_read_real("Controls", "mGP_keys_1", ord("S"))
		global.mGP_keys[2] = ini_read_real("Controls", "mGP_keys_2", ord("W"))
		global.mGP_keys[3] = ini_read_real("Controls", "mGP_keys_3", ord("D"))

		ini_close()
	}
	
	display_reset(0, global.mS_vSync)
	game_set_speed(global.mS_maxFps, gamespeed_fps)
	if global.mS_hitSounds
		mS_hitsound()
}
function mS_save()
{
	ini_open(global.mS_savePath)
	
	ini_write_string("WARNING", "", "this is used for pre-final fool engine save files!")
	
	ini_write_real("Gameplay", "Hitsounds", global.mS_hitSounds)
	ini_write_string("Gameplay", "HitsoundsName", global.mS_hitsoundName)
	ini_write_real("Gameplay", "ghostTapping", global.mS_ghostTapping)
	ini_write_real("Gameplay", "Botplay", global.mS_botPlay)
	
	ini_write_real("Visuals", "noteSplashes", global.mS_noteSplashes)
	
	ini_write_real("Graphics", "vSync", global.mS_vSync)
	ini_write_real("Graphics", "maxFps", global.mS_maxFps)
	
	ini_write_real("Controls", "mGP_keys_0", global.mGP_keys[0])
	ini_write_real("Controls", "mGP_keys_1", global.mGP_keys[1])
	ini_write_real("Controls", "mGP_keys_2", global.mGP_keys[2])
	ini_write_real("Controls", "mGP_keys_3", global.mGP_keys[3])
	
	ini_close()
}
function mS_hitsound()
{
	var __scrpath
	__scrpath = global.assetsfolder + "sounds/hitnote/" + global.mS_hitsoundName + "/scr_load.gml"
	gmlscr_read(__scrpath)
	
	__scrpath = global.assetsfolder + "sounds/hitnote/" + global.mS_hitsoundName + "/scr_sound.gml"
	global.mS_hitsoundScript = gmlscr_read_snippet(__scrpath)
}