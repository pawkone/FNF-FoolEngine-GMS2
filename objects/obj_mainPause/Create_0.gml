image_alpha = 0
pausebuffer = 0
paused = false
stop = false
select = 0
spr = [-4, -4]
text = ["Resume", "Restart Song", "Exit To Menu", "debug room return"]
textcmd = [
function()
{
	event_user(1)
},

function()
{
	stop = true
	with instance_create_depth(0,0,0,obj_fadeout)
		roomTarget = room
	audio_stop_all()
	audio_play_sound(global.sfx_mnu_scroll,1,false)
},

function()
{
	stop = true
	with instance_create_depth(0,0,0,obj_fadeout)
		roomTarget = rm_titleScreen
	audio_stop_all()
	audio_play_sound(global.sfx_mnu_scroll,1,false)
},

function()
{
	stop = true
	with instance_create_depth(0,0,0,obj_fadeout)
		roomTarget = rm_debugmenu
	audio_stop_all()
	audio_play_sound(global.sfx_mnu_cancel,1,false)
}
]