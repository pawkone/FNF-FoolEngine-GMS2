debugui_checkbox(global.gameSizeW/2, 50, "gotooptions", false, "WIP GAME OPTIONS", 2, 2)
debugui_checkbox(global.gameSizeW/2, 100, "gotodebugmenu", false, "DEBUG MENU", 2, 2)
if alpha > 0
{
	draw_set_alpha(alpha)
	draw_rectangle(0,0,global.gameSizeW,global.gameSizeH,false)
	draw_set_alpha(1)
}