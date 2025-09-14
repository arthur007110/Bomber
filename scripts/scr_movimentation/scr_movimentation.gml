function get_movimentation_vector(){
    var up = keyboard_check(ord("W"));
    var down = keyboard_check(ord("S"));
    var left = keyboard_check(ord("A"));
    var right = keyboard_check(ord("D"));
    
    return {x: right-left, y: down-up}
}

function move_instance(instance, speed, _direction, collision = noone){
    var further_step_x = instance.x + speed*_direction.x;
    var further_step_y = instance.y + speed*_direction.y;
    if(collision){
        if(place_meeting(further_step_x, instance.y, obj_wall)){
            while(!place_meeting(instance.x + _direction.x, instance.y, obj_wall)){
                instance.x += _direction.x;
            }
        } else if(place_meeting(instance.x, further_step_y, obj_wall)) {
            while(!place_meeting(instance.x, instance.y + _direction.y, obj_wall)){
                instance.y += _direction.y;
            }
        } else {
            instance.x = further_step_x;
            instance.y = further_step_y;
        }
    }else {
        instance.x = further_step_x;
        instance.y = further_step_y;
    }
    
}

function move_instance2(instance, _speed, _direction, collision = noone){
    var dir = point_direction(0, 0, _direction.x, _direction.y);
    if(abs(_direction.x) or abs(_direction.y)){ // tem movimento?
		var hspd = lengthdir_x(_speed, dir);
		var vspd = lengthdir_y(_speed, dir);
		if(collision){
			if(place_meeting(instance.x+hspd, instance.y, collision)) {
				while(!place_meeting(instance.x+sign(hspd), instance.y, collision)){
					x += sign(hspd);
				}
				hspd = 0;
			}
			if(place_meeting(instance.x, instance.y+vspd, collision)) {
				while(!place_meeting(instance.x, instance.y+sign(vspd), collision)){
					y += sign(vspd);
				}
				vspd = 0;
			}
		}
		instance.x += hspd;
		instance.y += vspd;
	}
    
}

function move_player(speed){
    var _direction = get_movimentation_vector();
    var player_instance = instance_find(obj_player, 0);
    move_instance2(player_instance, speed, _direction, obj_wall);
}