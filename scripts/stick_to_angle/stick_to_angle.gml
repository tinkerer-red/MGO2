/// @description stick_to_angle(object, xoffset, yoffset, angleoffset)
/// @param object
/// @param  xoffset
/// @param  yoffset
/// @param  angleoffset
function stick_to_angle(_obj, _xoff, _yoff, _angleoff) {
	var dis = point_distance(_obj.x, _obj.y, _obj.x+_xoff, _obj.y+_yoff);
	var dir = point_direction(_obj.x, _obj.y, _obj.x+_xoff, _obj.y+_yoff);
	x = _obj.x+lengthdir_x(dis, dir+_obj.image_angle);
	y = _obj.y+lengthdir_y(dis, dir+_obj.image_angle);
	image_angle = _obj.image_angle+_angleoff;
}
