if iconBFsprOLD != iconBFspr
{
	iconBFsprOLD = iconBFspr
	iconDADwidth = sprite_get_width(iconDADspr)
	iconDADheight = sprite_get_height(iconDADspr)
	iconDADispixel = !string_ends_with(global.mGP_charDad, "-pixel")
}
if iconDADsprOLD != iconDADspr
{
	iconDADsprOLD = iconDADspr
	iconDADwidth = sprite_get_width(iconDADspr)
	iconDADheight = sprite_get_height(iconDADspr)
	iconDADispixel = !string_ends_with(global.mGP_charDad, "-pixel")
}

if global.mGP_score != oldScore
{
	oldScore = global.mGP_score
	text_image_xscale = 1.1
	text_image_yscale = 1.1
}

text_image_xscale = lerp(text_image_xscale, 1, 0.175 * global.fpsMult)
text_image_yscale = lerp(text_image_yscale, 1, 0.175 * global.fpsMult)

lerphealth = lerp(lerphealth, global.mGP_health, 0.175 * global.fpsMult)
if abs(lerphealth - global.mGP_health) < 0.005
	lerphealth = global.mGP_health