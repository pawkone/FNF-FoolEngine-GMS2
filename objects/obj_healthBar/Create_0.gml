y = (global.gameSizeH-80)
x = (global.gameSizeW/2 - 600/2)
lerphealth = global.mGP_health

if file_exists(assetsfolder + "images/healthicons/" + global.mGP_charBF + ".png")
	iconBFspr = spritepool_load(assetsfolder + "images/healthicons/" + global.mGP_charBF + ".png")
else
	iconBFspr = spritepool_load(assetsfolder + "images/healthicons/face.png")
if file_exists(assetsfolder + "images/healthicons/" + global.mGP_charDad + ".png")
	iconDADspr = spritepool_load(assetsfolder + "images/healthicons/" + global.mGP_charDad + ".png")
else
	iconDADspr = spritepool_load(assetsfolder + "images/healthicons/face.png")
iconBFsprOLD = iconBFspr
iconDADsprOLD = iconDADspr

iconBFwidth = sprite_get_width(iconBFspr)
iconBFheight = sprite_get_height(iconBFspr)
iconDADwidth = sprite_get_width(iconDADspr)
iconDADheight = sprite_get_height(iconDADspr)
iconBFispixel = !string_ends_with(global.mGP_charBF, "-pixel")
iconDADispixel = !string_ends_with(global.mGP_charDad, "-pixel")