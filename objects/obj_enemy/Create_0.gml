event_inherited();

enum ENEMY_STATE {
	SEARCH_BOMB_PLACE,
	SEARCH_SAFE_PLACE,
	PUT_BOMB,
	MOVE_BOMB,
	MOVE_HIDE,
	WAIT,
	BYE
}

destiny = {x: 0, y: 0}
wait_time = 0;
wait_time_max = 1.5;
state = SEARCH_BOMB_PLACE;
path = path_add();

/*

	Procurar local para colocar bomba
	Colocar bomba
	Se esconder
	

*/

