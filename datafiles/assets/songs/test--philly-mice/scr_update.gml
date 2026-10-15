// Modchart example! by pawkone

var _mult = 1 // The intensity for the modchart
for (var i = 0; i < 8; i++)
{
	// Jiggly notes on x axis or something idk, aligned to the beat
	var _x = sin((global.mGP_curTime + i * 243 + global.mGP_curBeat * 232) / 132) * 16 * _mult
	
	// Make notes "bounce" with song's BPM, weeee
	var _y = (32 + -abs(sin(((global.mGP_curTime / 1000) / (60 / global.mGP_bpm)) * 3.141592653589793280)) * 64)*_mult
	// Jiggly notes AGAIN but vertically this time
	_y += cos((global.mGP_curTime + i * 243 + global.mGP_curBeat * 232) / 132) * 16 * _mult
	
	// Set positions smoothly(?) (with "lerp")
	global.mGP_strumpos[i][0] = lerp(global.mGP_strumpos[i][0], global.mGP_strumposOG[i][0] + _x, 0.3 * global.fpsMult)
	global.mGP_strumpos[i][1] = lerp(global.mGP_strumpos[i][1], global.mGP_strumposOG[i][1] + _y, 0.3 * global.fpsMult)

	// ^ Remember to always use "global.fpsMult", its measured as a multipler of "60 fps code"
	// E.G. if the game is 30 fps, then its equal to around "2"
	// E.G. if the game is 240 fps, then its equal to around "0.25"

	// DONT USE DELTA_TIME, JUST DONT PLEASE
}