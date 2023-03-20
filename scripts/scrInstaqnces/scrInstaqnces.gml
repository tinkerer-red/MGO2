/// @param {real} x		The x position the object will be created at
/// @param {real} y		The y position the object will be created at
/// @param {object} obj	The object index of the object to create an instance of
/// @returns {instance} ID of the instance created
function instance_create(_x, _y, _obj) {
	return instance_create_depth(_x, _y, depth, _obj);
}

/// @param {real} x		The x position of the instance
/// @param {real} y		The y position of the instance
/// @desc Sets the starting (x,y) and the current (x,y) of an instance
function instance_set_start_pos(_x, _y) {
	xstart = _x; x = _x;
	ystart = _y; y = _y;
}

/// @param {real} x
/// @param {real} y
/// @param {real} depth
/// @param {real} object
/// @returns {instance} ID of the instance created (if it doesn't exist) or the existing instance
function instance_create_depth_single(_x, _y, _depth, _object) {
	if (instance_exists(_object)) return instance_find(_object, 0);
	return instance_create_depth(_x, _y, _depth, _object);
}

function is_object_instance(_struct_or_id) {
	try {
		return (variable_struct_exists(_struct_or_id, "object_index") && variable_struct_exists(_struct_or_id, "id"));
	} catch (_e) {
		return false;	
	}
}