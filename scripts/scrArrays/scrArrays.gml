function array_transpose(_arr) {
	/// @func array_transpose(array)
	/// @param {array} array Array to traspose
	/// @returns {array} The transposed array
	var width  = array_length(_arr),
			height = array_length(_arr[0]);
	
	var new_arr = array_create_2d(height, width, 0)
	
	for (var xx = 0; xx < width; xx++) for (var yy = 0; yy < height; yy++){
		new_arr[yy][xx] = _arr[xx][yy]
	}
	
	return new_arr;
}

function array_create_2d(h, w, v=undefined) {
	/// @func array_create_2d(outter_length, inner_length, value)
	/// @param {int} outter_length The length of the outter array,
	/// @param {int} inner_length The length of the inner arrays,
	/// @param {int} value The value to populate the inner arrays with,
	/// @returns {array} The created array of arrays
	var _arr = array_create(h, 0);
	for (var i = 0; i < h; i++) {
		_arr[i] = array_create(w, v)
	}
	return _arr
}

function array_compact_2d(_arr, v) {
	/// @func array_compact_2d(array, ignored_value)
	/// @param {array} array Array to traspose
	/// @param {int} ignored_value The value to consider as white space, usually 0, but sometimes -1
	/// @returns {array} The created array of arrays
	var height = array_length(_arr),
			width  = array_length(_arr[0]),
			xmin = infinity,
			ymin = infinity,
			xmax = -1,
			ymax = -1;
	
	//find the smallest possible area needed to keep
	for (var xx = 0; xx < width; xx++) for (var yy = 0; yy < height; yy++){
		if (_arr[yy][xx] != v){
			if (xx < xmin) { xmin = xx }
			if (yy < ymin) { ymin = yy }
			if (xx > xmax) { xmax = xx+1 }
			if (yy > ymax) { ymax = yy+1 }
		}
	}
	
	var new_width  = xmax - xmin,
	    new_height = ymax - ymin,
	    new_arr = array_create_2d(new_height, new_width, v);
	
	//now populate the new array
	for (var xx = 0; xx < new_width; xx++) for (var yy = 0; yy < new_height; yy++){
		new_arr[yy][xx] = _arr[yy+ymin][xx+xmin]
	}
	
	return new_arr
}

function array_merge(_arr1, _arr2) {
	/// @func array_merge(array1, array2)
	/// @param {array} array The base Array to add array2 into
	/// @param {array} array The secondary array which the values will be pulled from
	/// @returns {int} Newly created array, with no duplicate data
	for (var _i = 0; _i < array_length(_arr2); _i++){
		var _ind = array_find_index(_arr1, _arr2[_i])
		if (_ind = -1) {
			array_push(_arr1, _arr2[_i])
		}
	}
	
	return _arr1;
}

function array_stretch(_arr, _size, _do_lerp = true) {
	/// @func array_stretch(array, size, [interpolate])
	/// @param {array} array The base Array to stretch
	/// @param {int} the size of the returned array
	/// @param {bool} should we interpolate between values
	/// @returns {int} Newly created array, with no duplicate data
	var _new_arr = array_create(_size, 0)
	
	for (var _i = 0; _i < _size; _i++){
		var _norm_i = _i/(_size-1);
		var _length = array_length(_arr)-1;
		if (_do_lerp){
			var _index1 = floor(_norm_i*_length)
			var _index2 = ceil(_norm_i*_length)
			var _value = lerp(_arr[_index1], _arr[_index2], _norm_i);
			_new_arr[_i] = _value;
		}else{
			var _index = floor(_norm_i*_length + 0.5)
			_new_arr[_i] = _arr[_index]
		}
	}
	
	return _new_arr;
}

function array_flatten(_arr) {
	var _new_arr = [];
	var _index = 0;
	
	var _size1 = array_length(_arr)
	var _i, _j, _size2, _sub_arr;
	_i=0; repeat(_size1) {
		_sub_arr = _arr[_i];
		_size2 = array_length(_sub_arr);
		
		_j=0; repeat(_size2) {
			_new_arr[_index] = _sub_arr[_j];
			_index++;
		_j++; }; //end inner repeat
	_i++; }; //end outer repeat
	
	return _new_arr;
}

function array_add(arr1, arr2){
	var _new_arr = arr1;
	
	var _size = array_length(arr2)
	var _i = 0; repeat(_size) {
		array_push(_new_arr, arr2[_i])
		_i++
	}
	
	return _new_arr;
}

function array_convert_to_grid(array) {
	var
	_grid = ds_grid_create(array_length(array),1),
	_index = 0;
	
	repeat ( array_length(array) ) {
		_grid[# _index,0] = array[_index];
		++ _index;
	}
	
	return _grid;
}
	
function array_convert_to_list(array) {
	var
	_list = ds_list_create(),
	_index = 0;
	
	repeat ( array_length(array) ) {
		ds_list_add(_list,array[_index ++]);
	}
	
	return _list;
}

function array_push_recycle(array,max_size,values) {
	for ( var i = 2; i < argument_count; ++ i; ) {
		array_push(array,argument[i]);
	}

	while ( array_length(array) > max_size ) {
		array_delete(array,0,1);
	}
}
