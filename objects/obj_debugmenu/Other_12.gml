///@description Loads main debugmenu (selecteditor)
audio_stop_all()

global.savedebugmenu_selected = 0
global.savedebugmenu_cursongi = 0
global.savedebugmenu_menu = debugmenu_scrtype.selecteditor
global.savedebugmenu_distxt = "Choose what type of element you want to edit or select an option!"


global.savedebugmenu_items = []
global.savedebugmenu_itemsact = []

array_push(global.savedebugmenu_items, "Editor : Songs")
array_push(global.savedebugmenu_itemsact, function(){event_user(0)})
array_push(global.savedebugmenu_items, "Editor : Characters")
array_push(global.savedebugmenu_itemsact, function(){event_user(3)})
array_push(global.savedebugmenu_items, "Editor : Stages")
array_push(global.savedebugmenu_itemsact, function(){room_goto(rm_editorStages)})

var _rm = 0
while room_exists(_rm)
{
	try{if room_exists(_rm) && _rm != room {
		array_push(global.savedebugmenu_items, "Go to : '" + room_get_name(_rm) + "'")
		array_push(global.savedebugmenu_itemsact, room_get_name(_rm))
	}}catch(e){}
	_rm++
}

event_user(4)