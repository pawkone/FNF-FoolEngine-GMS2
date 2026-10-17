var _shd = -1
var camx = (-scroll[0]+1)*(global.mGP_gameX-global.gameSizeW/2)
var camy = (-scroll[1]+1)*(global.mGP_gameY-global.gameSizeH/2)


if (shader != -4) {_shd = shader_current();shader_set(shader)}
if (blendmode != bm_normal) gpu_set_blendmode(blendmode)
if (!texfilter) gpu_set_texfilter(false)

draw_sprite_ext(sprite_index,image_index,x+camx,y+camy,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if (shader != -4) shader_set(_shd)
if (blendmode != bm_normal) gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_inv_src_alpha)
if (!texfilter) gpu_set_texfilter(true)