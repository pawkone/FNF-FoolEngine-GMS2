pausebuffer = 3
paused = true
select = 0
y = 250
image_alpha = 0
var _s = application_surface
spr[0] = sprite_create_from_surface(_s,0,0,surface_get_width(_s),surface_get_height(_s),false,false,0,0)
_s = global.mGP_hudSurface_u8
spr[1] = sprite_create_from_surface(_s,0,0,surface_get_width(_s),surface_get_height(_s),false,false,0,0)
instance_deactivate_all(true)
instance_activate_object(obj_globalHandler)
audio_pause_all()
audio_play_sound(global.sfx_mnu_scroll,1,false)
video_pause()