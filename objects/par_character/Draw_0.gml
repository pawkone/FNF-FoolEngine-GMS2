if !sprw_exists(id)
	exit

if object_index == obj_characterBF
	gpu_set_texfilter(!string_ends_with(global.mGP_charBF, "-pixel"))
else if object_index == obj_characterDad
	gpu_set_texfilter(!string_ends_with(global.mGP_charDad, "-pixel"))
else if object_index == obj_characterGF
	gpu_set_texfilter(!string_ends_with(global.mGP_charGF, "-pixel"))
sprw_draw(x, y, (object_index == obj_characterBF ? sprw_scale[0] : -sprw_scale[0]) * image_xscale, sprw_scale[1] * image_yscale, image_angle, image_blend, image_alpha)
gpu_set_texfilter(true)

singtime -= global.fpsMult/60
for (var i = 0; i < array_length(sprw_animnames); i++)
{
	if sprw_animnames[i][0] == "idle"
	{
		if singtime < 0 && global.mGP_beat && global.mGP_curBeat mod 2 == 0
			sprw_play("idle", true)
	}
	if sprw_animnames[i][0] == "danceLeft"
	{
		if singtime < 0 && global.mGP_beat && global.mGP_curBeat mod 2 == 0
			sprw_play("danceLeft", true)
	}
	if sprw_animnames[i][0] == "danceRight"
	{
		if singtime < 0 && global.mGP_beat && global.mGP_curBeat mod 2 == 1
			sprw_play("danceRight", true)
	}
}