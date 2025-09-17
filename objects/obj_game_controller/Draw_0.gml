draw_set_alpha(0.5);
mp_grid_draw(global.grid);
draw_set_alpha(1);

function draw_cells(){
	for(var i = 0; i < room_height div 32; i++){
		for(var j = 0; j < room_width div 32; j++){
			var _x = j * 32 + 16;
			var _y = i * 32 + 16;
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_font(fnt_debug);
			draw_text(_x, _y, "("+string(j)+","+string(i)+")");
			
			draw_set_halign(-1);
			draw_set_valign(-1);
			draw_set_font(-1);
		}
	}
}

//draw_cells();