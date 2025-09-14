if(irandom(100) <= drop_chance){
	var drop = drop_list[irandom(array_length(drop_list)-1)];
	instance_create_layer(x + 16, y + 16, "Walls", drop);
}