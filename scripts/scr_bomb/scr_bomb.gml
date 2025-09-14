function put_bomb(_x, _y, instance_that_put_the_bomb, strength){
	var place_bomb_cell_x = (round(_x/32) * 32) + 16
	var place_bomb_cell_y = (round(_y/32) * 32) + 16
	var bomb = instance_create_layer(place_bomb_cell_x, place_bomb_cell_y, "Bombs", obj_bomb);
	with(bomb){
		if(place_meeting(place_bomb_cell_x, place_bomb_cell_y, obj_bomb)){
			instance_destroy(bomb);
			exit;
		}
	}
	bomb.from = instance_that_put_the_bomb;
	bomb.strength = strength;
	instance_that_put_the_bomb.available_bombs--;
}

function create_explosion(strength){
	// Middle Explosion
	instance_create_layer(x, y, "Bombs", obj_explosion);
	// Rigth Explosions
	for(var i = 1; i<=strength; i++){
		if(place_meeting(x + (i*32), y, obj_destroyable_wall)){
			with (instance_place(x + (i*32), y, obj_destroyable_wall)) instance_destroy();
			instance_create_layer(x + (i*32), y, "Bombs", obj_explosion);
			break;
		}
		if(place_meeting(x + (i*32), y, obj_wall)) break;
		instance_create_layer(x + (i*32), y, "Bombs", obj_explosion);
	}
	// Left Explosions
	for(var i = 1; i<=strength; i++){
		if(place_meeting(x - (i*32), y, obj_destroyable_wall)){
			with (instance_place(x - (i*32), y, obj_destroyable_wall)) instance_destroy();
			instance_create_layer(x - (i*32), y, "Bombs", obj_explosion);
			break;
		}
		if(place_meeting(x - (i*32), y, obj_wall)) break;
		instance_create_layer(x - (i*32), y, "Bombs", obj_explosion);
	}
	// Up Explosions
	for(var i = 1; i<=strength; i++){
		if(place_meeting(x, y + (i*32), obj_destroyable_wall)){
			with (instance_place(x, y + (i*32), obj_destroyable_wall)) instance_destroy();
			instance_create_layer(x, y + (i*32), "Bombs", obj_explosion);
			break;
		}
		if(place_meeting(x, y + (i*32), obj_wall)) break;
		instance_create_layer(x, y + (i*32), "Bombs", obj_explosion);
	}
	// Down Explosions
	for(var i = 1; i<=strength; i++){
		if(place_meeting(x, y - (i*32), obj_destroyable_wall)){
			with (instance_place(x, y - (i*32), obj_destroyable_wall)) instance_destroy();
			instance_create_layer(x, y - (i*32), "Bombs", obj_explosion);
			break;
		}
		if(place_meeting(x, y - (i*32), obj_wall)) break;
		instance_create_layer(x, y - (i*32), "Bombs", obj_explosion);
	}
}

function draw_bomb_place_position(){
	// modificar para multiplayer
	var player = instance_find(obj_player, 0);
	
	var place_bomb_cell_x = (round(player.x/32) * 32) + 16;
	var place_bomb_cell_y = (round(player.y/32) * 32) + 16;
	
	var _image_index = floor(get_timer()/100000)
	draw_sprite_ext(spr_bomb_place_indicator, _image_index, place_bomb_cell_x, place_bomb_cell_y, 1, 1, 0, c_white, 1);
}