function gmlscr_read(path)
{
	if !file_exists(path) //stay slient, cuz no error
		return false
	try
	{
		var __str = ""
		var __file = file_text_open_read(path)
		while (!file_text_eof(__file))
		{
			__str += gmlscr_formatline(file_text_read_string(__file))
			file_text_readln(__file)
		}
		file_text_close(__file)
		live_execute_string(__str)
		show_debug_message("LOADED Script: " + path)
		return true
	}
	catch(e)
	{
		show_debug_message("FAILED Loading Script: " + path + "  ERROR BELOW vvv")
		show_debug_message(e.stacktrace)
		return false
	}
}
function gmlscr_read_snippet(path)
{
	if !file_exists(path) //stay slient, cuz no error
		return -4
	try
	{
		var __str = ""
		var __file = file_text_open_read(path)
		while (!file_text_eof(__file))
		{
			__str += gmlscr_formatline(file_text_read_string(__file))
			file_text_readln(__file)
		}
		file_text_close(__file)
		var _s = live_snippet_create(__str)
		show_debug_message("LOADED Script: " + path)
		return _s
	}
	catch(e)
	{
		show_debug_message("FAILED Loading Script: " + path + "  ERROR BELOW vvv")
		show_debug_message(e.stacktrace)
		return -4
	}
}
function gmlscr_formatline(line_str)
{
	if string_starts_with(line_str, "//")
		return ""
	var comment_pos = string_pos("//", line_str)
	if comment_pos > 0
		return string_copy(line_str, 1, comment_pos - 1)
	else
		return line_str
}