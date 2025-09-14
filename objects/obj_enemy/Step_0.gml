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
		put_bomb(); // Implementar
		state = ENEMY_STATE.SEARCH_SAFE_PLACE;
		break;
	case ENEMY_STATE.MOVE_BOMB: // Implementa
		break;
	case ENEMY_STATE.MOVE_HIDE: // Implementa
		break;
}