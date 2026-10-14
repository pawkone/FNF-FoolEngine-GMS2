resize2gamesize()
audio_stop_all()
sur = surface_create(global.gameSizeW,global.gameSizeH)
inst = -4
if !global.savedebugmenu_fromdebug
	event_user(2)
global.savedebugmenu_fromdebug = false
event_user(4)