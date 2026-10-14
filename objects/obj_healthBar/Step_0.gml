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

lerphealth = lerp(lerphealth, global.mGP_health, 0.175)
if abs(lerphealth - global.mGP_health) < 0.005
	lerphealth = global.mGP_health