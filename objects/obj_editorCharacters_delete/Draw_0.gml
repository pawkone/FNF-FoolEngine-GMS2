draw_set_alpha(0.5)
draw_set_colour(c_black)
draw_rectangle(0,0,1280,720,false)
draw_set_alpha(1)

var item_x1 = 175
var item_y1 = 175
var item_x2 = 1280-175
var item_y2 = 720-175
draw_set_colour(c_grey)
draw_rectangle(item_x1, item_y1, item_x2, item_y2, false)
draw_set_colour(c_black)
draw_rectangle(item_x1 + 2, item_y1 + 2, item_x2 - 2, item_y2 - 2, true)
draw_rectangle(item_x1 + 1.5, item_y1 + 1.5, item_x2 - 1.5, item_y2 - 1.5, true)
draw_rectangle(item_x1 + 1, item_y1 + 1, item_x2 - 1, item_y2 - 1, true)
draw_rectangle(item_x1 + 0.5, item_y1 + 0.5, item_x2 - 0.5, item_y2 - 0.5, true)
draw_rectangle(item_x1, item_y1, item_x2, item_y2, true)
draw_set_colour(c_white)
draw_set_halign(1)
draw_set_valign(1)
draw_text_transformed(1280/2, 720/2, "Are you sure want to DELETE:\n \n\n\n\n Yes - Enter / Return\nNo - Backspace / Escape", 0.75, 0.75, 0)
draw_text_transformed(1280/2, 720/2.1, obj_editorCharacters.things[obj_editorCharacters.selected], 2, 2, 0)
draw_set_halign(0)
draw_set_valign(0)