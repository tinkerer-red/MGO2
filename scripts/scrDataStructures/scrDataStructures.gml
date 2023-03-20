function ds_destroy(_id, _type) {
	/// @param {int} id
	/// @param {ds_type} type
    switch (_type) {
        case ds_type_grid       : if (ds_exists(_id, ds_type_grid))     ds_grid_destroy(_id);       break;
        case ds_type_list       : if (ds_exists(_id, ds_type_list))     ds_list_destroy(_id);       break;
        case ds_type_map        : if (ds_exists(_id, ds_type_map))      ds_map_destroy(_id);        break;
        case ds_type_priority   : if (ds_exists(_id, ds_type_priority)) ds_priority_destroy(_id);   break;
        case ds_type_queue      : if (ds_exists(_id, ds_type_queue))    ds_queue_destroy(_id);      break;
        case ds_type_stack      : if (ds_exists(_id, ds_type_stack))    ds_stack_destroy(_id);      break;
        default: break;
    }
}

function ds_grid_to_array(_grid) {
	/// @func ds_grid_to_array(ds_grid)
	/// @param {ds_grid} ds_grid The grid to convert into an array
	/// @returns {array}
	var width  = ds_grid_width(_grid),
			height = ds_grid_height(_grid);
	
	var new_arr = array_create_2d(width, height, 0)
	
	for (var xx = 0; xx < width; xx++) for (var yy = 0; yy < height; yy++){
		new_arr[xx][yy] = _grid[# xx, yy]
	}
	
	return new_arr;
}

function ds_list_to_array(_list) {
	/// @func ds_list_to_array(ds_list)
	/// @param {ds_list} ds_grid The grid to convert into an array
	/// @returns {array}
	var _size = ds_list_size(_list);
	
	var new_arr = array_create(_size, 0)
	
	for (var xx = 0; xx < _size; xx++){
		new_arr[xx] = _list[| xx]
	}
	
	return new_arr;
}

function ds_grid_shuffle_adv(_grid, _shuffle_columns, _shuffle_rows) {
	var _width, widthmax, _height, heightmax, _gridTemp, xrandom, yrandom;
	
	
	_width    = ds_grid_width(_grid);
	widthmax  = _width
	_height   = ds_grid_height(_grid);
	heightmax = _height
	_gridTemp = ds_grid_create(_width,_height)
	
	if (_shuffle_columns) && (!_shuffle_rows)
	{
	    for (var _i=0; _i < widthmax; _i++)
	    {
	        _width = ds_grid_width(_grid)
	        xrandom = irandom(_width-1)
	        ds_grid_set_grid_region(_gridTemp, _grid, xrandom, 0, xrandom, _height-1, _i, 0)
	        ds_grid_set_grid_region(_grid, _grid, xrandom+1, 0, _width-1, _height-1, xrandom, 0);
	        ds_grid_resize(_grid,_width-1,_height);
	        if (_width = 1) break;
	    }
	    ds_grid_resize(_grid, widthmax, heightmax)
	    ds_grid_copy(_grid, _gridTemp)
	}
	
	
	if (!_shuffle_columns) && (_shuffle_rows)
	{
	    for (var _i=0; _i < heightmax; _i++)
	    {
	        _height = ds_grid_height(_grid)
	        yrandom = irandom(_height-1)
	        ds_grid_set_grid_region(_gridTemp, _grid, 0, yrandom, _width-1, yrandom, 0, _i)
	        ds_grid_set_grid_region(_grid, _grid, 0, yrandom+1, _width-1, _height-1, 0, yrandom);
	        ds_grid_resize(_grid,_width,_height-1);
	        if (_height = 1) break;
	    }
	    ds_grid_resize(_grid, widthmax, heightmax)
	    ds_grid_copy(_grid, _gridTemp)
	}
	
	if  (_shuffle_columns) && (_shuffle_rows)
	{
	    ds_grid_shuffle(_grid)
	}
	//ds_grid_destroy(_grid)
	ds_grid_destroy(_gridTemp)
	return _grid;
}

function ds_grid_print(_grid, _filename="", _column_names=-1){
	///scr_ds_grid_print(DSGridIndex, filename, columnNames)
	
	/**
	 * Prints the DS Grid items to the console
	 *
	 * @param   DSGridIndex  The input DS grid, DSGrid
	 * @param   filename     (optional) Output the data in a file instead, string
	 * @param   columnNames  (optional) An array holding the column names, string
	 * 
	 * @return  nothing
	 */
	
	// note: Printing in GMS console may look a bit off because the console doesn't use a monospace font
	//       at the moment, best print to a filename and open with a text editor without wordwrap on
	
	var _width, _height, _string, _row, _column;
	
	var _file_handle = -1;
	_width  = ds_grid_width(_grid);
	_height = ds_grid_height(_grid);
	
	if (_filename != "") {
	    _file_handle = file_text_open_append(_filename);
	}
	
	if (_filename == "") {
	    show_debug_message("");
			
	    show_debug_message("  DS Grid: "+string(_grid));
	    show_debug_message("  Size: "+string(_width)+" x "+string(_height));
			
	    show_debug_message("");
	} else {
			
	    file_text_writeln(_file_handle);
	    file_text_write_string(_file_handle, "  DS Grid: "+string(_grid));
	    file_text_writeln(_file_handle);
	    file_text_write_string(_file_handle, "  Size: "+string(_width)+" x "+string(_height));
	    file_text_writeln(_file_handle);
	    file_text_writeln(_file_handle);
			
	}
	
	// find longest string in grid items
	var _found = "";
	var _longest = "";
	
	for (_row = 0; _row < _height; ++_row) {
			
	    for (_column = 0; _column < _width; ++_column) {
					
	        _found = string( _grid[# _column, _row]);
	        if (string_length(_found) > string_length(_longest)) { _longest = _found; }
					
	    }
	}
	
	var _maxlength = string_length(_longest)+1;
	var _height_digits = string_length(string(_height));
	
	// print column indexes
	var _number_of_columns = 0;
	var _columns = " "+string_pad_right(" ", _height_digits, " ")+" |";
	for (_column = 0; _column < _width; ++_column) {
	    if (_column_names != -1) {
	        _columns += " "+string_pad_right(string(_column)+" "+_column_names[_column], _maxlength, " ")+"|";
	    } else {
	        _columns += " "+string_pad_right(string(_column), _maxlength, " ")+"|";
	    }
	    _number_of_columns += 1;
	}
	
	// print separator
	var _separator = " "+string_pad_right(" ", _height_digits, " ")+" ";
	repeat(_number_of_columns+1) { repeat(_maxlength) { _separator += "-"; } }
	
	if (_filename == "") {
	    show_debug_message(_columns);
	    show_debug_message(_separator);
	} else {
	   file_text_write_string(_file_handle, _columns);
	   file_text_writeln(_file_handle);
	   file_text_write_string(_file_handle, _separator);
	   file_text_writeln(_file_handle);
	}
	
	// print row indexes and items
	for (_row = 0; _row < _height; ++_row) {
			
	    _string = " ";
	    _string += string_pad_right(string(_row), _height_digits, " ")+" | ";
			
	    for (_column = 0; _column < _width; ++_column) {
					
	        if (_column >= _width-1) {
	            var _delimiter = "|";
	        } else {
	            var _delimiter = ", ";
	        }
					
	        if (_grid[# _column, _row] == 0) {
	            _string += string_pad_right("0", _maxlength, " ")+_delimiter;
	        } else {
	            _string += string_pad_right(string( _grid[# _column, _row] ), _maxlength, " ")+_delimiter;
	        }
					
	    }
			
	    if (_filename == "") {
	        show_debug_message(_string);
	    } else {
	        file_text_write_string(_file_handle, _string); 
	        file_text_writeln(_file_handle);
	    }
			
	}

	// print separator
	if (_filename == "") {
	    show_debug_message(_separator);
	    show_debug_message("");
	} else {
	   file_text_write_string(_file_handle, _separator);    
	   file_text_writeln(_file_handle); 
	   file_text_writeln(_file_handle);
	}

	if (_filename != "") {
	    file_text_close(_file_handle);
	}
}

function ds_list_print(_list, _filename = ""){
	///scr_ds_list_print(DSListIndex, filename)
	
	/**
	 * Prints the DS List items to the console
	 *
	 * @param   DSListIndex  The input DS list, DSList
	 * @param   filename   (optional) Output the data in a file instead, string
	 * 
	 * @return  nothing
	 */
	
	// find longest string in list items
	var _found = "";
	var _longest = "";
	
	for (var _i=0; _i < ds_list_size(_list); ++_i) {
	    _found = string(_i);
	    if (string_length(_found) > string_length(_longest)) { _longest = _found; }
	}
	
	var _maxlength = string_length(_longest);
	
	if (_filename != "") {
	    var _file_handle = file_text_open_append(_filename);
	    file_text_writeln(_file_handle);
	    file_text_write_string(_file_handle, "  DS List: "+string(_list)); 
	    file_text_writeln(_file_handle);
	    file_text_write_string(_file_handle, "  Size: "+string(ds_list_size(_list))); 
	    file_text_writeln(_file_handle);
	} else {
	    show_debug_message(""); 
	    show_debug_message("  DS List: "+string(_list)); 
	    show_debug_message("  Size: "+string(ds_list_size(_list))); 
	    show_debug_message(""); 
	}
	
	for (var _i=0; _i < ds_list_size(_list); ++_i) {
			
	    if (_filename != "") {
	        file_text_write_string(_file_handle, " "+string_pad_right(string(_i), _maxlength, " ")+" : "+string_format(_list[| _i], 10, 15) );
	        file_text_writeln(_file_handle);
	        file_text_writeln(_file_handle);
	    } else {
	        show_debug_message( " "+string_pad_right(string(_i), _maxlength, " ")+" : "+string_format(_list[| _i], 10, 15) );
	    }
			
	}
	
	if (_filename != "") {
	    file_text_close(_file_handle);
	} else {
	    show_debug_message(""); 
	}
}

function ds_list_add_recycle(list,max_size,values) {
	// Adds to a list and deletes the bottom of the list

	for ( var i = 2; i < argument_count; ++ i; ) {
		ds_list_add(list,argument[i]);
	}

	while ( ds_list_size(list) > max_size ) {
		ds_list_delete(list,0);
	}
}

function ds_list_mean(list) {
	if ( ds_list_size(list) <= 0 ) { return 0; }
	return ds_list_sum(list) div ds_list_size(list);
}

function ds_list_write_buffer(buffer,list,start,finish) {
	// Writes a ds_list to a buffer with optionally defined parameters
	var _list = list;

	if ( argument_count == 2 ) {
	
		var
		_size = ds_list_size(_list),
		_is_string = false;
	
		buffer_write(buffer,buffer_u32,_size);		// end
		buffer_write(buffer,buffer_u32,0);			// start
	
		for ( var _i = 0; _i < _size; ++ _i; ) {
			_is_string = is_string(_list[| _i]);
			buffer_write(buffer,buffer_u8,_is_string);
			buffer_write(buffer,_is_string ? buffer_string : buffer_f64,_list[| _i]);
		}
	
	} else {
	
		var
		_start = start,
		_end = finish,
		_is_string = false;
	
		buffer_write(buffer,buffer_u32,_end);		// end
		buffer_write(buffer,buffer_u32,_start);		// start
	
		for ( var _i = _start; _i < _end; ++ _i; ) {
			_is_string = is_string(_list[| _i]);
			buffer_write(buffer,buffer_u8,_is_string);
			buffer_write(buffer,_is_string ? buffer_string : buffer_f64,_list[| _i]);
		}
	
	}
}

function ds_list_read_buffer(buffer,list) {
	// Reads a ds_list from a buffer
	var
	_end = buffer_read(buffer,buffer_u32),
	_start = buffer_read(buffer,buffer_u32);
	
	for ( var _i = _start; _i < _end; ++ _i; ) {
		list[| _i] = buffer_read(buffer,buffer_u8) ? buffer_read(buffer,buffer_string) : buffer_read(buffer,buffer_f64);
	}
}

function ds_grid_write_buffer(buffer,grid,x1,y1,x2,y2) {
	// Writes a ds_grid to a buffer with optionally defined parameters
	if ( argument_count == 2 ) {
	
		var
		_width = ds_grid_width(grid),
		_height = ds_grid_height(grid),
		_is_string = false;
	
		buffer_write(buffer,buffer_u32,ds_grid_width(grid));		// width
		buffer_write(buffer,buffer_u32,ds_grid_height(grid));		// height
		buffer_write(buffer,buffer_u32,0);							// x
		buffer_write(buffer,buffer_u32,0);							// y
	
		for ( var _y = 0; _y < _height; ++ _y; ) {
			for ( var _x = 0; _x < _width; ++ _x; ) {
				_is_string = is_string(grid[# _x, _y]);
				buffer_write(buffer,buffer_u8,_is_string);
				buffer_write(buffer,_is_string ? buffer_string : buffer_f64,grid[# _x, _y]);
			}
		}
	
	} else {
	
		var
		_is_string = false;
	
		buffer_write(buffer,buffer_u32,x2);	// width
		buffer_write(buffer,buffer_u32,y2);	// height
		buffer_write(buffer,buffer_u32,x1);	// x
		buffer_write(buffer,buffer_u32,y1);	// y
	
		for ( var _y = y1; _y < y2; ++ _y; ) {
			for ( var _x = x1; _x < x2; ++ _x; ) {
				_is_string = is_string(grid[# _x, _y]);
				buffer_write(buffer,buffer_u8,_is_string);
				buffer_write(buffer,_is_string ? buffer_string : buffer_f64,grid[# _x, _y]);
			}
		}
	
	}
}
	
function ds_grid_read_buffer(buffer,grid) {
	// Reads a ds_grid from a buffer
	var
	_x2 = buffer_read(buffer,buffer_u32),
	_y2 = buffer_read(buffer,buffer_u32),
	_x1 = buffer_read(buffer,buffer_u32),
	_y1 = buffer_read(buffer,buffer_u32);
	
	for ( var _y = _y1; _y < _y2; ++ _y; ) {
		for ( var _x = _x1; _x < _x2; ++ _x; ) {
			grid[# _x, _y] = buffer_read(buffer,buffer_u8) ? buffer_read(buffer,buffer_string) : buffer_read(buffer,buffer_f64);
		}
	}
}

function ds_list_sum(list) {
	// Gives the total real value of a ds_list
	var
	_value = 0,
	_size = ds_list_size(list);

	for ( var _i = 0; _i < _size; ++ _i; ) {
		_value += list[| _i];
	}

	return _value;
}
	
function ds_list_min(list) {
	// Gives the min real value of a ds_list
	var
	_value = 0,
	_size = ds_list_size(list);

	for ( var _i = 0; _i < _size; ++ _i; ) {
		_value = min(list[| _i],_value);
	}

	return _value;
}
	
function ds_list_max(list) {
	// Gives the max real value of a ds_list
	var
	_value = 0,
	_size = ds_list_size(list);

	for ( var _i = 0; _i < _size; ++ _i; ) {
		_value = max(list[| _i],_value);
	}

	return _value;
}

function ds_list_swap(list,index_src,index_dest) {
	var
	_value0 = list[| index_src],
	_value1 = list[| index_dest];
	
	list[| index_src] = _value1;
	list[| index_dest] = _value0;
}

function ds_map_add_default(map,key,value) {
	if ( !ds_map_exists(map,key) ) {
		ds_map_add(map,key,value);
	}
}

function ds_map_iterate(map,return_key_list) {
	// Iterates a ds_map returning optional lists

	/*
		If return_key_list is true, then a list is returned
		[0] --> Key List
		[1] --> Value List
		
		else
		
		we just return a list of values
	*/

	var
	_key = ds_map_find_first(map),
	_value_list = ds_list_create();

	if ( argument_count > 1 && return_key_list ) {
		var _key_list = ds_list_create();
	} else {
		var _key_list = undefined;
	}

	while ( !is_undefined(_key) ) {
		ds_list_add(_value_list,map[? _key]);
	
		if ( _key_list != undefined ) {
			ds_list_add(_key_list,_key);
		}
	
		_key = ds_map_find_next(map,_key);
	}

	if ( _key_list != undefined ) {
		return [_key_list,_value_list];
	} else {
		return _value_list;
	}
}

function ds_map_write_buffer(buffer,map) {
	buffer_write(buffer,buffer_string,json_encode(map));
}

function ds_map_read_buffer(buffer,map) {
	map = json_decode(buffer_read(buffer,buffer_string));
}

function ds_list_pull_first(list) {
	// Removes and returns the first value in a ds_list
	var _value = list[| 0];
	ds_list_delete(list,0);

	return _value;
}

function ds_list_pull_last(list) {
	// Removes and returns the last value in a ds_list
	var _index = ds_list_size(list) - 1;
	var _value = list[| _index];
	ds_list_delete(list,_index);

	return _value;
}

function ds_list_push_first(list,value) {
	// Inserts a value into the first index of a ds_list
	ds_list_insert(list,0,value);
}

function ds_list_push_last(list,value) {
	// Inserts a value into the last index of a ds_list
	ds_list_add(list,value);
}

function ds_list_find_first(list) {
	// Finds the first value in a list
	return list[| 0];
}

function ds_list_find_last(list) {
	// Finds the last value in a list
	return list[| ds_list_size(list) - 1];
}
	
function ds_list_delete_entry(list,value) {
	var _index = ds_list_find_index(list,value);
	if ( _index != -1 ) {
		ds_list_delete(list,_index);
	}
}
	
function ds_list_copy_contents(list_src,list_dest) {
	var
	_size = ds_list_size(list_src),
	_index = 0;
	
	repeat ( _size ) {
		ds_list_add(list_dest,list_src[| _index ++]);
	}
}
	
function ds_list_convert_to_array(list) {
	var
	_array = array_create(ds_list_size(list)),
	_index = 0;
	
	repeat ( ds_list_size(list) ) {
		_array[_index] = list[| _index];
		++ _index;
	}
	
	return _array;
}
	
function ds_list_convert_to_array_safe_ext(list,delete_list) {
	if ( is_array(list) ) {
		return list;
	}
	
	var
	_array = array_create(ds_list_size(list)),
	_index = 0;
	
	repeat ( ds_list_size(list) ) {
		_array[_index] = list[| _index];
		++ _index;
	}
	
	if ( delete_list ) {
		ds_list_destroy(list);
	}
	
	return _array;
}
