if(dead) draw_set_alpha(0.3);
draw_self();
draw_text(x + 16, y - 16, states[string(state)])
if(!dead) draw_path(path, x, y, true);
draw_set_alpha(1);