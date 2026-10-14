resize2gamesize()
audio_stop_all()
alpha = 0
timer = 0
music = audio_play_sound(soundpool_load(global.assetsfolder + "music/title.ogg"), 10, true)
musicendID = soundpool_load(global.assetsfolder + "music/titleShoot.ogg")
bpm = 140
started = false
start_timer = 0
gotooptions = 0
gotodebugmenu = 0
x = global.gameSizeW/2
y = global.gameSizeH/2
image_xscale = 0.65
image_yscale = 0.65
sprite_index = spritepool_load(global.assetsfolder + "images/logobumpinj.png", 1, -1, -1)