script_text = @'stageObject_setDefaultZoom(0.65)
stageObject_char(900, 400, "bf")
stageObject_char(700, 430, "gf")
stageObject_char(600, 400, "dad")'
if global.mGP_stage != -4 && file_exists(assetsfolder + "stages/stage.stg")
	script_text = file_string(assetsfolder + "stages/stage.stg")
else
	global.mGP_stage = -4
camoffset = [0, 0]
bfspr = spritepool_load(assetsfolder + "images/editor/editor_stage_bf.png")
dadspr = spritepool_load(assetsfolder + "images/editor/editor_stage_dad.png")
gfspr = spritepool_load(assetsfolder + "images/editor/editor_stage_gf.png")
stage_create(script_text, obj_editorStages_bf, obj_editorStages_dad, obj_editorStages_gf)