global.Display_Resolutions = ds_map_create();

function display_resolutions_update() {
	var
	_display_w = display_get_width(),
	_display_h = display_get_height();
	
	if ( !ds_map_exists(global.Display_Resolutions,_display_w/_display_h) ) {
		var
		_index = 0,
		_increment_value = 0,
		_height_math = 0,
		_resolution_list = -1,
		_resolution_w = 0,
		_resolution_h = 0;

		global.Display_Resolutions[? _display_w/_display_h] = ds_list_create();

		// width:height
		_resolution_list = global.Display_Resolutions[? _display_w/_display_h];
		_increment_value = 128;
		_height_math = _display_h / _display_w;
		_index = 0;
		while ( _resolution_w < _display_w && _resolution_h < _display_h ) {
			_resolution_w = 640 + (_index * _increment_value);
			_resolution_h = _resolution_w * _height_math;
			if ( _resolution_w > _display_w && _resolution_h > _display_h ) {
				ds_list_add(_resolution_list,[_display_w,_display_h]);
				break;
			} else {
				ds_list_add(_resolution_list,[_resolution_w,_resolution_h]);
			}
			++ _index;
		}
		
		return true;
	} else {
		return false;
	}
}

function display_convert_world_to_gui(x,y) {
	var
	_zoom = global.Gui_Width / global.Camera_Width,
	_distance_from_center = point_distance(global.Camera_X_Center,global.Camera_Y_Center,argument0,argument1) * _zoom,
	_direction_from_center = point_direction(global.Camera_X_Center,global.Camera_Y_Center,argument0,argument1);

	return
	[
		(global.Gui_Width * 0.5) + lengthdir_x(_distance_from_center,_direction_from_center),
		(global.Gui_Height * 0.5) + lengthdir_y(_distance_from_center,_direction_from_center),
		_zoom
	];
}

function display_resolution_next(resolution_w,resolution_h,aspect_ratio) {
	var
	_resolution_list = global.Display_Resolutions[? aspect_ratio],
	_resolution_array,
	_resolution_w_new0,
	_resolution_h_new0,
	_resolution_w_new1,
	_resolution_h_new1;
	
	if ( _resolution_list != undefined ) {
		exit;
	}
	
	var _index = 0;
	repeat ( ds_list_size(_resolution_list) ) {
		_resolution_array = _resolution_list[| _index ++];
		_resolution_w_new0 = _resolution_array[0];
		_resolution_h_new0 = _resolution_array[1];
		
		if ( _resolution_w_new0 >= global.Video_Resolution_Width || _resolution_h_new0 >= global.Video_Resolution_Height ) {
			if ( _index != ds_list_size(_resolution_list) ) {
				_resolution_array = _resolution_list[| _index];
				global.Video_Resolution_Width = _resolution_array[0];
				global.Video_Resolution_Height = _resolution_array[1];
			} else {
				_resolution_array = _resolution_list[| 0];
				global.Video_Resolution_Width = _resolution_array[0];
				global.Video_Resolution_Height = _resolution_array[1];
			}
			
			exit;
		}
	}
}

function display_resolution_previous(resolution_w,resolution_h,aspect_ratio) {
	var
	_resolution_list = global.Display_Resolutions[? aspect_ratio],
	_resolution_array,
	_resolution_w_new0,
	_resolution_h_new0,
	_resolution_w_new1,
	_resolution_h_new1;
	
	if ( _resolution_list != undefined ) {
		exit;
	}
	
	var _index = 0;
	repeat ( ds_list_size(_resolution_list) ) {
		_resolution_array = _resolution_list[| _index ++];
		_resolution_w_new0 = _resolution_array[0];
		_resolution_h_new0 = _resolution_array[1];
		
		if ( _resolution_w_new0 >= global.Video_Resolution_Width || _resolution_h_new0 >= global.Video_Resolution_Height ) {
			if ( _index > 0 ) {
				_resolution_array = _resolution_list[| _index - 1];
				global.Video_Resolution_Width = _resolution_array[0];
				global.Video_Resolution_Height = _resolution_array[1];
			} else {
				_resolution_array = _resolution_list[| ds_list_size(_resolution_list) - 1];
				global.Video_Resolution_Width = _resolution_array[0];
				global.Video_Resolution_Height = _resolution_array[1];
			}
			
			exit;
		}
	}
}

function display_resolution_max(aspect_ratio) {
	var _resolution_list = global.Display_Resolutions[? aspect_ratio];
	if ( _resolution_list == undefined ) {
		exit;
	} else {
		return ds_list_size(_resolution_list) - 1;
	}
}

function display_resolution_nearest(resolution_w,resolution_h,aspect_ratio) {
	var
	_resolution_list = global.Display_Resolutions[? aspect_ratio],
	_resolution_array,
	_resolution_w_new0,
	_resolution_h_new0,
	_resolution_w_new1,
	_resolution_h_new1;
	
	if ( _resolution_list == undefined ) {
		return 0;
	}
	
	var _ind = 0;
	repeat ( ds_list_size(_resolution_list) ) {
		_resolution_array = _resolution_list[| _ind];
		
		if ( _resolution_array[0] == global.Video_Resolution_Width && _resolution_array[1] == global.Video_Resolution_Height ) {
			break;
		} else if ( _resolution_array[0] > global.Video_Resolution_Width || _resolution_array[1] > global.Video_Resolution_Height ) {
			break;
		}
		
		++ _ind;
	}
	
	return _ind;
}

function display_aspect_ratio_supported() {
	return ds_map_exists(global.Display_Resolutions,global.Display_Width / global.Display_Height);
}
