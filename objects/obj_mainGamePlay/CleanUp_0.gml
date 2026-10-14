application_surface_draw_enable(true)
if snipscr_update != -4 live_snippet_destroy(snipscr_update)
if snipscr_updatepost != -4 live_snippet_destroy(snipscr_updatepost)
var __scrpath = assetsfolder + "songs/" + global.mGP_name + "/scr_exit.gml"
gmlscr_read(__scrpath)