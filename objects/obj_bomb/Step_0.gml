if(!place_meeting(x, y, from) and wall == noone){
	wall = instance_create_layer(x - 16, y - 16, "Walls", obj_wall);
	wall.image_alpha = 0;
	mp_grid_add_instances(global.grid, wall, false);
}