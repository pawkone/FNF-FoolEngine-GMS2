if !sprw_exists(id)
	exit
gpu_set_texfilter(!string_ends_with(character, "-pixel"))
sprw_draw(x, y, (editorchar_playableCharacter ? sprw_scale[0] : -sprw_scale[0]) * (editorchar_flipx ? -1 : 1), sprw_scale[1], 0, c_white, 0.25)
gpu_set_texfilter(true)