function jsonData_songPath(path)
{
	var json_string = file_string(path)
	if json_string == ""
		return jsonData_songEmpty()	
	var data = json_parse(json_string)
	if !variable_struct_exists(data, "arrows")
	{
		if variable_struct_exists(data, "format") && (data.format == "psych_v1" || data.format == "psych_v1_convert")
			return jsonData_songPYSCHV1FNFCompatibility(data)
		else
			return jsonData_songFLXFNFCompatibility(data)
	}
	else
		return jsonData_songFoolEngine(data)
}
function jsonData_song()
{
	return jsonData_songPath(global.assetsfolder + "songs/" + global.mGP_name + "/" + global.mGP_chart + ".json")
}
function jsonData_songEmpty()
{
	return [100, [], [[0, 0]], ds_map_create(), []]
}
function jsonData_songFoolEngine(parsedJson)
{
	var notes = []
	var switchcams = []
	for (var i = 0; i < array_length(parsedJson.arrows); i++)
	{
	    var sectionNote = parsedJson.arrows[i]
		if array_length(sectionNote) == 1
			array_push(notes, [round(sectionNote[0]), 0, 0])
		else if array_length(sectionNote) == 2
			array_push(notes, [round(sectionNote[0]), sectionNote[1], 0])
		else
			array_push(notes, [round(sectionNote[0]), sectionNote[1], sectionNote[2]])
	}
	for (var i = 0; i < array_length(parsedJson.switchCams); i++)
	{
	    var sectionCam = parsedJson.switchCams[i]
		array_push(switchcams, [sectionCam[0], sectionCam[1]])
	}
	return [parsedJson.bpm, notes, switchcams, parsedJson, []]
}
function jsonData_songFLXFNFCompatibility(parsedJson)
{
	var notes = []
	var switchcams = []
	var bpmchanges = []
	var curBpm = parsedJson.song.bpm
	var time = 0
	for (var i = 0; i < array_length(parsedJson.song.notes); i++)
	{
	    var note = parsedJson.song.notes[i]
	    var mustHitSection = note.mustHitSection
	    var sectionNotes = note.sectionNotes
		var lengthInSteps = 16
		if variable_struct_exists(note, "lengthInSteps")
			lengthInSteps = note.lengthInSteps
		if variable_struct_exists(note, "changeBPM") && note.changeBPM
		{
			array_push(bpmchanges, [time, note.bpm])
			curBpm = note.bpm
		}
		array_push(switchcams, [time, mustHitSection])
		time += ((time_bpm_to_seconds(curBpm)*1000)*(lengthInSteps/4))
	    for (var j = 0; j < array_length(sectionNotes); j++)
		{
	        var sectionNote = sectionNotes[j]
			if struct_get(parsedJson.song, "format") == "psych_v1" || mustHitSection
			{
				if sectionNote[1] <= 3
					sectionNote[1] += 4
				else if sectionNote[1] >= 4
					sectionNote[1] -= 4
			}
			array_push(notes, [round(sectionNote[0]), sectionNote[1], sectionNote[2]])
	    }
	}
	return [parsedJson.song.bpm, notes, switchcams, parsedJson, bpmchanges]
}
function jsonData_songPYSCHV1FNFCompatibility(parsedJson)
{
	var notes = []
	var switchcams = []
	var bpmchanges = []
	var curBpm = parsedJson.bpm
	var time = 0
	for (var i = 0; i < array_length(parsedJson.notes); i++)
	{
	    var note = parsedJson.notes[i]
	    var mustHitSection = note.mustHitSection
	    var sectionNotes = note.sectionNotes
		var sectionBeats = note.sectionBeats
		if variable_struct_exists(note, "changeBPM") && note.changeBPM
		{
			array_push(bpmchanges, [time, note.bpm])
			curBpm = note.bpm
		}
		array_push(switchcams, [time, mustHitSection])
		time += (time_bpm_to_seconds(curBpm)*1000)*sectionBeats
	    for (var j = 0; j < array_length(sectionNotes); j++)
		{
	        var sectionNote = sectionNotes[j]
			if sectionNote[1] <= 3
				sectionNote[1] += 4
			else if sectionNote[1] >= 4
				sectionNote[1] -= 4
			array_push(notes, [round(sectionNote[0]), sectionNote[1], sectionNote[2]])
	    }
	}
	show_debug_message(bpmchanges)
	return [parsedJson.bpm, notes, switchcams, parsedJson, bpmchanges]
}



