if(wall == noone) exit;
mp_grid_clear_cell(global.grid, wall.x div 32, wall.y div 32);
instance_destroy(wall);