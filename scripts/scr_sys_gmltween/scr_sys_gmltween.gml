function gmltween_EaseLinear(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax * inputvalue / inputmax + outputmin
}
function gmltween_EaseInQuad(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax
	return outputmax * inputvalue * inputvalue + outputmin
}
function gmltween_EaseOutQuad(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax
	return -outputmax * inputvalue * (inputvalue - 2) + outputmin
}
function gmltween_EaseInOutQuad(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax * 0.5
	if inputvalue < 1
		return outputmax * 0.5 * inputvalue * inputvalue + outputmin
	return outputmax * -0.5 * (--inputvalue * (inputvalue - 2) - 1) + outputmin
}

function gmltween_EaseInCubic(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax * power(inputvalue/inputmax, 3) + outputmin
}
function gmltween_EaseOutCubic(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax * (power(inputvalue/inputmax - 1, 3) + 1) + outputmin
}
function gmltween_EaseInOutCubic(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax * 0.5
	if inputvalue < 1
		return outputmax * 0.5 * power(inputvalue, 3) + outputmin
	return outputmax * 0.5 * (power(inputvalue - 2, 3) + 2) + outputmin
}
function gmltween_EaseInQuart(inputvalue, outputmin, outputmax, inputmax)
{
	return outputmax * power(inputvalue / inputmax, 4) + outputmin
}
function gmltween_EaseOutQuart(inputvalue, outputmin, outputmax, inputmax)
{
	return -outputmax * (power(inputvalue / inputmax - 1, 4) - 1) + outputmin
}
function gmltween_EaseInOutQuart(inputvalue, outputmin, outputmax, inputmax)
{
	inputvalue /= inputmax * 0.5
	if inputvalue < 1
		return outputmax * 0.5 * power(inputvalue, 4) + outputmin
	inputvalue -= 2
	return outputmax * -0.5 * (power(inputvalue, 4) - 2) + outputmin
}
function gmltween_EaseInQuint(inputvalue, outputmin, outputmax, inputmax)
{
	return outputmax * power(inputvalue / inputmax, 5) + outputmin
}
function gmltween_EaseOutQuint(inputvalue, outputmin, outputmax, inputmax)
{
	return outputmax * (power(inputvalue / inputmax - 1, 5) + 1) + outputmin
}
function gmltween_EaseInOutQuint(inputvalue, outputmin, outputmax, inputmax)
{
	inputvalue /= inputmax * 0.5
	if inputvalue < 1
		return outputmax * 0.5 * power(inputvalue, 5) + outputmin
	inputvalue -= 2
	return outputmax * 0.5 * (power(inputvalue, 5) + 2) + outputmin
}
function gmltween_EaseInSine(inputvalue, outputmin, outputmax, inputmax)
{
	return outputmax * (1 - cos(inputvalue / inputmax * (pi / 2))) + outputmin
}
function gmltween_EaseOutSine(inputvalue, outputmin, outputmax, inputmax)
{
	return outputmax * sin(inputvalue / inputmax * (pi / 2)) + outputmin
}
function gmltween_EaseInOutSine(inputvalue, outputmin, outputmax, inputmax)
{
	return outputmax * 0.5 * (1 - cos(pi * inputvalue / inputmax)) + outputmin
}
function gmltween_EaseInCirc(inputvalue, outputmin, outputmax, inputmax)
{
	inputvalue /= inputmax
	return outputmax * (1 - sqrt(1 - inputvalue * inputvalue)) + outputmin
}
function gmltween_EaseOutCirc(inputvalue, outputmin, outputmax, inputmax)
{
	inputvalue = inputvalue / inputmax - 1
	return outputmax * sqrt(1 - inputvalue * inputvalue) + outputmin
}
function gmltween_EaseInOutCirc(inputvalue, outputmin, outputmax, inputmax)
{
	inputvalue /= inputmax * 0.5
	if inputvalue < 1
		return outputmax * 0.5 * (1 - sqrt(1 - inputvalue * inputvalue)) + outputmin
	inputvalue -= 2
	return outputmax * 0.5 * (sqrt(1 - inputvalue * inputvalue) + 1) + outputmin
}
function gmltween_EaseInExpo(inputvalue, outputmin, outputmax, inputmax)
{
	return outputmax * power(2, 10 * (inputvalue / inputmax - 1)) + outputmin
}
function gmltween_EaseOutExpo(inputvalue, outputmin, outputmax, inputmax)
{
	return outputmax * (-power(2, -10 * inputvalue / inputmax) + 1) + outputmin
}
function gmltween_EaseInOutExpo(inputvalue, outputmin, outputmax, inputmax)
{
	inputvalue /= inputmax * 0.5
	if inputvalue < 1
		return outputmax * 0.5 * power(2, 10 * (inputvalue - 1)) + outputmin
	inputvalue -= 1
	return outputmax * 0.5 * (-power(2, -10 * inputvalue) + 2) + outputmin
}
function gmltween_EaseInElastic(inputvalue, outputmin, outputmax, inputmax)
{
	var s = 1.70158
	var p = 0
	var a = outputmax
	if inputvalue == 0 || a == 0
		return outputmin
	inputvalue /= inputmax
	if inputvalue == 1
		return outputmin + outputmax
	if p == 0
		p = inputmax * 0.3
	if a < abs(outputmax)
	{
		a = outputmax
		s = p * 0.25
	}
	else
		s = p / (2 * pi) * arcsin(outputmax / a)
	inputvalue -= 1
	return -(a * power(2, 10 * inputvalue) * sin((inputvalue * inputmax - s) * (2 * pi) / p)) + outputmin
}
function gmltween_EaseOutElastic(inputvalue, outputmin, outputmax, inputmax)
{
	var s = 1.70158
	var p = 0
	var a = outputmax
	if inputvalue == 0 || a == 0
		return outputmin
	inputvalue /= inputmax
	if inputvalue == 1
		return outputmin + outputmax
	if p == 0
		p = inputmax * 0.3
	if a < abs(outputmax)
	{
		a = outputmax
		s = p * 0.25
	}
	else
		s = p / (2 * pi) * arcsin(outputmax / a)
	return a * power(2, -10 * inputvalue) * sin((inputvalue * inputmax - s) * (2 * pi) / p) + outputmax + outputmin
}

