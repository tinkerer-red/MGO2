/// @desc METHODS

run_step_modifiers = function() {
	var _remove_mod;
	var _size = array_length(__state_mods);
	var _i=0; repeat(_size) {
		_remove_mod = __state_mods[_i]();
			
		if (_remove_mod) {
			array_delete(__state_mods, _i, 1)
			_i--;
		}
		else{
			__continue_to_next_step = false
		}
	_i+=1;}//end repeat loop
}

