var leveldirectory = get_save_filename("FNF Fool engine chart (JSON)|*.json", global.mGP_chart)
if !is_undefined(leveldirectory) && string_replace_all(leveldirectory, " ", "") != ""
{
	var processed_notes = []
	for (var i = 0; i < array_length(notes); i++)
	{
		if notes[i][1] == 0 && notes[i][2] == 0
			processed_notes[i] = [int64(notes[i][0])]
		else if notes[i][2] == 0
			processed_notes[i] = [int64(notes[i][0]), int64(notes[i][1])]
		else
			processed_notes[i] = [int64(notes[i][0]), int64(notes[i][1]), int64(notes[i][2])]
	}
	var processed_camSwitches = []
	for (var i = 0; i < array_length(camSwitches); i++)
	{
		var entry = [int64(camSwitches[i][0]), int64(camSwitches[i][1])]
		if i == 0
			array_push(processed_camSwitches, entry)
		else
		{
			var last = processed_camSwitches[array_length(processed_camSwitches) - 1]
			if entry[1] != last[1]
				array_push(processed_camSwitches, entry)
		}
	}

	var json_str = "{\n"
	json_str += "  \"bpm\": " + string(int64(global.mGP_bpm)) + ",\n"
	json_str += "  \"stage\": \"" + global.mGP_stage + "\",\n"
	json_str += "  \"charBF\": \"" + global.mGP_charBF + "\",\n"
	json_str += "  \"charDad\": \"" + global.mGP_charDad + "\",\n"
	json_str += "  \"arrows\": [\n";
    for (var i = 0; i < array_length(processed_notes); i++)
	{
        var note = processed_notes[i]
        json_str += "    ["
        for (var j = 0; j < array_length(note); j++)
		{
            if j > 0
				json_str += ", "
            json_str += string(int64(note[j]));
        }
        json_str += "]"
        if i < array_length(processed_notes) - 1
			json_str += ","
        json_str += "\n"
    }
    json_str += "  ],\n";
	
	json_str += "  \"switchCams\": [\n";
    for (var i = 0; i < array_length(processed_camSwitches); i++)
	{
        var cannn = processed_camSwitches[i]
        json_str += "    ["
        for (var j = 0; j < array_length(cannn); j++)
		{
            if j > 0
				json_str += ", "
            json_str += string(int64(cannn[j]));
        }
        json_str += "]"
        if i < array_length(processed_camSwitches) - 1
			json_str += ","
        json_str += "\n"
    }
    json_str += "  ],\n";
	
	json_str += "  \"events\": []\n"
	json_str += "}"

	var file = file_text_open_write(leveldirectory)
	file_text_write_string(file, json_str)
	file_text_close(file)
}