draw_set_halign(0)
draw_set_valign(0)
draw_set_font(-1)
draw_set_colour(c_white)
if !sprw_exists(id)
{
	draw_set_alpha(image_alpha)
	if intro
		draw_text(x,y,"deathStart")
	else if !comfirmed
		draw_text(x,y,"deathLoop")
	else if comfirmed
		draw_text(x,y,"deathEnd")
	draw_set_alpha(1)
	exit
}
sprw_draw(x, y, sprw_scale[0] * image_xscale, sprw_scale[1] * image_yscale, image_angle, image_blend, image_alpha)