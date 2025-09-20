
/**
	This function returns a DS Grid that should be destroied after used
*/
function get_places(){
	var cell_size = 32;
	var _x = cell_size div 2;
	var _y = cell_size div 2;
	
	var cells_h = room_width div cell_size;
	var cells_v = room_height div cell_size;
	
	var places = ds_grid_create(cells_h, cells_v);
	
	var collision_checker = instance_create_layer(_x, _y, "Instances", obj_collision_checker);
	for(var i = 0; i < cells_v; i++){
		collision_checker.y = _y + (i*cell_size);
		for(var j = 0; j < cells_h; j++){
			collision_checker.x = _x + (j*cell_size);
			with(collision_checker){
				if(place_meeting(collision_checker.x, collision_checker.y, obj_destroyable_wall)){
					ds_grid_set(places, j, i, 2);
					continue;
				}
				else if(place_meeting(collision_checker.x, collision_checker.y, obj_wall)) ds_grid_set(places, j, i, 1);
				else ds_grid_set(places, j, i, 0);
			}
		}
	}
	instance_destroy(collision_checker);
	return places;
}

function debug_show_ds_grid(ds_grid){
	var str = "";
	function convert_to_icon(val){
		if(val == 1) return "◆"
		else if(val == 2) return "◈";
		else return "◇";
	}
	for(var i = 0; i < ds_grid_height(ds_grid); i++){
		for(var j = 0; j < ds_grid_width(ds_grid); j++){
			str += convert_to_icon(ds_grid_get(ds_grid, j, i)) + " ";
		}
		str += "\n";
	}
	show_message(str);
}

function get_safe_places(ds_grid){ // reimplementar
	var free = 0;
	var safe_places = [];
	for(var i = 0; i < ds_grid_height(ds_grid) -1; i++){
		for(var j = 0; j < ds_grid_width(ds_grid); j++){
			if(ds_grid_get(ds_grid, j, i) == free){
				// look right
				if(j < ds_grid_width(ds_grid) -1 and ds_grid_get(ds_grid, j + 1, i + 1) == free){
					// look up
					if(ds_grid_get(ds_grid, j + 1, i) == free){
						array_push(safe_places, [
							{x: j, y: i},
							{x: j+1, y: i+1}
						])
					}
					// look down
					if(ds_grid_get(ds_grid, j, i + 1) == free){
						array_push(safe_places, [
							{x: j, y: i},
							{x: j+1, y: i+1}
						])
					}
				}
				// look left
				if(j > 0 and ds_grid_get(ds_grid, j - 1, i + 1) == free){
					// look up
					if(ds_grid_get(ds_grid, j - 1, i) == free){
						array_push(safe_places, [
							{x: j, y: i},
							{x: j-1, y: i+1}
						])
					}
					// look down
					if(ds_grid_get(ds_grid, j, i + 1) == free){
						array_push(safe_places, [
							{x: j, y: i},
							{x: j-1, y: i+1}
						])
					}
				}
			}
		}
	}
	return safe_places;
}

function enemy_search_safe_place(_x, _y) {
	// convert x and y to cells
	_x = _x div 32;
	_y = _y div 32;
	var places = get_places();
	var safe_places = get_safe_places(places);
	ds_grid_destroy(places);
	// get nearest
	var distances = [];
	for(var i = 0; i < array_length(safe_places); i++){
		var distance = point_distance(_x, _y, safe_places[i][0].x, safe_places[i][0].y);
		array_push(distances, distance);
	}
	var distances_sorted = [];
	array_copy(distances_sorted, 0, distances, 0, array_length(distances));
	array_sort(distances_sorted, true);
	var element_index = array_get_index(distances, distances_sorted[0]);
	var nearest_safe_place = safe_places[element_index];
	return array_shuffle(nearest_safe_place);
}

