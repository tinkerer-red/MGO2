function buffer_grid_create(width,height,data_type,data_type_byte_count) {
	
	/*
		This is a buffer-based DS Grid implementation
		that will return an array that should be used for
		all future calls to buffer_grid_* functions
	*/
	
	var _buffer = buffer_create(((width * height) * data_type_byte_count),buffer_fixed,1);
	
	var _grid = ds_grid_create(5,1);
	_grid[# 0,0] = _buffer;
	_grid[# 1,0] = data_type;
	_grid[# 2,0] = data_type_byte_count;
	_grid[# 3,0] = width;
	_grid[# 4,0] = height;

	return _grid;
}

function buffer_grid_copy(dest,source) {
	var _source_size = source[# 3,0] * source[# 4,0];
	buffer_resize(dest[# 0,0],_source_size);
	buffer_copy(source[# 0,0],0,_source_size,dest[# 0,0],0);
}

function buffer_grid_set_region(buffer_grid,x1,y1,x2,y2,value) {
	var _buffer = buffer_grid[# 0,0];
	var _buffer_data_type = buffer_grid[# 1,0];
	var _buffer_data_offset = buffer_grid[# 2,0];
	var _width = buffer_grid[# 3,0];
	var _y = y1;
	repeat ( (y2 - y1) + 1 ) {
		var _x = x1;
		repeat ( (x2 - x1) + 1 ) {
			buffer_poke(_buffer,(_x + (_y * _width)) * _buffer_data_offset,_buffer_data_type,value);
			++ _x;
		}
	
		++ _y;
	}
}

function buffer_grid_clear(buffer_grid,value) {
	buffer_fill(buffer_grid[# 0,0],8,buffer_grid[# 1,0],value,buffer_grid[# 3,0] * buffer_grid[# 4,0]);
}

function buffer_grid_get(buffer_grid,_x,_y) {
	return buffer_peek(buffer_grid[# 0,0],(_x + (_y * buffer_grid[# 3,0])) * buffer_grid[# 2,0],buffer_grid[# 1,0])
}

function buffer_grid_set(buffer_grid,_x,_y,value) {
	buffer_poke(buffer_grid[# 0,0],(_x + (_y * buffer_grid[# 3,0])) * buffer_grid[# 2,0],buffer_grid[# 1,0],value);
}

function buffer_grid_destroy(buffer_grid) {
	buffer_delete(buffer_grid[# 0,0]);
	ds_grid_destroy(buffer_grid);
}

function buffer_grid_width(buffer_grid) {
	return buffer_grid[# 3,0];
}

function buffer_grid_height(buffer_grid) {
	return buffer_grid[# 4,0];
}

function buffer_write_slice(buffer,data_buffer,data_start,data_end) {
	var next = data_end - data_start;
	if (next <= 0) exit;
	var size = buffer_get_size(buffer);
	var pos = buffer_tell(buffer);
	var need = pos + next;
	if (size < need) {
	    do size *= 2 until (size >= need);
	    buffer_resize(buffer, size);
	}
	buffer_copy(data_buffer, data_start, next, buffer, pos);
	buffer_seek(buffer,buffer_seek_relative,next);
}
