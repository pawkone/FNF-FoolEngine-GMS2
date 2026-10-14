if snipscr_updatepost != -4
	live_snippet_call(snipscr_updatepost)
if global.mGP_health > 2
	global.mGP_health = 2
if global.mGP_health <= 0
{
	with obj_characterBF
		persistent = true
	room_goto(rm_subDeath)
}