function does_the_bomb_destroy_anything(bomb_x, bomb_y, bomb_strength, ds_grid){
	var look_up = true, look_down = true, look_left = true, look_rigth = true;
	
	function has_destoyable_direction(ds_grid, _x, _y, _direction, limit){
		var x_factor = lengthdir_x(1, _direction);
		var y_factor = lengthdir_y(1, _direction);
		for(var i = 1; i <= limit; i++){
			var cell = ds_grid_get(ds_grid, _x + (x_factor * i), _y + (y_factor * i));
			if(cell == 2) return true;
			if(cell == 1) return false;
		}
		return false;
	}
	var dir = 0;
	for(var i = 0; i < 4; i++){
		if(has_destoyable_direction(ds_grid, bomb_x, bomb_y, dir, bomb_strength)) return true;
		dir += 90;
	}
	return false;
}

function does_the_bomb_hit_this_place(bomb_x, bomb_y, bomb_strength, place){
	var hitted_places = [];
	
	if(place.x == bomb_x and place.y == bomb_y) return true;
	for(var i = 1; i <= bomb_strength; i++){
		if(place.x == bomb_x + i and place.y == bomb_y) return true;
		if(place.x == bomb_x - i and place.y == bomb_y) return true;
		if(place.x == bomb_x and place.y == bomb_y - i) return true;
		if(place.x == bomb_x and place.y == bomb_y + i) return true;
	}
	
	return false;
}

function get_free_places(ds_grid) {
	var free_places = [];
	
	for(var i = 0; i < ds_grid_height(ds_grid); i++){
		for(var j = 0; j < ds_grid_width(ds_grid); j++){
			if(ds_grid_get(ds_grid, j, i) == 0) array_push(free_places, {x: j, y: i});
		}
	}
	
	return free_places;
}

function get_random_free_place(ds_grid){
	var free_places = get_free_places(ds_grid);
	
	return free_places[irandom(array_length(free_places) - 1)];
}

function enemy_search_bomb_place2(_x, _y, bomb_strength, path){
	var places = get_places();
	var tentativas = 20;
	// procurar locais válidos
	for(var i = 0; i < tentativas; i++){
		// procurar local vazio aleatório
		var bomb_place = get_random_free_place(places);
		var _x2 = bomb_place.x *32 + 16;
		var _y2 = bomb_place.y *32 + 16;
		// verificar se há um caminho válido até o local encontrado
		var valid_path = mp_grid_path(global.grid, path, _x, _y, _x2, _y2, false);
		if(not valid_path) {
			if(i == tentativas - 1) return -1;
			continue;
		}
		// verificar se colocar uma bomba neste primeiro local, se há algum outro ponto em que possa me esconder
		var tentativas_2 = 20;
		var hide_place;
		for(var j = 0; j < tentativas_2; j++){
			hide_place = get_random_free_place(places);
			_x2 = hide_place.x *32 + 16;
			_y2 = hide_place.y *32 + 16;
			valid_path = mp_grid_path(global.grid, path, _x, _y, _x2, _y2, false);
			if(not valid_path) {
				if(j == tentativas_2 - 1) return -1;
				continue;
			}
			if(not does_the_bomb_hit_this_place(bomb_place.x, bomb_place.y, bomb_strength, hide_place)) break;
		}
		// verificar se uma bomba irá explodir alguma parede se for posta neste local
		if(not does_the_bomb_destroy_anything(bomb_place.x, bomb_place.y, bomb_strength, places)){
			if(i == tentativas - 1) return -1;
			 continue;
		}
		// retorna as duas posições
		return [bomb_place, hide_place];
	}
	return -1;
}

function enemy_detect_obstructed_path(instance){
	// TORNAR CELL_SIZE UMA VARIÁVEL GLOBAL
	var cell_size = 32;
	with(instance){
		if (path_index != -1) {
		    var next_x = path_get_point_x(path_index, 1);
		    var next_y = path_get_point_y(path_index, 1);
		    // converte para posição de grid
		    var grid_x = (next_x div cell_size) * cell_size + cell_size div 2;
		    var grid_y = (next_y div cell_size) * cell_size + cell_size div 2;
		    if (position_meeting(grid_x, grid_y, obj_wall) || position_meeting(grid_x, grid_y, obj_bomb)) {
		        path_end();
		        state =  ENEMY_STATE.SEARCH_SAFE_PLACE;
		    }
		}
	}
	
}