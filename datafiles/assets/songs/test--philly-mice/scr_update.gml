var _mult = 1
for (var i = 0; i < 8; i++)
{
	var _x = sin((global.mGP_curTime + i * 243 + global.mGP_curBeat * 232) / 132) * 16 * _mult
	
	var _y = (32 + -abs(sin(((global.mGP_curTime / 1000) / (60 / global.mGP_bpm)) * 3.141592653589793280)) * 64)*_mult
	_y += cos((global.mGP_curTime + i * 243 + global.mGP_curBeat * 232) / 132) * 16 * _mult
	
	global.mGP_strumpos[i][0] = lerp(global.mGP_strumpos[i][0], global.mGP_strumposOG[i][0] + _x, 0.3 * global.fpsMult)
	global.mGP_strumpos[i][1] = lerp(global.mGP_strumpos[i][1], global.mGP_strumposOG[i][1] + _y, 0.3 * global.fpsMult)
}