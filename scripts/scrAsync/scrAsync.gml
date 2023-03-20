global.Buffer_Async_List = ds_list_create();
global.Buffer_Async_Pointers = ds_list_create();
global.Buffer_Async_Queued = false;

enum BufferAsync {
	Buffer,
	FileName,
	Directory,
	Size,
	Attempts,
	Saving,
	VariableFlag,
	IsFileCheck,
	Waiting
}

function buffer_async_load(buffer,file,variableflag,filecheck) {
	if ( ds_list_size(global.Buffer_Async_Pointers) > 0 ) {
	
		var _map = ds_map_create();

		ds_list_add(global.Buffer_Async_Pointers,-1);
		ds_list_add(global.Buffer_Async_List,_map);

		_map[? BufferAsync.Buffer] = buffer;
		_map[? BufferAsync.FileName] = file;
		_map[? BufferAsync.Attempts] = 0;
		_map[? BufferAsync.Saving] = false;
		_map[? BufferAsync.VariableFlag] = variableflag;
		_map[? BufferAsync.IsFileCheck] = filecheck;
		_map[? BufferAsync.Size] = -1;
	
		show_debug_message("Adding \"" + _map[? BufferAsync.FileName] + "\" to queue");
	
	} else {
	
		show_debug_message("Attempting to load \"" + file + "\"");
	
		var 
		_map = ds_map_create(),
		_pointer = buffer_load_async(buffer,file,0,-1);

		ds_list_add(global.Buffer_Async_Pointers,_pointer);
		ds_list_add(global.Buffer_Async_List,_map);

		_map[? BufferAsync.Buffer] = buffer;
		_map[? BufferAsync.FileName] = file;
		_map[? BufferAsync.Attempts] = 0;
		_map[? BufferAsync.Saving] = false;
		_map[? BufferAsync.VariableFlag] = variableflag;
		_map[? BufferAsync.IsFileCheck] = filecheck;
		_map[? BufferAsync.Size] = -1;

	}
}

function buffer_async_process() {
	if ( !ds_map_exists(async_load,"type") ) {

		// Parameters
		var _attempt_limit = 3;

		var
		_pointer = async_load[? "id"],
		_list_index = ds_list_find_index(global.Buffer_Async_Pointers,_pointer),
		_skip_queue = false;

		if ( _list_index != -1 ) {
			var _map = global.Buffer_Async_List[| _list_index];
			if ( _map[? BufferAsync.Saving] ) {
		
				// Saving
				if ( async_load[? "status"] ) {
			
					// Save was successful! So let's clean up!
					ds_list_delete(global.Buffer_Async_Pointers,_list_index);
					ds_list_delete(global.Buffer_Async_List,_list_index);
					buffer_delete(_map[? BufferAsync.Buffer]);
					variable_global_set(_map[? BufferAsync.VariableFlag],1);
				
					// Copy file to non-temp file
					file_copy(_map[? BufferAsync.Directory] + "/" + _map[? BufferAsync.FileName],_map[? BufferAsync.Directory] + "/" + string_delete(_map[? BufferAsync.FileName],string_length(_map[? BufferAsync.FileName]) - 4,5));
				
					ds_map_destroy(_map);
				
					return true;
			
				} else {
					if ( _map[? BufferAsync.Attempts] < _attempt_limit ) {
				
						// Leave it in the queue and try later
						++ _map[? BufferAsync.Attempts];
				
					} else {
				
						// Give up!
						show_error("Failed to save file, \"" + _map[? BufferAsync.FileName] + "\". Check anti-virus software and harddrive integrity.",true);
						variable_global_set(_map[? BufferAsync.VariableFlag],-1);
						_skip_queue = true;
						alarm[0] = 1;
				
					}
			
				}
		
			} else {
		
				// Loading
				if ( async_load[? "status"] ) {
			
					if ( _map[? BufferAsync.IsFileCheck] ) {
				
						show_debug_message("File, \"" + _map[? BufferAsync.FileName] + "\" exist.");
				
					}
			
					// Load was successful! So let's clean up!
					ds_list_delete(global.Buffer_Async_Pointers,_list_index);
					ds_list_delete(global.Buffer_Async_List,_list_index);
					variable_global_set(_map[? BufferAsync.VariableFlag],1);
				
					// If the file was a temp file
					if ( string_copy(_map[? BufferAsync.FileName],string_length(_map[? BufferAsync.FileName]) - 4,5) == "_temp" ) {
						show_debug_message("Copying temp file to actual file location");
						if ( _map[? BufferAsync.FileName] ) {
							file_delete(_map[? BufferAsync.FileName]);
						}
						file_copy(_map[? BufferAsync.FileName],string_delete(_map[? BufferAsync.FileName],string_length(_map[? BufferAsync.FileName]) - 4,5));
					}
				
					ds_map_destroy(_map);

			
				} else {
			
					if ( _map[? BufferAsync.Attempts] < _attempt_limit ) {
				
						if ( _map[? BufferAsync.IsFileCheck] ) {
					
							show_debug_message("File, \"" + _map[? BufferAsync.FileName] + "\" does not exist.");
					
							// Flag results
					
							// Check for a temp save file we can use as a back up
							if ( string_copy(_map[? BufferAsync.FileName],string_length(_map[? BufferAsync.FileName]) - 4,5) != "_temp" ) {
								show_debug_message("Didn't find the file, checking temp file " + (_map[? BufferAsync.FileName] + "_temp"));
								_map[? BufferAsync.FileName] = _map[? BufferAsync.FileName] + "_temp";
							} else {
								ds_list_delete(global.Buffer_Async_Pointers,_list_index);
								ds_list_delete(global.Buffer_Async_List,_list_index);
								variable_global_set(_map[? BufferAsync.VariableFlag],-1);
								ds_map_destroy(_map);
							}
					
						} else {
					
							// Leave it in the queue and try later
							++ _map[? BufferAsync.Attempts];
						
							// Check for a temp save file we can use as a back up
							if ( string_copy(_map[? BufferAsync.FileName],string_length(_map[? BufferAsync.FileName]) - 4,5) != "_temp" ) {
								_map[? BufferAsync.FileName] = _map[? BufferAsync.FileName] + "_temp";
							}
				
						}
				
					} else {
				
						if ( _map[? BufferAsync.IsFileCheck] ) {
					
							show_debug_message("File, \"" + _map[? BufferAsync.FileName] + "\" does not exist.");
					
							// Flag results
							ds_list_delete(global.Buffer_Async_Pointers,_list_index);
							ds_list_delete(global.Buffer_Async_List,_list_index);
							variable_global_set(_map[? BufferAsync.VariableFlag],-1);
							ds_map_destroy(_map);
					
						} else {
					
							// Give up!
							show_error("Failed to load file, \"" + _map[? BufferAsync.FileName] + "\". Check anti-virus software and harddrive integrity.",true);
							_skip_queue = true;
							alarm[0] = 1;
					
						}
				
					}
			
				}
		
			}
		}

		// Save the next file in our end step!
		if ( !_skip_queue && ds_list_size(global.Buffer_Async_Pointers) > 0 ) {
			global.Buffer_Async_Queued = true;
			buffer_async_queue();
		}
	
		return false;

	}
}

