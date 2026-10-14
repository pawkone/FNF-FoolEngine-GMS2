var character_data = {
    displayName: displayName,
    imagePath: editorchar_image,
    frameRate: sprw_frame_rate,
    scale: editorchar_size,
    flipX: editorchar_flipx,
    playableCharacter: editorchar_playableCharacter,
    position: editorchar_pos,
    camOffset: camOffset,
    animations: []
}
for (var i = 8; i < array_length(things); i++)
{
    var anim_name = things[i]
    sprw_play(anim_name, true)
    var frame_idx = ds_list_find_value(sprw_cur_anim_frames, sprw_frame_index)
    var frame = sprw_frames[frame_idx]
    var frame_name = frame[0]
    var offset = [0, 0]
    for (var j = 0; j < ds_list_size(sprw_offset_keys); j++)
	{
        var key = sprw_offset_keys[| j]
        if string_starts_with(frame_name, key)
		{
            offset = sprw_offsets[? key]
            break
        }
    }
    var anim_struct = {
        xmlPrefix: sprw_cur_anim,
        name: anim_name,
        offset: offset,
		loop: sprw_loop
    };
    array_push(character_data.animations, anim_struct)
}
var json_string = json_stringify(character_data, true)
var filename = get_save_filename("JSON|*.json", character + ".json")
var file = file_text_open_write(filename)
file_text_write_string(file, json_string)
file_text_close(file)
