with(other){
	if(max_bombs < bombs_amount_limit){
		max_bombs += 1;
		available_bombs += 1;
	}
}

instance_destroy();