function gmltween_EaseInOutElastic(inputvalue, outputmin, outputmax, inputmax)
{
	var s = 1.70158
	var p = 0
	var a = outputmax
	if inputvalue == 0 || a == 0
		return outputmin
	inputvalue /= inputmax * 0.5
	if inputvalue == 2
		return outputmin + outputmax
	if p == 0
		p = inputmax * (0.3 * 1.5)
	if a < abs(outputmax)
	{
		a = outputmax
		s = p * 0.25
	}
	else
		s = p / (2 * pi) * arcsin(outputmax / a)
	if inputvalue < 1
	{
		inputvalue -= 1
		return -0.5 * (a * power(2, 10 * inputvalue) * sin((inputvalue * inputmax - s) * (2 * pi) / p)) + outputmin
	}
	inputvalue -= 1
	return a * power(2, -10 * inputvalue) * sin((inputvalue * inputmax - s) * (2 * pi) / p) * 0.5 + outputmax + outputmin
}
function gmltween_EaseInBack(inputvalue, outputmin, outputmax, inputmax)
{
	var s = 1.70158
	inputvalue /= inputmax
	return outputmax * inputvalue * inputvalue * ((s + 1) * inputvalue - s) + outputmin
}
function gmltween_EaseOutBack(inputvalue, outputmin, outputmax, inputmax)
{
	var s = 1.70158
	inputvalue = inputvalue / inputmax - 1
	return outputmax * (inputvalue * inputvalue * ((s + 1) * inputvalue + s) + 1) + outputmin
}
function gmltween_EaseInOutBack(inputvalue, outputmin, outputmax, inputmax)
{
	var s = 1.70158
	inputvalue = inputvalue / inputmax * 2
	if inputvalue < 1
	{
		s *= 1.525
		return outputmax * 0.5 * (inputvalue * inputvalue * ((s + 1) * inputvalue - s)) + outputmin
	}
	inputvalue -= 2
	s *= 1.525
	return outputmax * 0.5 * (inputvalue * inputvalue * ((s + 1) * inputvalue + s) + 2) + outputmin
}
function gmltween_EaseOutBounce(inputvalue, outputmin, outputmax, inputmax)
{
	inputvalue /= inputmax
	if inputvalue < 1 / 2.75
		return outputmax * 7.5625 * inputvalue * inputvalue + outputmin
	else if inputvalue < 2 / 2.75
	{
		inputvalue -= 1.5 / 2.75
		return outputmax * (7.5625 * inputvalue * inputvalue + 0.75) + outputmin
	}
	else if inputvalue < 2.5 / 2.75
	{
		inputvalue -= 2.25 / 2.75
		return outputmax * (7.5625 * inputvalue * inputvalue + 0.9375) + outputmin
	}
	else
	{
		inputvalue -= 2.625 / 2.75
		return outputmax * (7.5625 * inputvalue * inputvalue + 0.984375) + outputmin
	}
}
function gmltween_EaseInBounce(inputvalue, outputmin, outputmax, inputmax)
{
	return outputmax - gmltween_EaseOutBounce(inputmax - inputvalue, 0, outputmax, inputmax) + outputmin
}
function gmltween_EaseInOutBounce(inputvalue, outputmin, outputmax, inputmax)
{
	if inputvalue < inputmax * 0.5
	return gmltween_EaseInBounce(inputvalue * 2, 0, outputmax, inputmax) * 0.5 + outputmin
	return gmltween_EaseOutBounce(inputvalue * 2 - inputmax, 0, outputmax, inputmax) * 0.5 + outputmax * 0.5 + outputmin
}