function set_debugger(player){
	var debugger = instance_find(obj_debuger, 0);
	if(!debugger){
		debugger = instance_create_layer(0, 0, "Instances", obj_debuger);
	}
	
	debug_player(debugger, player);
}

function debug_player(debugger, player){
	if(dbg_view_exists(debugger.player_view)) exit;
	var player_view = dbg_view("Player", false);
	debugger.player_view = player_view;
	dbg_section("Position");
	dbg_text_input(ref_create(player, "x"));
	dbg_text_input(ref_create(player, "y"));
	dbg_section("Other");
	dbg_slider_int(ref_create(player, "spd"), 2, 4.5, "Speed", 0.5);
	dbg_slider_int(ref_create(player, "max_bombs"), 1, 5, "Max Bombs", 1);
	dbg_slider_int(ref_create(player, "available_bombs"), 1, 5, "Available Bombs", 1);
	dbg_slider_int(ref_create(player, "bomb_strength"), 1, 5, "Bomb Strength", 1);
}