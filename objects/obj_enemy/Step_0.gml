var found = false;
var destiny_x;
var destiny_y;
if(dead) state = ENEMY_STATE.BYE;
switch(state){
	case ENEMY_STATE.SEARCH_BOMB_PLACE:
		found = enemy_search_bomb_place2(x, y, bomb_strength, path);
		if(found == -1) {
			state = ENEMY_STATE.SEARCH_SAFE_PLACE;
			break;
		}
		destiny = found;
		state = ENEMY_STATE.MOVE_BOMB;
		break;
	case ENEMY_STATE.SEARCH_SAFE_PLACE:
		found = enemy_search_safe_place(x, y);
		if(found  == -1) {
			state = ENEMY_STATE.BYE;
			break;
		}
		destiny = found;
		state = ENEMY_STATE.MOVE_HIDE;
		break;
	case ENEMY_STATE.PUT_BOMB:
		put_bomb(x - 16, y - 16, self, bomb_strength);
		alarm_set(0, game_get_speed(gamespeed_fps)*wait_time_max);
		state = ENEMY_STATE.MOVE_HIDE;
		break;
	case ENEMY_STATE.MOVE_BOMB: // Implementa
		destiny_x = destiny[0].x * 32 + 16;
		destiny_y = destiny[0].y * 32 + 16;
		if(round(x) == destiny_x and round(y) == destiny_y) {
			state = ENEMY_STATE.PUT_BOMB;
			array_shift(destiny);
			break;
		}
		if(path_index == -1){
			var can_reach = mp_grid_path(global.grid, path, x, y, destiny[0].x * 32 + 16, destiny[0].y * 32 + 16, true);
			if(not can_reach){
				state = ENEMY_STATE.SEARCH_SAFE_PLACE;
				break;
			}
			path_start(path, spd, path_action_stop, true);
		}
		break;
	case ENEMY_STATE.MOVE_HIDE: // Implementa
		destiny_x = destiny[0].x * 32 + 16;
		destiny_y = destiny[0].y * 32 + 16;
		if(round(x) == destiny_x and round(y) == destiny_y) {
			state = ENEMY_STATE.WAIT;
			break;
		}
		if(path_index == -1){
			mp_grid_path(global.grid, path, x, y, destiny[0].x * 32 + 16, destiny[0].y * 32 + 16, true);
			path_start(path, spd, path_action_stop, true);
		}
		break;
	case ENEMY_STATE.WAIT:
		if(alarm_get(0) <= 0) state = ENEMY_STATE.SEARCH_BOMB_PLACE;
		break;
	case ENEMY_STATE.BYE:
		path_end();
		break;
}