chance_to_destroy_walls = 10;

function destroy_random_walls(){
	for (var i = 0; i < instance_number(obj_destroyable_wall); ++i)
	{
		if(chance_of(chance_to_destroy_walls, 100)){
			var wall = instance_find(obj_destroyable_wall,i);
			instance_destroy(wall, false);
		}
	}
}

destroy_random_walls();