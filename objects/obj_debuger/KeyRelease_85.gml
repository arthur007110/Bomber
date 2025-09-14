if(global.debug){
	for (var i = 0; i < instance_number(obj_destroyable_wall); ++i)
	{
	    var wall = instance_find(obj_destroyable_wall,i);
		instance_destroy(wall);
	}
}