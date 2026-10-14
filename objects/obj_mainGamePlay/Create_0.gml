mGP_init()
application_surface_draw_enable(false)
snipscr_update = -4
snipscr_updatepost = -4

var __scrpath
__scrpath = assetsfolder + "songs/" + global.mGP_name + "/scr_initbegin.gml"
gmlscr_read(__scrpath)

audio_stop_all()
instance_create_depth(0,0,0,preload_obj_notes)

with (instance_create_depth(global.mGP_strumpos[0][0], global.mGP_strumpos[0][1], -10, obj_staticStrum))
{
	strumid = 0
	dir = "left"
}
with (instance_create_depth(global.mGP_strumpos[1][0], global.mGP_strumpos[1][1], -10, obj_staticStrum))
{
	strumid = 1
	dir = "down"
}
with (instance_create_depth(global.mGP_strumpos[2][0], global.mGP_strumpos[2][1], -10, obj_staticStrum))
{
	strumid = 2
	dir = "up"
}
with (instance_create_depth(global.mGP_strumpos[3][0], global.mGP_strumpos[3][1], -10, obj_staticStrum))
{
	strumid = 3
	dir = "right"
}
with (instance_create_depth(global.mGP_strumpos[4][0], global.mGP_strumpos[4][1], -10, obj_staticStrum))
{
	strumid = 4
	dirnum = 0
	dir = "left"
}
with (instance_create_depth(global.mGP_strumpos[5][0], global.mGP_strumpos[5][1], -10, obj_staticStrum))
{
	strumid = 5
	dirnum = 1
	dir = "down"
}
with (instance_create_depth(global.mGP_strumpos[6][0], global.mGP_strumpos[6][1], -10, obj_staticStrum))
{
	strumid = 6
	dirnum = 2
	dir = "up"
}
with (instance_create_depth(global.mGP_strumpos[7][0], global.mGP_strumpos[7][1], -10, obj_staticStrum))
{
	strumid = 7
	dirnum = 3
	dir = "right"
}

var _jsondata = jsonData_song()

global.mGP_bpm = _jsondata[0]
global.mGP_curBeat = 0
oldCurBeat = -1

notes = _jsondata[1]
triggered = []
for (var i = 0; i < array_length(notes); i++)
	triggered[i] = false

camchanges = _jsondata[2]
mustHitcam = false
camchangestri = []
for (var i = 0; i < array_length(camchanges); i++)
	camchangestri[i] = false

bpmchanges = _jsondata[4]
bpmchangestri = []
for (var i = 0; i < array_length(bpmchanges); i++)
	bpmchangestri[i] = false
	
if variable_struct_exists(_jsondata[3], "gfVersion")
	global.mGP_charGF = _jsondata[3].gfVersion
else if variable_struct_exists(_jsondata[3], "song") && variable_struct_exists(_jsondata[3].song, "gfVersion")
	global.mGP_charGF = _jsondata[3].song.gfVersion
else if variable_struct_exists(_jsondata[3], "charGF")
	global.mGP_charGF = _jsondata[3].charGF

if variable_struct_exists(_jsondata[3], "player1")
	global.mGP_charBF = _jsondata[3].player1
else if variable_struct_exists(_jsondata[3], "song") && variable_struct_exists(_jsondata[3].song, "player1")
	global.mGP_charBF = _jsondata[3].song.player1
else if variable_struct_exists(_jsondata[3], "charBF")
	global.mGP_charBF = _jsondata[3].charBF

if variable_struct_exists(_jsondata[3], "player2")
	global.mGP_charDad = _jsondata[3].player2
else if variable_struct_exists(_jsondata[3], "song") && variable_struct_exists(_jsondata[3].song, "player2")
	global.mGP_charDad = _jsondata[3].song.player2
else if variable_struct_exists(_jsondata[3], "charDad")
	global.mGP_charDad = _jsondata[3].charDad

if variable_struct_exists(_jsondata[3], "stage")
	global.mGP_stage = _jsondata[3].stage


