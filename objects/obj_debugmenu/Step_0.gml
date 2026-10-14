var _oldselected = global.savedebugmenu_selected
global.savedebugmenu_selected += keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)
global.savedebugmenu_selected += mouse_wheel_down()-mouse_wheel_up()
if _oldselected != global.savedebugmenu_selected
{
	global.savedebugmenu_selected = clamp(global.savedebugmenu_selected,0,array_length(global.savedebugmenu_items)-1)
	event_user(4)
}
if global.savedebugmenu_menu == debugmenu_scrtype.selectsong
{
	if _oldselected != global.savedebugmenu_selected
		audio_stop_all()
	if keyboard_check_pressed(vk_space) && global.savedebugmenu_selected != 0
	{
		if !audio_is_playing(inst)
			get_song_audio(global.savedebugmenu_items[global.savedebugmenu_selected], true, false)
		else
			audio_stop_all()
	}
	else if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_enter)) && global.savedebugmenu_selected != 0
		event_user(1)
	else if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_backspace) || mouse_check_button_pressed(mb_right))
		event_user(2)
}
else if global.savedebugmenu_menu == debugmenu_scrtype.selectchart
{
	if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_enter))
	{
		global.mGP_name = global.savedebugmenu_cursong
		global.mGP_chart = global.savedebugmenu_items[global.savedebugmenu_selected]
		global.savedebugmenu_fromdebug = true
		var quest = get_string("Do you wanna load this song in..\n\n1 = gameplay state\n2 = chart editor\nAnything else = cancel", "")
		if quest == "2"
			room_goto(rm_editorSongs)
		else if quest == "1"
			room_goto(rm_mainGamePlay)
	}
	else if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_backspace) || mouse_check_button_pressed(mb_right))
		event_user(0)
}
else if global.savedebugmenu_menu == debugmenu_scrtype.selectcharacters
{
	if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_enter))
	{
		global.mGP_charBF = global.savedebugmenu_items[global.savedebugmenu_selected]
		global.savedebugmenu_fromdebug = true
		room_goto(rm_editorCharacters)
	}
	else if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_backspace) || mouse_check_button_pressed(mb_right))
		event_user(2)
}
else if global.savedebugmenu_menu == debugmenu_scrtype.selecteditor
{
	if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_enter))
	{
		if is_string(global.savedebugmenu_itemsact[global.savedebugmenu_selected])
		{
			var quest = show_question("Are you sure you want to go to this room?")
			if quest
				room_goto(asset_get_index(global.savedebugmenu_itemsact[global.savedebugmenu_selected]))
		}
		else
			script_execute(global.savedebugmenu_itemsact[global.savedebugmenu_selected])
	}
}
