/// @param {struct} data

register = function(_data) {
	static __index = 0;
	
	_data.index = __index++;
	_data.callback = method(_data.context, _data.callback);
	
	var _arr, _len, _left, _right, _mid, _i;
	_arr = input_stack;
	_len = array_length(_arr);
	_left = 0; _right = _len-1;
		
	while (_left <= _right) {
		_mid = (_left+_right) div 2;
		if (_arr[_mid].depth <= _data.depth) _left = _mid+1;
			else _right = _mid-1;
	}
		
	array_push(input_stack, undefined);
	for (_i = _len; _i > _left; --_i) _arr[@ _i] = _arr[_i-1];
	_arr[@ _left] = _data;

	return _data.index;
}

unregister = function(_index) {
	var _i = 0; repeat (array_length(input_stack)) {
		if (input_stack[_i].index == _index) {
			array_delete(input_stack, _i, 1);
			return true;
		}
		++_i;
	}
	return false;
}
