camera_set_view_size(view_camera[0], global.view_witdh, global.view_height);

if (instance_exists(view_target)) {
    var _x1 = view_target.x - global.view_witdh / 2;
    var _y1 = view_target.y - global.view_height / 2;

   _x1 = clamp(_x1, 0, room_width - global.view_witdh);
   _y1 = clamp(_y1, 0, room_height - global.view_height);
   
   var _cx = camera_get_view_x(view_camera[0]);
   var _cy = camera_get_view_y(view_camera[0]);

    camera_set_view_pos(view_camera[0], lerp(_cx, _x1, view_spd), lerp(_cy, _y1, view_spd));
}
