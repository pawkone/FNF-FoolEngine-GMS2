if global.mGP_shader != -4
{
	shader_set(global.mGP_shader)
	if global.mGP_shaderScript != -4
		script_execute(global.mGP_shaderScript)
}

gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_inv_src_alpha)
draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, global.mGP_gameAlpha)
try
{
	var _data = video_draw()
	var _surface = _data[1]
	draw_surface_stretched(_surface, 0, 0, global.gameSizeW, global.gameSizeH)
}
catch(e){}

try{draw_surface_ext(global.mGP_hudSurface, global.mGP_hudX, global.mGP_hudY, global.mGP_hudZoom, global.mGP_hudZoom, global.mGP_hudAngle, c_white, global.mGP_hudAlpha)}
catch(e){}

shader_reset()