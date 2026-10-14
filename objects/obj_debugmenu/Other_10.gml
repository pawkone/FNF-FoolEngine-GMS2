///@description Loads songs list
audio_stop_all()

if global.savedebugmenu_menu == debugmenu_scrtype.selectchart
	global.savedebugmenu_selected = global.savedebugmenu_cursongi
else
	global.savedebugmenu_selected = 1
global.savedebugmenu_cursongi = 0

global.savedebugmenu_menu = debugmenu_scrtype.selectsong
global.savedebugmenu_distxt = "Select a song to load it or make a song, press escape / backspace to go back.\n(Press space to play song's preview)"
global.savedebugmenu_items = []
global.savedebugmenu_itemsact = []

var _file_name = file_find_first(global.assetsfolder + "songs/*", fa_directory)
while _file_name != ""
{
	array_push(global.savedebugmenu_items, _file_name)
	_file_name = file_find_next()
}
array_sort(global.savedebugmenu_items, true)
array_insert(global.savedebugmenu_items, 0, "'New Song'")
file_find_close()

event_user(4)