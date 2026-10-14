resize2gamesize()
mGP_init()
selected_note = [-4, -4]
oldcurrentime = -4
audio_stop_all()
get_song_audio()
var _jsondata = jsonData_song()
mult = 1
global.mGP_bpm = _jsondata[0]
notes = _jsondata[1]
camSwitches = _jsondata[2]
_current_time = 0
paused = false

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