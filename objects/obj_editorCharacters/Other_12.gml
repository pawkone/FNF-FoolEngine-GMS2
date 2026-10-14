selected = buttonslimit
things = ["New Char", "Save Char", "Select Char", "Make Anim", "Remove Anim", "", "Make Ghost", "Remove Ghost"]
for (var i = 0; i < array_length(editorchar_animations); i++)
	array_push(things, editorchar_animations[i].name)
if array_length(things) > buttonslimit
	sprw_play(things[buttonslimit], true)