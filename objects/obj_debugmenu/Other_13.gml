///@description Loads characters
audio_stop_all()
	
global.savedebugmenu_cursongi = global.savedebugmenu_selected
global.savedebugmenu_cursong = global.savedebugmenu_items[global.savedebugmenu_cursongi]
global.savedebugmenu_selected = 1
	
global.savedebugmenu_menu = debugmenu_scrtype.selectcharacters
global.savedebugmenu_distxt = string_upper(global.savedebugmenu_cursong) + " - Select a chart to load, press escape / backspace to go back."
global.savedebugmenu_items = []
global.savedebugmenu_itemsact = []

var _file_name = file_find_first(global.assetsfolder + "chars/*.json", fa_none)
while _file_name != ""
{
	array_push(global.savedebugmenu_items, string_delete(_file_name,-5,5))
	_file_name = file_find_next()
}
array_sort(global.savedebugmenu_items, true)
array_insert(global.savedebugmenu_items, 0, "'New Character'")
file_find_close()

event_user(4)