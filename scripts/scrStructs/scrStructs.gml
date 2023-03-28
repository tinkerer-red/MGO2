function struct_copy(struct) {
	return json_parse(json_stringify(struct));
}

function struct_merge(_dest, _source, _overwrite = true){
	/// @func struct_merge(destination, source, [overwrite])
	/// @param {Struct} dest The index of the struct to copy to
	/// @param {Struct} source The index of the struct to copy from
	/// @param {Boolean} [overwrite=true] Whether the contents of the destination struct should be overwritten (true), or not (false)
	/// @returns {N/A}
	var _names = variable_struct_get_names(_source);
		
	if (_overwrite) {
		for (var _i = 0; _i < array_length(_names); _i++) {
			_dest[$ _names[_i]] = _source[$ _names[_i]];
		}
	} else {
		for (var _i = 0; _i < array_length(_names); _i++) {
			if (!variable_struct_exists(_dest, _names[_i])) {
				_dest[$ _names[_i]] = _source[$ _names[_i]];
			}
		}
	}
}

function struct_for_each(_struct, _callback) {
	if (is_struct(_struct)) { show_error("struct_for_each :: argument 0 is not a struct", true) };
	
	var _names = variable_struct_get_names(_struct);
	var _size = variable_struct_names_count(_struct);
	var _key, _val;
	
	var _i=0; repeat(_size) {
		_key = _names[_i];
		_val = _struct[$ _key];
		_callback(_val);
	_i+=1;}//end repeat loop
}