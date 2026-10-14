spritepool_load(assetsfolder + "images/editor/editor_stage_bf.png")
spritepool_load(assetsfolder + "images/editor/editor_stage_dad.png")
spritepool_load(assetsfolder + "images/editor/editor_stage_gf.png")
spritepool_load(assetsfolder + "images/ui/countdown/go.png", 1, -1, -1)
spritepool_load(assetsfolder + "images/ui/countdown/set.png", 1, -1, -1)
spritepool_load(assetsfolder + "images/ui/countdown/ready.png", 1, -1, -1)
spritepool_load(assetsfolder + "images/ui/rating/sick.png")
spritepool_load(assetsfolder + "images/ui/rating/good.png")
spritepool_load(assetsfolder + "images/ui/rating/bad.png")
spritepool_load(assetsfolder + "images/ui/rating/shit.png")
spritepool_load(assetsfolder + "images/healthicons/face.png")
spritepool_load(assetsfolder + "images/logobumpinj.png", 1, -1, -1)
instance_create_depth(0, 0, 0, preload_obj_notes)

function assetpool_dsmapcheck(_global_name)
{
	if !variable_global_exists(_global_name)
		variable_global_set(_global_name, ds_map_create())
}
function spritepool_load(_path, _frames = 1, _xorg = 0, _yorg = 0)
{
	assetpool_dsmapcheck("sprite_pool")
	if ds_map_exists(global.sprite_pool, _path)
		return global.sprite_pool[? _path]
	if file_exists(_path)
	{
		var spr_id = sprite_add(_path, _frames, false, false, _xorg, _yorg)
		if _xorg == -1
			_xorg = sprite_get_width(spr_id) / 2
		if _yorg == -1
			_yorg = sprite_get_height(spr_id) / 2
		sprite_set_offset(spr_id, _xorg, _yorg);
		global.sprite_pool[? _path] = spr_id
		return spr_id
	}
	else
		return spr_error
}
function spritepool_reload(_path, _frames = 1, _xorg = 0, _yorg = 0)
{
	assetpool_dsmapcheck("sprite_pool")
	if ds_map_exists(global.sprite_pool, _path)
	{
		sprite_delete(global.sprite_pool[? _path])
		ds_map_delete(global.sprite_pool, _path)
	}
	return spritepool_load(_path, _frames, _xorg, _yorg)
}

function soundpool_load(_path)
{
	assetpool_dsmapcheck("sound_pool")
	if ds_map_exists(global.sound_pool, _path)
		return global.sound_pool[? _path]
	if file_exists(_path)
	{
		var aud_id = audio_create_stream(_path)
		global.sound_pool[? _path] = aud_id
		return aud_id
	}
	else
		return sfx_beep
}
function soundpool_reload(_path)
{
	assetpool_dsmapcheck("sound_pool")
	if ds_map_exists(global.sound_pool, _path)
	{
		audio_destroy_stream(global.sound_pool[? _path])
		ds_map_delete(global.sound_pool, _path)
	}
	return soundpool_load(_path)
}


function spritepool_free_all()
{
	if variable_global_exists("sprite_pool")
	{
		var keys = ds_map_keys_to_array(global.sprite_pool)
		for (var i = 0; i < array_length(keys); i++)
			sprite_delete(global.sprite_pool[? keys[i]])
		ds_map_destroy(global.sprite_pool)
		global.sprite_pool = undefined
	}
}
function soundpool_free_all()
{
	if variable_global_exists("sound_pool")
	{
		var keys = ds_map_keys_to_array(global.sound_pool)
		for (var i = 0; i < array_length(keys); i++)
			audio_destroy_stream(global.sound_pool[? keys[i]])
		ds_map_destroy(global.sound_pool)
		global.sound_pool = undefined
	}
}