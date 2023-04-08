/// @description equals(variable, value, within)
/// @param variable
/// @param  value
/// @param  within
function equals(_var, _value, _epsilon = -1) {
	/*
	 * Returns true if the given variable is close enough
	 * to the given value (within a certain number)
	 */
	static _default_epsilon = math_get_epsilon()
	
	if (_epsilon == -1) {
		_epsilon = _default_epsilon;
	}
	
	_epsilon = _epsilon/2;
	return (_var > _value-_epsilon && _var < _value+_epsilon);
}