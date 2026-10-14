toggle = 0
items = []
var _file_name = file_find_first(global.assetsfolder + "sounds/hitnote/*", fa_directory)
while _file_name != ""
{
	array_push(items, _file_name)
	_file_name = file_find_next()
}
array_sort(items, true)
file_find_close()

select = array_find_index(items, function(_e,_i){return _e == global.mS_hitsoundName})

event_user(0)