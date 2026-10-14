if keyboard_check_pressed(vk_backspace) || keyboard_check_pressed(vk_escape)
	instance_destroy()
else if keyboard_check_pressed(vk_enter)
{
	with obj_editorCharacters
	{
		var value_to_remove = things[selected];
		var new_array = []
		for (var j = 0; j < array_length(things); j++)
		{
			if things[j] != value_to_remove
				array_push(new_array, things[j])
		}
		things = new_array
		selected -= 1
		selected = clamp(selected,buttonslimit,array_length(things)-1)
		instance_destroy(obj_editorCharacters_ghost)
		sprw_play(things[selected], true)
	}
	instance_destroy()
}