if !surface_exists(global.mGP_hudSurface)
	global.mGP_hudSurface = surface_create(global.gameSizeW, global.gameSizeH)
surface_set_target(global.mGP_hudSurface)
draw_clear_alpha(c_black, 0)
if timer > 0 && sprite_exists(countdownspr)
	draw_sprite_ext(countdownspr,0,global.gameSizeW/2,global.gameSizeH/2,1,1,0,c_white,countdownalpha)
with obj_staticStrum
	sprw_draw(x, y, 0.75 * image_xscale, 0.75 * image_yscale)
with obj_arrowHold
	sprw_draw(x + 42, y, 0.75 * image_xscale, (endpart ? 0.75 : ((global.mGP_speed/1.45)/3)*0.875) * image_yscale)
with obj_arrow
	sprw_draw(x, y, 0.75 * image_xscale, 0.75 * image_yscale)
with obj_arrowSplashes
	sprw_draw(x, y, image_xscale, image_yscale)
with obj_healthBar
{
	var bar_width = 591 * (clamp(lerphealth, -0.01, 2) / 2)
	draw_rectangle_colour(x, y, x + 600, y + 20, c_black, c_black, c_black, c_black, false)
	draw_rectangle_colour(x + 5, y + 5, x + 595, y + 15, c_lime, c_lime, c_lime, c_lime, false)
	draw_rectangle_colour(x + 5, y + 5, x + 595 - bar_width, y + 15, c_red, c_red, c_red, c_red, false)
	var iconscale = global.mGP_iconZoom
	var iconoffset = ((iconscale-1)*1.05)+1
	var ifBFnearDeath = global.mGP_health < 0.4
	var ifDADnearDeath = global.mGP_health > 1.6
	
	gpu_set_texfilter(iconBFispixel)
	draw_sprite_part_ext(iconBFspr, 0, ifBFnearDeath ? iconDADwidth/2 : 0, 0, iconDADwidth/2, iconBFheight, (x + 595 - bar_width) + (118 * iconoffset), y - (65 * iconscale), -iconscale, iconscale, c_white, 1)
	gpu_set_texfilter(iconDADispixel)
	draw_sprite_part_ext(iconDADspr, 0, ifDADnearDeath ? iconDADwidth/2 : 0, 0, iconDADwidth/2, iconDADheight, (x + 595 - bar_width) - (118 * iconoffset), y - (65 * iconscale), iconscale, iconscale, c_white, 1)
	gpu_set_texfilter(false)
	draw_set_alpha(1)
	draw_set_font(fnt_score)
	draw_set_halign(0)
	draw_set_valign(0)
	var txt = $"Score : {global.mGP_score} | Misses : {global.mGP_misses}"
	var x_offset = text_x
	var y_offset = text_y
	var offset = 2
	var xscale = text_image_xscale
	var yscale = text_image_yscale
	var rot = 0
	draw_set_halign(1)
	draw_set_colour(c_black)
	draw_text_transformed(x_offset - offset, y_offset, txt, xscale, yscale, rot)
	draw_text_transformed(x_offset + offset, y_offset, txt, xscale, yscale, rot)
	draw_text_transformed(x_offset, y_offset - offset, txt, xscale, yscale, rot)
	draw_text_transformed(x_offset, y_offset + offset, txt, xscale, yscale, rot)
	draw_text_transformed(x_offset - offset, y_offset - offset, txt, xscale, yscale, rot)
	draw_text_transformed(x_offset + offset, y_offset - offset, txt, xscale, yscale, rot)
	draw_text_transformed(x_offset - offset, y_offset + offset, txt, xscale, yscale, rot)
	draw_text_transformed(x_offset + offset, y_offset + offset, txt, xscale, yscale, rot)
	draw_set_colour(c_white)
	draw_text_transformed(x_offset, y_offset, txt, xscale, yscale, rot)
	draw_set_halign(0)
	gpu_set_texfilter(true)
}
surface_reset_target()

if !surface_exists(global.mGP_hudSurface_u8)
	global.mGP_hudSurface_u8 = surface_create(global.gameSizeW, global.gameSizeH, surface_rgba8unorm)
surface_set_target(global.mGP_hudSurface_u8)
draw_clear_alpha(c_black,0)
draw_surface(global.mGP_hudSurface,0,0)
surface_reset_target()