function jsonData_character(char_name, char_type = "")
{
	displayName = ""
	camOffset = [0, 0]
	sprw_scale = [1, 1]
    var file_path = global.assetsfolder + "chars/" + char_name
	if is_path_absolute(char_name)
		file_path = "" + char_name
	if !string_ends_with(char_name, ".json")
		file_path += ".json"
    if !file_exists(file_path)
	{
        show_debug_message("Character JSON not found: " + file_path)
		if char_name != "bf"
		{
			jsonData_character("bf")
			if char_type != ""
				variable_global_set(char_type, "bf")
		}
        return
    }
	var json_string = file_string(file_path)
    var char_data = json_parse(json_string)
    if is_undefined(char_data)
	{
        show_debug_message("Failed to parse character JSON: " + file_path)
        return
    }
	
    displayName = char_data.displayName
	camOffset = char_data.camOffset
    var anim_array = char_data.animations
	
	if variable_struct_exists(char_data, "scale")
		sprw_scale = [char_data.flipX ? -char_data.scale : char_data.scale, char_data.scale]
	
	x = xstart
	y = ystart
	if variable_struct_exists(char_data, "position")
	{
		x += char_data.position[0]
		y += char_data.position[1]
	}
	
    sprw_load(char_data.imagePath, char_data.frameRate)
    for (var i = 0; i < array_length(anim_array); i++)
	{
		var name = anim_array[i].name
		var loop = variable_struct_exists(anim_array[i], "loop") && anim_array[i].loop
		if (object_index == obj_characterDad && char_data.playableCharacter)
		|| (object_index == obj_characterBF && !char_data.playableCharacter)
		{
			if name == "singLEFT"
					name = "singRIGHT"
			else if name == "singRIGHT"
					name = "singLEFT"
		}
        sprw_add(anim_array[i].xmlPrefix, anim_array[i].offset, name, loop)
	}
	
    show_debug_message("Character loaded: " + displayName)
}







function jsonData_character_editor(char_name)
{
	displayName = ""
	camOffset = [0, 0]
	sprw_scale = [1, 1]
    var file_path = global.assetsfolder + "chars/" + char_name
	if is_path_absolute(char_name)
		file_path = char_name
	if !string_ends_with(char_name, ".json")
		file_path += ".json"
    if !file_exists(file_path)
	{
        show_debug_message("Character JSON not found: " + file_path)
		if char_name != "bf"
			jsonData_character_editor("bf")
        return
    }
	var json_string = file_string(file_path)
    var char_data = json_parse(json_string)
    if is_undefined(char_data)
	{
        show_debug_message("Failed to parse character JSON: " + file_path)
        return
    }

    displayName = char_data.displayName
	camOffset = char_data.camOffset
	editorchar_flipx = char_data.flipX
	editorchar_size = char_data.scale
	editorchar_pos = char_data.position
	editorchar_image = char_data.imagePath
	editorchar_fps = char_data.frameRate
    editorchar_animations = char_data.animations
	editorchar_playableCharacter = char_data.playableCharacter

    sprw_load(editorchar_image, editorchar_fps)
    for (var i = 0; i < array_length(editorchar_animations); i++)
        sprw_add(editorchar_animations[i].xmlPrefix, editorchar_animations[i].offset, editorchar_animations[i].name, variable_struct_exists(editorchar_animations[i], "loop") && editorchar_animations[i].loop)

    show_debug_message("Character loaded: " + displayName)
}
function jsonData_character_editor_empty(_image, _fps = 24)
{
	displayName = ""
	camOffset = [0, 0]
	sprw_scale = [1, 1]

	editorchar_flipx = false
	editorchar_size = 1
	editorchar_pos = [0,0]
	editorchar_image = _image
	editorchar_fps = _fps
    editorchar_animations = []

    sprw_load(editorchar_image, editorchar_fps)
}