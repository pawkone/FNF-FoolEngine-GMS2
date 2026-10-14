var filename = get_open_filename("JSON|*.json", global.mGP_chart + ".json")
if !file_exists(filename)
	exit
global.mGP_name = filename_name(filename)
if string_ends_with(global.mGP_name, ".json")
	global.mGP_name = string_delete(global.mGP_name, -5, 5)
global.mGP_chart = global.mGP_name
global.mGP_name = get_string("Enter filename song name (without difficulty)", global.mGP_name)
audio_stop_all()

mGP_init()
selected_note = [-4, -4]
oldcurrentime = -4
get_song_audio()
var _jsondata = jsonData_songPath(filename)
mult = 1
global.mGP_bpm = _jsondata[0]
notes = _jsondata[1]
camSwitches = _jsondata[2]
_current_time = 0
paused = false

if variable_struct_exists(_jsondata[3], "song")
{
	if variable_struct_exists(_jsondata[3].song, "player1")
		global.mGP_charBF = _jsondata[3].song.player1
	if variable_struct_exists(_jsondata[3].song, "gfVersion")
		global.mGP_charGF = _jsondata[3].song.gfVersion
	if variable_struct_exists(_jsondata[3].song, "player2")
		global.mGP_charDad = _jsondata[3].song.player2
}

if variable_struct_exists(_jsondata[3], "charBF")
	global.mGP_charBF = _jsondata[3].charBF
if variable_struct_exists(_jsondata[3], "charGF")
	global.mGP_charGF = _jsondata[3].charGF
if variable_struct_exists(_jsondata[3], "charDad")
	global.mGP_charDad = _jsondata[3].charDad
if variable_struct_exists(_jsondata[3], "stage")
	global.mGP_stage = _jsondata[3].stage