misssounds[0] = soundpool_load(assetsfolder + "sounds/missnote1.ogg")
misssounds[1] = soundpool_load(assetsfolder + "sounds/missnote2.ogg")
misssounds[2] = soundpool_load(assetsfolder + "sounds/missnote3.ogg")

instance_create_depth(0,0,0,obj_healthBar)
instance_create_depth(0,0,0,obj_mainPause)

#region stage
{
	var script_text = @'stageObject_setDefaultZoom(0.65)
	stageObject_char(900, 400, "bf")
	stageObject_char(700, 430, "gf")
	stageObject_char(600, 400, "dad")'
	if global.mGP_stage != -4 && file_exists(assetsfolder + "stages/" + global.mGP_stage + ".stg")
		script_text = file_string(assetsfolder + "stages/" + global.mGP_stage + ".stg")
	else
		global.mGP_stage = -4
	stage_create(script_text, obj_characterBF, obj_characterDad, obj_characterGF)
}
#endregion

snipscr_update = -4
snipscr_updatepost = -4
__scrpath = assetsfolder + "songs/" + global.mGP_name + "/scr_init.gml"
gmlscr_read(__scrpath)
__scrpath = assetsfolder + "songs/" + global.mGP_name + "/	.gml"
snipscr_update = gmlscr_read_snippet(__scrpath)
__scrpath = assetsfolder + "songs/" + global.mGP_name + "/scr_updatepost.gml"
snipscr_updatepost = gmlscr_read_snippet(__scrpath)

instID = -4
instPATH = -4
inst = -4
vocalsID = -4
vocalsPATH = -4
vocals = -4
vocals1ID = -4
vocals1PATH = -4
vocals1 = -4
vocals2ID = -4
vocals2PATH = -4
vocals2 = -4

var _camofx = 0
var _camofy = -75
if camchanges[0][1]
{
	if instance_exists(obj_characterBF)
	{
		global.mGP_gameX = obj_characterBF.x+obj_characterBF.camOffset[0]-_camofx
		global.mGP_gameY = obj_characterBF.y+obj_characterBF.camOffset[1]-_camofy
	}
}
else
{
	if instance_exists(obj_characterDad)
	{
		global.mGP_gameX = obj_characterDad.x+obj_characterDad.camOffset[0]-_camofx
		global.mGP_gameY = obj_characterDad.y+obj_characterDad.camOffset[1]-_camofy
	}
}
var _camid = view_camera[0]
camera_set_view_size(_camid, global.gameSizeW*(2-global.mGP_gameZoom),global.gameSizeH*(2-global.mGP_gameZoom))
camera_set_view_pos(_camid, global.mGP_gameX-(camera_get_view_width(_camid)/2), global.mGP_gameY-(camera_get_view_height(_camid)/2))
camera_set_view_angle(_camid, global.mGP_gameAngle)

countdown_3sfx = -4
countdown_2sfx = -4
countdown_1sfx = -4
countdown_gosfx = -4
countdownspr = -4
countdownalpha = 1
countdowntime = 0
get_song_audio()

if global.mGP_skipCountdown
{
	timer = 0
	var __scrpath = assetsfolder + "songs/" + global.mGP_name + "/scr_songstart.gml"
	gmlscr_read(__scrpath)
}
else
{
	timer = time_bpm_to_seconds(global.mGP_bpm)*4
	countdown_go = spritepool_load(assetsfolder + "images/ui/countdown/go.png")
	countdown_set = spritepool_load(assetsfolder + "images/ui/countdown/set.png")
	countdown_ready = spritepool_load(assetsfolder + "images/ui/countdown/ready.png")
	countdown_3sfx = soundpool_load(assetsfolder + "sounds/intro3.ogg")
	countdown_2sfx = soundpool_load(assetsfolder + "sounds/intro2.ogg")
	countdown_1sfx = soundpool_load(assetsfolder + "sounds/intro1.ogg")
	countdown_gosfx = soundpool_load(assetsfolder + "sounds/introGo.ogg")
	audio_pause_sound(inst)
	audio_pause_sound(vocals)
	audio_pause_sound(vocals1)
	audio_pause_sound(vocals2)
}