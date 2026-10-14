if image_alpha > 0
{
	if paused
	{
		if sprite_exists(spr[0])
			draw_sprite_stretched(spr[0],0,0,0,global.gameSizeW,global.gameSizeH)
		try{draw_surface_ext(global.mGP_hudSurface, global.mGP_hudX, global.mGP_hudY, global.mGP_hudZoom, global.mGP_hudZoom, global.mGP_hudAngle, c_white, global.mGP_hudAlpha)}
		catch(e){if sprite_exists(spr[1]) draw_sprite_ext(spr[1],0,global.mGP_hudX, global.mGP_hudY, global.mGP_hudZoom, global.mGP_hudZoom, global.mGP_hudAngle, c_white, global.mGP_hudAlpha)}
	}
	draw_set_alpha(0.75 * image_alpha)
	draw_set_colour(c_black)
	draw_rectangle(0,0,global.gameSizeW,global.gameSizeH,false)
	draw_set_colour(c_white)
	draw_set_alpha(image_alpha)
	draw_set_halign(2)
	draw_set_valign(2)
	draw_set_font(fnt_score)
	var _txt = string_concat("Song: ", global.mGP_name)
	draw_text_transformed(global.gameSizeW - 25, 55, _txt, 0.5, 0.5, 0)
	draw_set_halign(0)
	draw_set_valign(0)
    var total_items = array_length(text)
    var center_y = global.gameSizeH / 2
    for (var i = 0; i < total_items; i++)
    {
        draw_set_alpha((select == i ? 1 : 0.5) * image_alpha)
		var _x = ((-y / 5 + 30 + i * 30)/2) + 50
        var _y = (center_y + 150 * i - y) - 50
        draw_text_boldfont(_x, _y, text[i])
    }
    draw_set_alpha(1)
}