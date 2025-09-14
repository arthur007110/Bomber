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

cell_size = 32;
cells_h = room_width div cell_size;
cells_v = room_height div cell_size;

grid = mp_grid_create(0, 0, cells_h, cells_v, cell_size, cell_size);
mp_grid_add_instances(grid, obj_wall, false);