function buffer_async_queue() {
	if ( global.Buffer_Async_Queued ) {
	
		// Check for next async save/load
		if ( ds_list_size(global.Buffer_Async_Pointers) > 0 ) {
			var _map = global.Buffer_Async_List[| 0];
			if ( _map[? BufferAsync.Saving] ) {
				buffer_async_group_begin(_map[? BufferAsync.Directory]);
				buffer_save_async(_map[? BufferAsync.Buffer],_map[? BufferAsync.FileName],0,_map[? BufferAsync.Size]);
				global.Buffer_Async_Pointers[| 0] = buffer_async_group_end();
			} else {
				global.Buffer_Async_Pointers[| 0] = buffer_load_async(_map[? BufferAsync.Buffer],_map[? BufferAsync.FileName],0,_map[? BufferAsync.Size]);
			}
		}

		global.Buffer_Async_Queued = false;

	}
}

function buffer_async_save(buffer,file,directory,variableflag) {
	var
	_buffer_size = buffer_get_size(buffer),
	_buffer_position = buffer_tell(buffer),
	_map = ds_map_create(),
	_buffer_copy = buffer_create(_buffer_size,buffer_grow,1);

	buffer_copy(buffer,0,_buffer_size,_buffer_copy,0)

	buffer_seek(buffer,buffer_seek_start,0);

	if ( ds_list_size(global.Buffer_Async_Pointers) > 0 ) {
	
		ds_list_add(global.Buffer_Async_Pointers,-1);
		ds_list_add(global.Buffer_Async_List,_map);
	
		_map[? BufferAsync.Buffer] = _buffer_copy;
		_map[? BufferAsync.FileName] = file + "_temp";
		_map[? BufferAsync.Directory] = directory;
		_map[? BufferAsync.Size] = _buffer_size;
		_map[? BufferAsync.Attempts] = 0;
		_map[? BufferAsync.Saving] = true;
		_map[? BufferAsync.VariableFlag] = variableflag;
	
		show_debug_message("Adding \"" + _map[? BufferAsync.FileName] + "\" to queue");
	
	} else {
	
		show_debug_message("Attempting to save \"" + file + "\"");
	
		buffer_async_group_begin(directory);
		buffer_save_async(buffer,file + "_temp",0,_buffer_size);
		var _pointer = buffer_async_group_end();
	
		ds_list_add(global.Buffer_Async_Pointers,_pointer);
		ds_list_add(global.Buffer_Async_List,_map);
	
		_map[? BufferAsync.Buffer] = _buffer_copy;
		_map[? BufferAsync.FileName] = file + "_temp";
		_map[? BufferAsync.Directory] = directory;
		_map[? BufferAsync.Size] = _buffer_size;
		_map[? BufferAsync.Attempts] = 0;
		_map[? BufferAsync.Saving] = true;
		_map[? BufferAsync.VariableFlag] = variableflag;
	
	}

	buffer_seek(buffer,_buffer_position,0);
}
