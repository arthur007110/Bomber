event_inherited();

enum ENEMY_STATE {
	SEARCH_BOMB_PLACE,
	SEARCH_SAFE_PLACE,
	PUT_BOMB,
	MOVE_BOMB,
	MOVE_HIDE,
	BYE
}

destiny = {x: 0, y: 0}

state = SEARCH_BOMB_PLACE;

/*

	Procurar local para colocar bomba
	Colocar bomba
	Se esconder
	

*/

