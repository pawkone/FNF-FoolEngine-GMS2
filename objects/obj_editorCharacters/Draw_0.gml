if instance_exists(obj_editorCharacters_delete)
	exit
if !sprw_exists(id) || array_length(things) <= buttonslimit
	exit
gpu_set_texfilter(!string_ends_with(character, "-pixel"))
sprw_draw(x, y, (editorchar_playableCharacter ? sprw_scale[0] : -sprw_scale[0]) * (editorchar_flipx ? -1 : 1), sprw_scale[1])
gpu_set_texfilter(true)