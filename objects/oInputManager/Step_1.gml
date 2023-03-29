if ( global.input_ignore ) { exit; }

input_vibration_device_lerp(global.device_current,0,0.25);

var _device = input_device_get_any_pressed();
if ( _device != noone ) {
var _guid = gamepad_get_guid(_device);
	var _vibration = 0;
	if ( global.device_current != -1 ) {
		if ( global.device_guid != _guid ) {
			_vibration = input_vibration_device_get(global.device_current);
			input_vibration_device_set(global.device_current,0);
		}
	}
		
	global.device_current = _device;
	global.device_type = input_device_get_type(_device);
}

var
_device_count = ds_list_size(global.input_device_list),
_device_id,
_axis_list,
_axis_value;

enum AXIS_STATE {
	UNTOUCHED,
	PRESSED,
	HELD,
	RELEASED
}


for ( var i = 0; i < _device_count; ++ i; ) {
	_device_id = global.input_device_list[| i];
	
	if ( _device_id >= 0 )
	&& (input_gamepad_is_connected(_device_id)){
		_axis_list = global.input_axis_map[? _device_id];
		
		#region Axis, Left Up
		_axis_value = clamp(gamepad_axis_value(_device_id,gp_axislv), -1, 0);
		
		var _index = _axis_list[| 0];
		if (_index == AXIS_STATE.UNTOUCHED) { // Untouched
			if ( _axis_value <= -global.input_axis_directional_deadzone ) {
				_axis_list[| 0] = AXIS_STATE.PRESSED;
			}
		}
		else if (_index == AXIS_STATE.PRESSED) { // Pressed
			if ( _axis_value <= -global.input_axis_directional_deadzone ) {
				_axis_list[| 0] = AXIS_STATE.HELD;
			} else if ( _axis_value > -global.input_axis_directional_deadzone ) {
				_axis_list[| 0] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.HELD) { // Held
			if ( _axis_value > -global.input_axis_directional_deadzone ) {
				_axis_list[| 0] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.RELEASED) { // Released
			if ( _axis_value <= -global.input_axis_directional_deadzone ) {
				_axis_list[| 0] = AXIS_STATE.PRESSED;
			} else {
				_axis_list[| 0] = AXIS_STATE.UNTOUCHED;
			}
		}
		#endregion
		#region Axis, Left Down
		_axis_value = clamp(gamepad_axis_value(_device_id,gp_axislv), 0, 1);
		var _index = _axis_list[| 1]
		if (_index == AXIS_STATE.UNTOUCHED) { // Untouched
			if ( _axis_value >= global.input_axis_directional_deadzone ) {
				_axis_list[| 1] = AXIS_STATE.PRESSED;
			}
		}
		else if (_index == AXIS_STATE.PRESSED) { // Pressed
			if ( _axis_value >= global.input_axis_directional_deadzone ) {
				_axis_list[| 1] = AXIS_STATE.HELD;
			} else if ( _axis_value < global.input_axis_directional_deadzone ) {
				_axis_list[| 1] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.HELD) { // Held
			if ( _axis_value < global.input_axis_directional_deadzone ) {
				_axis_list[| 1] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.RELEASED) { // Released
			if ( _axis_value >= global.input_axis_directional_deadzone ) {
				_axis_list[| 1] = AXIS_STATE.PRESSED;
			} else {
				_axis_list[| 1] = AXIS_STATE.UNTOUCHED;
			}
		}
		
		#endregion
		#region Axis, Left Left
		_axis_value = clamp(gamepad_axis_value(_device_id,gp_axislh), -1, 0);
		var _index = _axis_list[| 2]
		if (_index == AXIS_STATE.UNTOUCHED) { // Untouched
			if ( _axis_value <= -global.input_axis_directional_deadzone ) {
				_axis_list[| 2] = AXIS_STATE.PRESSED;
			}
		}
		else if (_index == AXIS_STATE.PRESSED) { // Pressed
			if ( _axis_value <= -global.input_axis_directional_deadzone ) {
				_axis_list[| 2] = AXIS_STATE.HELD;
			} else if ( _axis_value > -global.input_axis_directional_deadzone ) {
				_axis_list[| 2] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.HELD) { // Held
			if ( _axis_value > -global.input_axis_directional_deadzone ) {
				_axis_list[| 2] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.RELEASED) { // Released
			if ( _axis_value <= -global.input_axis_directional_deadzone ) {
				_axis_list[| 2] = AXIS_STATE.PRESSED;
			} else {
				_axis_list[| 2] = AXIS_STATE.UNTOUCHED;
			}
		}
		#endregion
		#region Axis, Left Right
		_axis_value = clamp(gamepad_axis_value(_device_id,gp_axislh), 0, 1);
		var _index = _axis_list[| 3]
		if (_index == AXIS_STATE.UNTOUCHED) { // Untouched
			if ( _axis_value >= global.input_axis_directional_deadzone ) {
				_axis_list[| 3] = AXIS_STATE.PRESSED;
			}
		}
		else if (_index == AXIS_STATE.PRESSED) { // Pressed
			if ( _axis_value >= global.input_axis_directional_deadzone ) {
				_axis_list[| 3] = AXIS_STATE.HELD;
			} else if ( _axis_value < global.input_axis_directional_deadzone ) {
				_axis_list[| 3] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.HELD) { // Held
			if ( _axis_value < global.input_axis_directional_deadzone ) {
				_axis_list[| 3] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.RELEASED) { // Released
			if ( _axis_value >= global.input_axis_directional_deadzone ) {
				_axis_list[| 3] = AXIS_STATE.PRESSED;
			} else {
				_axis_list[| 3] = AXIS_STATE.UNTOUCHED;
			}
		}
		#endregion
		#region Axis, Right Up
		_axis_value = clamp(gamepad_axis_value(_device_id,gp_axisrv), -1, 0);
		var _index = _axis_list[| 4]
		if (_index == AXIS_STATE.UNTOUCHED) { // Untouched
			if ( _axis_value <= -global.input_axis_directional_deadzone ) {
				_axis_list[| 4] = AXIS_STATE.PRESSED;
			}
		}
		else if (_index == AXIS_STATE.PRESSED) { // Pressed
			if ( _axis_value <= -global.input_axis_directional_deadzone ) {
				_axis_list[| 4] = AXIS_STATE.HELD;
			} else if ( _axis_value > -global.input_axis_directional_deadzone ) {
				_axis_list[| 4] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.HELD) { // Held
			if ( _axis_value > -global.input_axis_directional_deadzone ) {
				_axis_list[| 4] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.RELEASED) { // Released
			if ( _axis_value <= -global.input_axis_directional_deadzone ) {
				_axis_list[| 4] = AXIS_STATE.PRESSED;
			} else {
				_axis_list[| 4] = AXIS_STATE.UNTOUCHED;
			}
		}
		#endregion
		#region Axis, Right Down
		_axis_value = clamp(gamepad_axis_value(_device_id,gp_axisrv), 0, 1);
		var _index = _axis_list[| 5]
		if (_index == AXIS_STATE.UNTOUCHED) { // Untouched
			if ( _axis_value >= global.input_axis_directional_deadzone ) {
				_axis_list[| 5] = AXIS_STATE.PRESSED;
			}
		}
		else if (_index == AXIS_STATE.PRESSED) { // Pressed
			if ( _axis_value >= global.input_axis_directional_deadzone ) {
				_axis_list[| 5] = AXIS_STATE.HELD;
			} else if ( _axis_value < global.input_axis_directional_deadzone ) {
				_axis_list[| 5] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.HELD) { // Held
			if ( _axis_value < global.input_axis_directional_deadzone ) {
				_axis_list[| 5] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.RELEASED) { // Released
			if ( _axis_value >= global.input_axis_directional_deadzone ) {
				_axis_list[| 5] = AXIS_STATE.PRESSED;
			} else {
				_axis_list[| 5] = AXIS_STATE.UNTOUCHED;
			}
		}
		#endregion
		#region Axis, Right Left
		_axis_value = clamp(gamepad_axis_value(_device_id,gp_axisrh), -1, 0);
		var _index = _axis_list[| 6]
		if (_index == AXIS_STATE.UNTOUCHED) { // Untouched
			if ( _axis_value <= -global.input_axis_directional_deadzone ) {
				_axis_list[| 6] = AXIS_STATE.PRESSED;
			}
		}
		else if (_index == AXIS_STATE.PRESSED) { // Pressed
			if ( _axis_value <= -global.input_axis_directional_deadzone ) {
				_axis_list[| 6] = AXIS_STATE.HELD;
			} else if ( _axis_value > -global.input_axis_directional_deadzone ) {
				_axis_list[| 6] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.HELD) { // Held
			if ( _axis_value > -global.input_axis_directional_deadzone ) {
				_axis_list[| 6] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.RELEASED) { // Released
			if ( _axis_value <= -global.input_axis_directional_deadzone ) {
				_axis_list[| 6] = AXIS_STATE.PRESSED;
			} else {
				_axis_list[| 6] = AXIS_STATE.UNTOUCHED;
			}
		}
		#endregion
		#region Axis, Right Right
		_axis_value = clamp(gamepad_axis_value(_device_id,gp_axisrh), 0, 1);
		var _index = _axis_list[| 7]
		if (_index == AXIS_STATE.UNTOUCHED) { // Untouched
			if ( _axis_value >= global.input_axis_directional_deadzone ) {
				_axis_list[| 7] = AXIS_STATE.PRESSED;
			}
		}
		else if (_index == AXIS_STATE.PRESSED) { // Pressed
			if ( _axis_value >= global.input_axis_directional_deadzone ) {
				_axis_list[| 7] = AXIS_STATE.HELD;
			} else if ( _axis_value < global.input_axis_directional_deadzone ) {
				_axis_list[| 7] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.HELD) { // Held
			if ( _axis_value < global.input_axis_directional_deadzone ) {
				_axis_list[| 7] = AXIS_STATE.RELEASED;
			}
		}
		else if (_index == AXIS_STATE.RELEASED) { // Released
			if ( _axis_value >= global.input_axis_directional_deadzone ) {
				_axis_list[| 7] = AXIS_STATE.PRESSED;
			} else {
				_axis_list[| 7] = AXIS_STATE.UNTOUCHED;
			}
		}
		#endregion
	}
}
	
update_cache();

global.input_ignore = false;


