var found = false;
switch(state){
	case ENEMY_STATE.SEARCH_BOMB_PLACE:
		found = enemy_search_bomb_place();
		if(not found) {
			state = ENEMY_STATE.SEARCH_SAFE_PLACE;
			break;
		}
		destiny = found;
		state = ENEMY_STATE.MOVE_BOMB;
		break;
	case ENEMY_STATE.SEARCH_SAFE_PLACE:
		found = enemy_search_safe_place();
		if(not found) {
			state = ENEMY_STATE.BYE;
			break;
		}
		destiny = found;
		state = ENEMY_STATE.MOVE_HIDE;
		break;
	case ENEMY_STATE.PUT_BOMB:
		put_bomb(x, y, self, bomb_strength);
		state = ENEMY_STATE.SEARCH_SAFE_PLACE;
		break;
	case ENEMY_STATE.MOVE_BOMB: // Implementa
		if(x == destiny.x and y == destiny.y) {
			state = ENEMY_STATE.PUT_BOMB;
			break;
		}
		enemy_move();
		break;
	case ENEMY_STATE.MOVE_HIDE: // Implementa
		if(x == destiny.x and y == destiny.y) {
			state = ENEMY_STATE.WAIT;
			alarm_set(0, game_get_speed(gamespeed_fps)*wait_time_max);
			break;
		}
		enemy_move();
		break;
	case ENEMY_STATE.WAIT:
		if(alarm_get(0) == 0) state = ENEMY_STATE.SEARCH_BOMB_PLACE;
		break;
}