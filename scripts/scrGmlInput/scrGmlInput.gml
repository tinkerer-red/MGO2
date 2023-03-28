#macro input_axislu 200000
#macro input_axisld 200001
#macro input_axisll 200002
#macro input_axislr 200003
#macro input_axisru 200004
#macro input_axisrd 200005
#macro input_axisrl 200006
#macro input_axisrr 200007
#macro input_mouse_special -50
#macro input_mouse_wheel_up -51
#macro input_mouse_wheel_down -52

//additional vk keys
#macro vk_left_braket 219
#macro vk_right_braket 221
#macro vk_pipe 220
#macro vk_colon 186
#macro vk_quote 222
#macro vk_less_than 188
#macro vk_greater_than 190
#macro vk_question_mark 191

enum input_type{
	mouse,
	wheel,
	keyboard,
	face,
	axis,
	none,
}


#region Just helper functions
function input_register(_depth = 0,_context = id,_callback) {
	return INPUT.register({
		depth		: _depth,
		context		: _context,
		callback	: _callback
	}
	);
}

function input_unregister(_register_index) {
	INPUT.unregister(_register_index);
}
#endregion

// Device handling
global.input_device_list = ds_list_create();			// Stores a list of all connected devices
global.Input_Player_Device = ds_map_create();			// Used to tag a device to a player
global.Input_Data_List = ds_list_create();				// Stores a list of player inputs
global.input_axis_map = ds_map_create();				// Axis state data
global.input_vibration_map = ds_map_create();			// Vibration data
global.input_axis_directional_deadzone = 0.1;			// Axis "pressed" and "released" deadzone
global.input_debug = false;
global.input_ignore = false;
global.input_axis_deadzone = 0.05;
ds_list_add(global.input_device_list,-1);


// Action mapping
global.input_action_list = array_create(ACTION.Size);
global.input_action_function_list = array_create(ACTION.Size);
	
var _index = 0;
repeat ( ACTION.Size ) {
	global.input_action_list[_index] = ds_list_create();
	global.input_action_function_list[_index] = ds_list_create();
	_index++;
}

function input_clear_keys_all() {
	var _index = 0;
	repeat ( ACTION.Size ) {
		input_action_remove_all(_index ++);
	}
}

function input_axis_deadzone(axis_deadzone) {
	global.input_axis_deadzone = axis_deadzone;
}

#region vibration
function input_vibration_all_set(vibration) {
	for ( var i = 0; i < ds_list_size(global.input_device_list); ++ i; ) {
		global.input_vibration_map[? global.input_device_list[| i]] = vibration;
		gamepad_set_vibration(global.input_device_list[| i],vibration,vibration);
	}
}

function input_vibration_all_add(vibration) {
	for ( var i = 0; i < ds_list_size(global.input_device_list); ++ i; ) {
		global.input_vibration_map[? global.input_device_list[| i]] = clamp(global.input_vibration_map[? global.input_device_list[| i]] + vibration,0,1);
		var _vibration_strength = global.input_vibration_map[? global.input_device_list[| i]];
		gamepad_set_vibration(global.input_device_list[| i],_vibration_strength,_vibration_strength);
	}
}

function input_vibration_device_set(device,vibration) {
	if ( device >= 0 ) {
		global.input_vibration_map[? device] = vibration;
		gamepad_set_vibration(device,vibration,vibration);
	}
}

function input_vibration_device_add(device,vibration) {
	if ( device >= 0 ) {
		global.input_vibration_map[? device] = clamp(global.input_vibration_map[? device] + vibration,0,1);
		var _vibration_strength = global.input_vibration_map[? device];
		gamepad_set_vibration(device,_vibration_strength,_vibration_strength);
	}
}

function input_vibration_device_subtract(device,vibration) {
	if ( device >= 0 ) {
		global.input_vibration_map[? device] = clamp(global.input_vibration_map[? device] - vibration,0,1);
		var _vibration_strength = global.input_vibration_map[? device];
		gamepad_set_vibration(device,_vibration_strength,_vibration_strength);
	}
}

function input_vibration_device_lerp(device,vibration,lerp_speed) {
	if ( device >= 0 ) {
		global.input_vibration_map[? device] = clamp(math_lerp_smooth(global.input_vibration_map[? device],vibration,lerp_speed),0,1);
		var _vibration_strength = global.input_vibration_map[? device];
		gamepad_set_vibration(device,_vibration_strength,_vibration_strength);
	}
}

function input_vibration_device_get(device) {
	if ( ds_map_exists(global.input_vibration_map,device) ) {
		return global.input_vibration_map[? device];
	} else {
		return 0;
	}
}
#endregion

function input_process() {
	switch ( async_load[? "event_type"] ) {
	
		case "gamepad lost":

			var
			_device_count = gamepad_get_device_count(),
			_str,
			_map,
			_current_device_count = ds_list_size(global.input_device_list);
		
			for ( var i = 0; i < _current_device_count; ++ i; ) {
				if ( global.input_device_list[| i] != -1 && global.input_device_list[| i] != undefined && !gamepad_is_connected(global.input_device_list[| i]) ) {
					if ( global.input_debug ) {
						show_debug_message("Removed " + string(gamepad_get_description(global.input_device_list[| i])));
					}
					if ( ds_map_exists(global.input_axis_map,global.input_device_list[| i]) ) {
						var _device_id = global.input_device_list[| i];
						ds_list_destroy(global.input_axis_map[? _device_id]);
						ds_map_delete(global.input_axis_map,_device_id);
						ds_map_delete(global.input_vibration_map,_device_id);
					}
				
					ds_list_delete(global.input_device_list,i);
					-- _current_device_count;
					-- i;
				}
			}
		
		break;
		
		case "gamepad discovered":
			
			var _pad_index = async_load[? "pad_index"];
			if ( gamepad_is_connected(_pad_index) ) {
				if ( global.input_debug ) {
					show_debug_message("Added " + string(gamepad_get_description(_pad_index)));
				}
				ds_list_add(global.input_device_list,_pad_index);
				ds_map_add(global.input_axis_map,_pad_index,ds_list_create());
				ds_list_add(global.input_axis_map[? _pad_index],0,0,0,0,0,0,0,0);	// Add 8 axis directions and axis deadzone
				gamepad_set_axis_deadzone(_pad_index,global.input_axis_deadzone);
				ds_map_add(global.input_vibration_map,_pad_index,0);
			}

		break;
	}
}

function input_device_check_any(device) {
	if ( device == -1 ) {	// Check keyboard
	
		if ( keyboard_check(vk_anykey) ) {
			return keyboard_lastkey;
		} else {
			if ( mouse_check_button(mb_any) ) {
				return mouse_lastbutton;
			} else if ( mouse_wheel_down() || mouse_wheel_up() ) {
				return mouse_wheel_down() ? input_mouse_wheel_down : input_mouse_wheel_up;
			}
		}
	
	} else {	// Check gamepads
	
		for ( var i = gp_face1; i < gp_axisrv + 1; ++ i; ) {
			if ( i == gp_axislh || i == gp_axislv || i == gp_axisrh || i == gp_axisrv ) {
				var _axis_value = gamepad_axis_value(device,i);
				if ( _axis_value != 0 ) {
					if ( i == gp_axislh ) {
						if ( _axis_value > 0 ) {
							return input_axislr;
						} else {
							return input_axisll;
						}
					}
				
					if ( i == gp_axislv ) {
						if ( _axis_value > 0 ) {
							return input_axisld;
						} else {
							return input_axislu;
						}
					}
				
					if ( i == gp_axisrh ) {
						if ( _axis_value > 0 ) {
							return input_axisrr;
						} else {
							return input_axisrl;
						}
					}
				
					if ( i == gp_axisrv ) {
						if ( _axis_value > 0 ) {
							return input_axisrd;
						} else {
							return input_axisru;
						}
					}
				}
			} else {
				if ( gamepad_button_check(device,i) ) { return i; }
			}
		}
	
	}

	return false;
}

function input_device_get_all() {
	return global.input_device_list;
}

function input_device_check_any_pressed(device) {	
	if ( device == -1 ) {	// Check keyboard
		
		// This is an HTML5 bug, keyboard_lastkey shouldn't return a string, but it does :(
		if ( is_string(keyboard_lastkey) ) { return false; } 
		
		if ( keyboard_check_pressed(vk_anykey) ) {
			return keyboard_lastkey;
		} else {
			if ( mouse_check_button_pressed(mb_any) ) {
				return mouse_lastbutton;
			} else if ( mouse_wheel_down() || mouse_wheel_up() ) {
				return mouse_wheel_down() ? input_mouse_wheel_down : input_mouse_wheel_up;
			}
		}
	
	} else {	// Check gamepads
	
		for ( var i = gp_face1; i < gp_axisrv + 1; ++ i; ) {
			if ( i == gp_axislh || i == gp_axislv || i == gp_axisrh || i == gp_axisrv ) {
				var _axis_value = gamepad_axis_value(device,i);
				if ( _axis_value != 0 ) {
					if ( i == gp_axislh ) {
						if ( _axis_value > 0 ) {
							return input_axislr;
						} else {
							return input_axisll;
						}
					}
				
					if ( i == gp_axislv ) {
						if ( _axis_value > 0 ) {
							return input_axisld;
						} else {
							return input_axislu;
						}
					}
				
					if ( i == gp_axisrh ) {
						if ( _axis_value > 0 ) {
							return input_axisrr;
						} else {
							return input_axisrl;
						}
					}
				
					if ( i == gp_axisrv ) {
						if ( _axis_value > 0 ) {
							return input_axisrd;
						} else {
							return input_axisru;
						}
					}
				}
			} else {
				if ( gamepad_button_check_pressed(device,i) ) { return i; }
			}
		}
	
	}

	return false;
}

function input_device_check_any_released(device) {
	if ( device == -1 ) {	// Check keyboard
	
		if ( keyboard_check_released(vk_anykey) ) {
			return keyboard_lastkey;
		} else {
			if ( mouse_check_button_released(mb_any) ) {
				return mouse_lastbutton;
			} else if ( mouse_wheel_down() || mouse_wheel_up() ) {
				return mouse_wheel_down() ? input_mouse_wheel_down : input_mouse_wheel_up;
			}
		}
	
	} else {	// Check gamepads
	
		for ( var i = gp_face1; i < gp_axisrv + 1; ++ i; ) {
			if ( i == gp_axislh || i == gp_axislv || i == gp_axisrh || i == gp_axisrv ) {
				var _axis_value = gamepad_axis_value(device,i);
				if ( _axis_value != 0 ) {
					if ( i == gp_axislh ) {
						if ( _axis_value > 0 ) {
							return input_axislr;
						} else {
							return input_axisll;
						}
					}
				
					if ( i == gp_axislv ) {
						if ( _axis_value > 0 ) {
							return input_axisld;
						} else {
							return input_axislu;
						}
					}
				
					if ( i == gp_axisrh ) {
						if ( _axis_value > 0 ) {
							return input_axisrr;
						} else {
							return input_axisrl;
						}
					}
				
					if ( i == gp_axisrv ) {
						if ( _axis_value > 0 ) {
							return input_axisrd;
						} else {
							return input_axisru;
						}
					}
				}
			} else {
				if ( gamepad_button_check_released(device,i) ) { return i; }
			}
		}
	
	}

	return false;
}

#region input checks
function input_check(keycode, type) {
	
	if (type == input_type.keyboard){
		return keyboard_check(keycode);
	}
	else if (type == input_type.mouse){
		return mouse_check_button(keycode);
	}
	else if (type == input_type.face){
		if (!input_gamepad_exists()){return false;}
		var i = 0;
		repeat ( ds_list_size(global.input_device_list) ) {
			var _device = global.input_device_list[| i];
			if (_device != -1)
			&& (input_gamepad_is_connected(_device)) {
				return gamepad_button_check(_device, keycode);
			}
			++ i;
		}
	}
	else if (type == input_type.axis){
		if (!input_gamepad_exists()){return false;}
		return input_check_axis(keycode)
	}
	else if (type == input_type.wheel){
		return false;
	}
	else if (type == input_type.none){
		return (keyboard_check(vk_nokey) && mouse_check_button(mb_none))
	}
	return false;
}

function input_check_pressed(keycode, type) {
	if (type == input_type.keyboard){
		return keyboard_check_pressed(keycode);
	}
	else if (type == input_type.mouse){
		return mouse_check_button_pressed(keycode);
	}
	else if (type == input_type.face){
		if (!input_gamepad_exists()){return false;}
		var i = 0;
		repeat ( ds_list_size(global.input_device_list) ) {
			var _device = global.input_device_list[| i];
			if (_device != -1)
			&& (input_gamepad_is_connected(_device)) {
				return gamepad_button_check_pressed(global.input_device_list[| i],keycode);
			}
			++ i;
		}
	}
	else if (type == input_type.axis){
		if (!input_gamepad_exists()){return false;}
		return input_check_axis_pressed(keycode)
	}
	else if (type == input_type.wheel){
		switch ( keycode ) {
			case input_mouse_wheel_up:
				return mouse_wheel_up();
			break;
			
			case input_mouse_wheel_down:
				return mouse_wheel_down();
			break;
		}
	}
	else if (type == input_type.none){
		return false;
	}
	return false;
}

function input_check_released(keycode, type) {
	if (type == input_type.keyboard){
		return keyboard_check_released(keycode);
	}
	else if (type == input_type.mouse){
		return mouse_check_button_released(keycode);
	}
	else if (type == input_type.face){
		if (!input_gamepad_exists()){return false;}
		var i = 0;
		repeat ( ds_list_size(global.input_device_list) ) {
			var _device = global.input_device_list[| i];
			if (_device != -1)
			&& (input_gamepad_is_connected(_device)) {
				return gamepad_button_check_released(global.input_device_list[| i],keycode);
			}
			++ i;
		}
	}
	else if (type == input_type.axis){
		if (!input_gamepad_exists()){return false;}
		return input_check_axis_released(keycode)
	}
	else if (type == input_type.wheel){
		return false;
	}
	else if (type == input_type.none){
		return false
	}
	return false;
}

function input_check_axis(keycode) {
	var _axis_value = 0;

	var i = 0;
	repeat ( ds_list_size(global.input_device_list) ) {
		var _device = global.input_device_list[| i];
		if (_device != -1)
		&& (input_gamepad_is_connected(_device)) {
			switch ( keycode ) {
				case input_axislu:
					_axis_value = gamepad_axis_value(global.input_device_list[| i],gp_axislv);
					if ( _axis_value <= -global.input_axis_directional_deadzone ) {
						return clamp(-_axis_value, 0, 1);
					}
				break;
			
				case input_axisld:
					_axis_value = gamepad_axis_value(global.input_device_list[| i],gp_axislv);
					if ( _axis_value > global.input_axis_directional_deadzone ) {
						return clamp(_axis_value, 0, 1);
					}
				break;
			
				case input_axisll:
					_axis_value = gamepad_axis_value(global.input_device_list[| i],gp_axislh);
					if ( _axis_value < -global.input_axis_directional_deadzone ) {
						return clamp(-_axis_value, 0, 1);
					}
				break;
			
				case input_axislr:
					_axis_value = gamepad_axis_value(global.input_device_list[| i],gp_axislh);
					if ( _axis_value > global.input_axis_directional_deadzone ) {
						return clamp(_axis_value, 0, 1);
					}
				break;
			
				case input_axisru:
					_axis_value = gamepad_axis_value(global.input_device_list[| i],gp_axisrv);
					if ( _axis_value < -global.input_axis_directional_deadzone ) {
						return clamp(-_axis_value, 0, 1);
					}
				break;
			
				case input_axisrd:
					_axis_value = gamepad_axis_value(global.input_device_list[| i],gp_axisrv);
					if ( _axis_value > -global.input_axis_directional_deadzone ) {
						return clamp(_axis_value, 0, 1);
					}
				break;
			
				case input_axisrl:
					_axis_value = gamepad_axis_value(global.input_device_list[| i],gp_axisrh);
					if ( _axis_value < global.input_axis_directional_deadzone ) {
						return clamp(-_axis_value, 0, 1);
					}
				break;
			
				case input_axisrr:
					_axis_value = gamepad_axis_value(global.input_device_list[| i],gp_axisrh);
					if ( _axis_value > -global.input_axis_directional_deadzone ) {
						return clamp(_axis_value, 0, 1);
					}
				break;
			}
		}
		++ i;
	}

	return 0;
}

function input_check_axis_pressed(keycode) {
	var _axis_list;

	var i = 0;
	repeat ( ds_list_size(global.input_device_list) ) {
		var _device = global.input_device_list[| i];
		if (_device != -1)
		&& (input_gamepad_is_connected(_device)) {
			_axis_list = ds_map_find_value(global.input_axis_map,global.input_device_list[| i]);
			switch ( keycode ) {
				case input_axislu:
					if ( _axis_list[| 0] == 1 ) {
						return true;
					}
				break;
			
				case input_axisld:
					if ( _axis_list[| 1] == 1 ) {
						return true;
					}
				break;
			
				case input_axisll:
					if ( _axis_list[| 2] == 1 ) {
						return true;
					}
				break;
			
				case input_axislr:
					if ( _axis_list[| 3] == 1 ) {
						return true;
					}
				break;
			
				case input_axisru:
					if ( _axis_list[| 4] == 1 ) {
						return true;
					}
				break;
			
				case input_axisrd:
					if ( _axis_list[| 5] == 1 ) {
						return true;
					}
				break;
			
				case input_axisrl:
					if ( _axis_list[| 6] == 1 ) {
						return true;
					}
				break;
			
				case input_axisrr:
					if ( _axis_list[| 7] == 1 ) {
						return true;
					}
				break;
			}
		}
		++ i;
	}

	return 0;
}

function input_check_axis_held(keycode) {
	var _axis_list;

	var i = 0;
	repeat ( ds_list_size(global.input_device_list) ) {
		var _device = global.input_device_list[| i];
		if (_device != -1)
		&& (input_gamepad_is_connected(_device)) {
			_axis_list = ds_map_find_value(global.input_axis_map,global.input_device_list[| i]);
			switch ( keycode ) {
				case input_axislu:
					if ( _axis_list[| 0] == 2 ) {
						return true;
					}
				break;
			
				case input_axisld:
					if ( _axis_list[| 1] == 2 ) {
						return true;
					}
				break;
			
				case input_axisll:
					if ( _axis_list[| 2] == 2 ) {
						return true;
					}
				break;
			
				case input_axislr:
					if ( _axis_list[| 3] == 2 ) {
						return true;
					}
				break;
			
				case input_axisru:
					if ( _axis_list[| 4] == 2 ) {
						return true;
					}
				break;
			
				case input_axisrd:
					if ( _axis_list[| 5] == 2 ) {
						return true;
					}
				break;
			
				case input_axisrl:
					if ( _axis_list[| 6] == 2 ) {
						return true;
					}
				break;
			
				case input_axisrr:
					if ( _axis_list[| 7] == 2 ) {
						return true;
					}
				break;
			}
		}
		++ i;
	}

	return 0;
}

function input_check_axis_released(keycode) {
	var	_axis_list;

	var i = 0;
	repeat ( ds_list_size(global.input_device_list) ) {
		var _device = global.input_device_list[| i];
		if (_device != -1)
		&& (input_gamepad_is_connected(_device)) {
			_axis_list = ds_map_find_value(global.input_axis_map,global.input_device_list[| i]);
			switch ( keycode ) {
				case input_axislu:
					if ( _axis_list[| 0] == 3 ) {
						return true;
					}
				break;
			
				case input_axisld:
					if ( _axis_list[| 1] == 3 ) {
						return true;
					}
				break;
			
				case input_axisll:
					if ( _axis_list[| 2] == 3 ) {
						return true;
					}
				break;
			
				case input_axislr:
					if ( _axis_list[| 3] == 3 ) {
						return true;
					}
				break;
			
				case input_axisru:
					if ( _axis_list[| 4] == 3 ) {
						return true;
					}
				break;
			
				case input_axisrd:
					if ( _axis_list[| 5] == 3 ) {
						return true;
					}
				break;
			
				case input_axisrl:
					if ( _axis_list[| 6] == 3 ) {
						return true;
					}
				break;
			
				case input_axisrr:
					if ( _axis_list[| 7] == 3 ) {
						return true;
					}
				break;
			}
		}
		++ i;
	}

	return false;
}
#endregion

function input_device_check(device,keycode) {
	if ( device == -1 ) {
		return (keyboard_check(keycode) || mouse_check_button(keycode));
	} else {
		return gamepad_button_check(device,keycode);
	}
}

function input_get_keyname(keycode) {
	switch ( keycode ) {
	    case $00: { return "<none>"; } //none
	    case mb_left: { return "Left MB"; } //Left mouse button
	    case mb_right: { return "Right MB"; } //Right mouse button
	    case mb_middle: { return "Middle MB"; } //Middle mouse button (three-button mouse: { return ""; } //    
	    case $05: { return "XB1"; } //Windows 2000/XP: { return ""; } X1 mouse button
	    case $06: { return "XB2"; } //Windows 2000/XP: { return ""; } X2 mouse button
	    case $08: { return "BACK"; } //BACKSPACE key
	    case $09: { return "TAB"; } //TAB key
	    case $0C: { return "CLEAR"; } //CLEAR key
	    case $0D: { return "ENTER"; } //ENTER key
	    case $10: { return "SHFT"; } //SHIFT key
	    case $11: { return "CTRL"; } //CTRL key
	    case $12: { return "ALT"; } //ALT key
	    case $13: { return "PAUSE"; } //PAUSE key
	    case $14: { return "CAPS"; } //CAPS LOCK key
	    case $15: { return "HANGUL"; } //IME Hangul mode
	    case $17: { return "JUNJA"; } //IME Junja mode
	    case $18: { return "FINAL"; } //IME final mode
	    case $19: { return "HANJA"; } //IME Hanja mode    
	    case $1B: { return "ESC"; } //ESC key
	    case $1C: { return "CONV"; } //IME convert
	    case $1D: { return "NCONV"; } //IME nonconvert
	    case $1E: { return "ACC"; } //IME accept
	    case $1F: { return "MC"; } //IME mode change request
	    case $20: { return "SPC"; } //SPACEBAR
	    case $21: { return "PGUP"; } //PAGE UP key
	    case $22: { return "PGDN"; } //PAGE DOWN key
	    case $23: { return "END"; } //END key
	    case $24: { return "HOME"; } //HOME key
	    case $25: { return "ARROW LEFT"; } //LEFT ARROW key
	    case $26: { return "ARROW UP"; } //UP ARROW key
	    case $27: { return "ARROW RIGHT"; } //RIGHT ARROW key
	    case $28: { return "ARROW DOWN"; } //DOWN ARROW key
	    case $29: { return "SEL"; } //SELECT key
	    case $2A: { return "PRINT"; } //PRINT key
	    case $2B: { return "EXE"; } //EXECUTE key
	    case $2C: { return "PRINT SCR"; } //PRINT SCREEN key
	    case $2D: { return "INS"; } //INS key
	    case $2E: { return "DEL"; } //DEL key
	    case $2F: { return "HELP"; } //HELP key
	    case $30: { return "0"; } //0 key
	    case $31: { return "1"; } //1 key
	    case $32: { return "2"; } //2 key
	    case $33: { return "3"; } //3 key
	    case $34: { return "4"; } //4 key
	    case $35: { return "5"; } //5 key
	    case $36: { return "6"; } //6 key
	    case $37: { return "7"; } //7 key
	    case $38: { return "8"; } //8 key
	    case $39: { return "9"; } //9 key
	    case $41: { return "A"; } //A key
	    case $42: { return "B"; } //B key
	    case $43: { return "C"; } //C key
	    case $44: { return "D"; } //D key
	    case $45: { return "E"; } //E key
	    case $46: { return "F"; } //F key
	    case $47: { return "G"; } //G key
	    case $48: { return "H"; } //H key
	    case $49: { return "I"; } //I key
	    case $4A: { return "J"; } //J key
	    case $4B: { return "K"; } //K key
	    case $4C: { return "L"; } //L key
	    case $4D: { return "M"; } //M key
	    case $4E: { return "N"; } //N key
	    case $4F: { return "O"; } //O key
	    case $50: { return "P"; } //P key
	    case $51: { return "Q"; } //Q key
	    case $52: { return "R"; } //R key
	    case $53: { return "S"; } //S key
	    case $54: { return "T"; } //T key
	    case $55: { return "U"; } //U key
	    case $56: { return "V"; } //V key
	    case $57: { return "W"; } //W key
	    case $58: { return "X"; } //X key
	    case $59: { return "Y"; } //Y key
	    case $5A: { return "Z"; } //Z key
	    case $5B: { return "LWIN"; } //Left Windows key (Microsoft Natural keyboard: { return ""; }
	    case $5C: { return "RWIN"; } //Right Windows key (Natural keyboard: { return ""; } //
	    case $5D: { return "APPS"; } //Applications key (Natural keyboard: { return ""; } //
	    case $5F: { return "SLEEP"; } //Computer Sleep key
	    case $60: { return "NUM0"; } //Numeric keypad 0 key
	    case $61: { return "NUM1"; } //Numeric keypad 1 key
	    case $62: { return "NUM2"; } //Numeric keypad 2 key
	    case $63: { return "NUM3"; } //Numeric keypad 3 key
	    case $64: { return "NUM4"; } //Numeric keypad 4 key
	    case $65: { return "NUM5"; } //Numeric keypad 5 key
	    case $66: { return "NUM6"; } //Numeric keypad 6 key
	    case $67: { return "NUM7"; } //Numeric keypad 7 key
	    case $68: { return "NUM8"; } //Numeric keypad 8 key
	    case $69: { return "NUM9"; } //Numeric keypad 9 key
	    case $6A: { return "*"; } //Multiply key
	    case $6B: { return "+"; } //Add key
	    case $6C: { return "SEP"; } //Separator key
	    case $6D: { return "-"; } //Subtract key
	    case $6E: { return ","; } //Decimal key
	    case $6F: { return "/"; } //Divide key
	    case $70: { return "F1"; } //F1 key
	    case $71: { return "F2"; } //F2 key
	    case $72: { return "F3"; } //F3 key
	    case $73: { return "F4"; } //F4 key
	    case $74: { return "F5"; } //F5 key
	    case $75: { return "F6"; } //F6 key
	    case $76: { return "F7"; } //F7 key
	    case $77: { return "F8"; } //F8 key
	    case $78: { return "F9"; } //F9 key
	    case $79: { return "F10"; } //F10 key
	    case $7A: { return "F11"; } //F11 key
	    case $7B: { return "F12"; } //F12 key
	    case $7C: { return "F13"; } //F13 key
	    case $7D: { return "F14"; } //F14 key
	    case $7E: { return "F15"; } //F15 key
	    case $7F: { return "F16"; } //F16 key
	    case $80: { return "F17"; } //F17 key
	    case $81: { return "F18"; } //F18 key
	    case $82: { return "F19"; } //F19 key
	    case $83: { return "F20"; } //F20 key
	    case $84: { return "F21"; } //F21 key
	    case $85: { return "F22"; } //F22 key
	    case $86: { return "F23"; } //F23 key
	    case $87: { return "F24"; } //F24 key
	    case $90: { return "NUMLOCK"; } //NUM LOCK key
	    case $91: { return "SCROLL"; } //SCROLL LOCK key
	    case $A0: { return "LSHIFT"; } //Left SHIFT key
	    case $A1: { return "RSHIFT"; } //Right SHIFT key
	    case $A2: { return "LCTRL"; } //Left CONTROL key
	    case $A3: { return "RCTRL"; } //Right CONTROL key
	    case $A4: { return "LALT"; } //Left MENU key
	    case $A5: { return "RALT"; } //Right MENU key
	    case $A6: { return "BRBACK"; } //Windows 2000/XP: { return ""; } Browser Back key
	    case $A7: { return "BRFORWARD"; } //Windows 2000/XP: { return ""; } Browser Forward key
	    case $A8: { return "BRREFRESH"; } //Windows 2000/XP: { return ""; } Browser Refresh key
	    case $A9: { return "BRSTOP"; } //Windows 2000/XP: { return ""; } Browser Stop key
	    case $AA: { return "BRSEARCH"; } //Windows 2000/XP: { return ""; } Browser Search key
	    case $AB: { return "BRFAVORITES"; } //Windows 2000/XP: { return ""; } Browser Favorites key
	    case $AC: { return "BRHOME"; } //Windows 2000/XP: { return ""; } Browser Start and Home key
	    case $AD: { return "VOLMUTE"; } //Windows 2000/XP: { return ""; } Volume Mute key
	    case $AE: { return "VOLDOWN"; } //Windows 2000/XP: { return ""; } Volume Down key
	    case $AF: { return "VOLUP"; } //Windows 2000/XP: { return ""; } Volume Up key
	    case $B0: { return "MEDNEXT"; } //Windows 2000/XP: { return ""; } Next Track key
	    case $B1: { return "MEDPREV"; } //Windows 2000/XP: { return ""; } Previous Track key
	    case $B2: { return "MEDSTOP"; } //Windows 2000/XP: { return ""; } Stop Media key
	    case $B3: { return "MEDPLAY"; } //Windows 2000/XP: { return ""; } Play/Pause Media key
	    case $B4: { return "MAIL"; } //Windows 2000/XP: { return ""; } Start Mail key
	    case $B5: { return "MEDIA"; } //Windows 2000/XP: { return ""; } Select Media key
	    case $B6: { return "APP1"; } //Windows 2000/XP: { return ""; } Start Application 1 key
	    case $B7: { return "APP2"; } //Windows 2000/XP: { return ""; } Start Application 2 key
	    case $BA: { return ":"; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $BB: { return "+"; } //Windows 2000/XP: { return ""; } For any country/region, the '+' key
	    case $BC: { return ","; } //Windows 2000/XP: { return ""; } For any country/region, the ',' key
	    case $BD: { return "-"; } //Windows 2000/XP: { return ""; } For any country/region, the '-' key
	    case $BE: { return "."; } //Windows 2000/XP: { return ""; } For any country/region, the '.' key
	    case $BF: { return "?"; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $C0: { return "~"; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $DB: { return "["; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $DC: { return "\\"; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $DD: { return "]"; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $DE: { return "'"; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $E5: { return "PROCESS"; } //Windows 95/98/Me, Windows NT 4.0, Windows 2000/XP: { return ""; } IME PROCESS key
	    case $E7: { return "PACKET"; } //Windows 2000/XP: { return ""; } Used to pass Unicode characters as if they were keystrokes. The PACKET key is the low word of a 32-bit Virtual Key value used for non-keyboard input methods. For more information, see Remark in KEYBDINPUT, SendInput, WM_KEYDOWN, and WM_KEYUP
	    case $F6: { return "ATTN"; } //Attn key
	    case $F7: { return "CRSEL"; } //CrSel key
	    case $F8: { return "EXSEL"; } //ExSel key
	    case $F9: { return "EREOF"; } //Erase EOF key
	    case $FA: { return "PLAY"; } //Play key
	    case $FB: { return "ZOOM"; } //Zoom key
	    case $FD: { return "PA1"; } //PA1 key
	    case $FE: { return "CLEAR"; } //Clear key
		case gp_face1: {return "A"; }
		case gp_face2: { return "B"; }
		case gp_face3: { return "X"; }
		case gp_face4: { return "Y"; }
		case gp_shoulderl: { return "LB"; }
		case gp_shoulderr: { return "RB"; }
		case gp_shoulderlb: { return "LT"; }
		case gp_shoulderrb: { return "RT"; }
		case gp_select: { return "SELECT"; }
		case gp_start: { return "START"; }
		case gp_stickl: { return "L STICK"; }
		case gp_stickr: { return "R STICK"; }
		case gp_padu: { return "DPAD UP"; }
		case gp_padd: { return "DPAD DOWN"; }
		case gp_padl: { return "DPAD LEFT"; }
		case gp_padr: { return "DPAD RIGHT"; }
		case input_axislu: { return "L AXIS UP"; }
		case input_axisld: { return "L AXIS DOWN"; }
		case input_axisll: { return "L AXIS LEFT"; }
		case input_axislr: { return "L AXIS RIGHT"; }
		case input_axisru: { return "R AXIS UP"; }
		case input_axisrd: { return "R AXIS DOWN"; }
		case input_axisrl: { return "R AXIS LEFT"; }
		case input_axisrr: { return "R AXIS RIGHT"; }
		case input_mouse_wheel_down: { return "Wheel Down"; }
		case input_mouse_wheel_up: { return "Wheel Up"; }

	    default: { return "UNSUPPORTED"; }    
	}
}

function input_get_sprite_keycode(keycode) {
	
	var
	_device = undefined,
	_key = "";
	
	switch ( keycode ) {
	    case $00: { _device = -1; _key = "None"; break; } //none
	    case mb_left: { _device = -1; _key = "MB Left"; break; } //Left mouse button
	    case mb_right: { _device = -1; _key = "MB Right"; break; } //Right mouse button
	    case mb_middle: { _device = -1; _key = "MB Middle"; break; } //Middle mouse button
	    case $05: { _device = -1; _key = "XB1"; break; } //Windows 2000/XP: { return ""; } X1 mouse button
	    case $06: { _device = -1; _key = "XB2"; break; } //Windows 2000/XP: { return ""; } X2 mouse button
	    case $08: { _device = -1; _key = "BACK"; break; } //BACKSPACE key
	    case $09: { _device = -1; _key = "TAB"; break; } //TAB key
	    case $0C: { _device = -1; _key = "CLEAR"; break; } //CLEAR key
	    case $0D: { _device = -1; _key = "ENTER"; break; } //ENTER key
	    case $10: { _device = -1; _key = "SHFT"; break; } //SHIFT key
	    case $11: { _device = -1; _key = "CTRL"; break; } //CTRL key
	    case $12: { _device = -1; _key = "ALT"; break; } //ALT key
	    case $13: { _device = -1; _key = "PAUSE"; break; } //PAUSE key
	    case $14: { _device = -1; _key = "CAPS"; break; } //CAPS LOCK key
	    case $15: { _device = -1; _key = "HANGUL"; break; } //IME Hangul mode
	    case $17: { _device = -1; _key = "JUNJA"; break; } //IME Junja mode
	    case $18: { _device = -1; _key = "FINAL"; break; } //IME final mode
	    case $19: { _device = -1; _key = "HANJA"; break; } //IME Hanja mode
	    case $1B: { _device = -1; _key = "ESC"; break; } //ESC key
	    case $1C: { _device = -1; _key = "CONV"; break; } //IME convert
	    case $1D: { _device = -1; _key = "NCONV"; break; } //IME nonconvert
	    case $1E: { _device = -1; _key = "ACC"; break; } //IME accept
	    case $1F: { _device = -1; _key = "MC"; break; } //IME mode change request
	    case $20: { _device = -1; _key = "SPC"; break; } //SPACEBAR
	    case $21: { _device = -1; _key = "PGUP"; break; } //PAGE UP key
	    case $22: { _device = -1; _key = "PGDN"; break; } //PAGE DOWN key
	    case $23: { _device = -1; _key = "END"; break; } //END key
	    case $24: { _device = -1; _key = "HOME"; break; } //HOME key
	    case $25: { _device = -1; _key = "ARROW LEFT"; break; } //LEFT ARROW key
	    case $26: { _device = -1; _key = "ARROW UP"; break; } //UP ARROW key
	    case $27: { _device = -1; _key = "ARROW RIGHT"; break; } //RIGHT ARROW key
	    case $28: { _device = -1; _key = "ARROW DOWN"; break; } //DOWN ARROW key
	    case $29: { _device = -1; _key = "SEL"; break; } //SELECT key
	    case $2A: { _device = -1; _key = "PRINT"; break; } //PRINT key
	    case $2B: { _device = -1; _key = "EXE"; break; } //EXECUTE key
	    case $2C: { _device = -1; _key = "PRINT SCR"; break; } //PRINT SCREEN key
	    case $2D: { _device = -1; _key = "INS"; break; } //INS key
	    case $2E: { _device = -1; _key = "DEL"; break; } //DEL key
	    case $2F: { _device = -1; _key = "HELP"; break; } //HELP key
	    case $30: { _device = -1; _key = "0"; break; } //0 key
	    case $31: { _device = -1; _key = "1"; break; } //1 key
	    case $32: { _device = -1; _key = "2"; break; } //2 key
	    case $33: { _device = -1; _key = "3"; break; } //3 key
	    case $34: { _device = -1; _key = "4"; break; } //4 key
	    case $35: { _device = -1; _key = "5"; break; } //5 key
	    case $36: { _device = -1; _key = "6"; break; } //6 key
	    case $37: { _device = -1; _key = "7"; break; } //7 key
	    case $38: { _device = -1; _key = "8"; break; } //8 key
	    case $39: { _device = -1; _key = "9"; break; } //9 key
	    case $41: { _device = -1; _key = "A"; break; } //A key
	    case $42: { _device = -1; _key = "B"; break; } //B key
	    case $43: { _device = -1; _key = "C"; break; } //C key
	    case $44: { _device = -1; _key = "D"; break; } //D key
	    case $45: { _device = -1; _key = "E"; break; } //E key
	    case $46: { _device = -1; _key = "F"; break; } //F key
	    case $47: { _device = -1; _key = "G"; break; } //G key
	    case $48: { _device = -1; _key = "H"; break; } //H key
	    case $49: { _device = -1; _key = "I"; break; } //I key
	    case $4A: { _device = -1; _key = "J"; break; } //J key
	    case $4B: { _device = -1; _key = "K"; break; } //K key
	    case $4C: { _device = -1; _key = "L"; break; } //L key
	    case $4D: { _device = -1; _key = "M"; break; } //M key
	    case $4E: { _device = -1; _key = "N"; break; } //N key
	    case $4F: { _device = -1; _key = "O"; break; } //O key
	    case $50: { _device = -1; _key = "P"; break; } //P key
	    case $51: { _device = -1; _key = "Q"; break; } //Q key
	    case $52: { _device = -1; _key = "R"; break; } //R key
	    case $53: { _device = -1; _key = "S"; break; } //S key
	    case $54: { _device = -1; _key = "T"; break; } //T key
	    case $55: { _device = -1; _key = "U"; break; } //U key
	    case $56: { _device = -1; _key = "V"; break; } //V key
	    case $57: { _device = -1; _key = "W"; break; } //W key
	    case $58: { _device = -1; _key = "X"; break; } //X key
	    case $59: { _device = -1; _key = "Y"; break; } //Y key
	    case $5A: { _device = -1; _key = "Z"; break; } //Z key
	    case $5B: { _device = -1; _key = "LWIN"; break; } //Left Windows key (Microsoft Natural keyboard: { return ""; }
	    case $5C: { _device = -1; _key = "RWIN"; break; } //Right Windows key (Natural keyboard: { return ""; } //
	    case $5D: { _device = -1; _key = "APPS"; break; } //Applications key (Natural keyboard: { return ""; } //
	    case $5F: { _device = -1; _key = "SLEEP"; break; } //Computer Sleep key
	    case $60: { _device = -1; _key = "NUM0"; break; } //Numeric keypad 0 key
	    case $61: { _device = -1; _key = "NUM1"; break; } //Numeric keypad 1 key
	    case $62: { _device = -1; _key = "NUM2"; break; } //Numeric keypad 2 key
	    case $63: { _device = -1; _key = "NUM3"; break; } //Numeric keypad 3 key
	    case $64: { _device = -1; _key = "NUM4"; break; } //Numeric keypad 4 key
	    case $65: { _device = -1; _key = "NUM5"; break; } //Numeric keypad 5 key
	    case $66: { _device = -1; _key = "NUM6"; break; } //Numeric keypad 6 key
	    case $67: { _device = -1; _key = "NUM7"; break; } //Numeric keypad 7 key
	    case $68: { _device = -1; _key = "NUM8"; break; } //Numeric keypad 8 key
	    case $69: { _device = -1; _key = "NUM9"; break; } //Numeric keypad 9 key
	    case $6A: { _device = -1; _key = "*"; break; } //Multiply key
	    case $6B: { _device = -1; _key = "+"; break; } //Add key
	    case $6C: { _device = -1; _key = "SEP"; break; } //Separator key
	    case $6D: { _device = -1; _key = "-"; break; } //Subtract key
	    case $6E: { _device = -1; _key = ","; break; } //Decimal key
	    case $6F: { _device = -1; _key = "/"; break; } //Divide key
	    case $70: { _device = -1; _key = "F1"; break; } //F1 key
	    case $71: { _device = -1; _key = "F2"; break; } //F2 key
	    case $72: { _device = -1; _key = "F3"; break; } //F3 key
	    case $73: { _device = -1; _key = "F4"; break; } //F4 key
	    case $74: { _device = -1; _key = "F5"; break; } //F5 key
	    case $75: { _device = -1; _key = "F6"; break; } //F6 key
	    case $76: { _device = -1; _key = "F7"; break; } //F7 key
	    case $77: { _device = -1; _key = "F8"; break; } //F8 key
	    case $78: { _device = -1; _key = "F9"; break; } //F9 key
	    case $79: { _device = -1; _key = "F10"; break; } //F10 key
	    case $7A: { _device = -1; _key = "F11"; break; } //F11 key
	    case $7B: { _device = -1; _key = "F12"; break; } //F12 key
	    case $7C: { _device = -1; _key = "F13"; break; } //F13 key
	    case $7D: { _device = -1; _key = "F14"; break; } //F14 key
	    case $7E: { _device = -1; _key = "F15"; break; } //F15 key
	    case $7F: { _device = -1; _key = "F16"; break; } //F16 key
	    case $80: { _device = -1; _key = "F17"; break; } //F17 key
	    case $81: { _device = -1; _key = "F18"; break; } //F18 key
	    case $82: { _device = -1; _key = "F19"; break; } //F19 key
	    case $83: { _device = -1; _key = "F20"; break; } //F20 key
	    case $84: { _device = -1; _key = "F21"; break; } //F21 key
	    case $85: { _device = -1; _key = "F22"; break; } //F22 key
	    case $86: { _device = -1; _key = "F23"; break; } //F23 key
	    case $87: { _device = -1; _key = "F24"; break; } //F24 key
	    case $90: { _device = -1; _key = "NUMLOCK"; break; } //NUM LOCK key
	    case $91: { _device = -1; _key = "SCROLL"; break; } //SCROLL LOCK key
	    case $A0: { _device = -1; _key = "LSHIFT"; break; } //Left SHIFT key
	    case $A1: { _device = -1; _key = "RSHIFT"; break; } //Right SHIFT key
	    case $A2: { _device = -1; _key = "LCTRL"; break; } //Left CONTROL key
	    case $A3: { _device = -1; _key = "RCTRL"; break; } //Right CONTROL key
	    case $A4: { _device = -1; _key = "LALT"; break; } //Left MENU key
	    case $A5: { _device = -1; _key = "RALT"; break; } //Right MENU key
	    case $A6: { _device = -1; _key = "BRBACK"; break; } //Windows 2000/XP: { return ""; } Browser Back key
	    case $A7: { _device = -1; _key = "BRFORWARD"; break; } //Windows 2000/XP: { return ""; } Browser Forward key
	    case $A8: { _device = -1; _key = "BRREFRESH"; break; } //Windows 2000/XP: { return ""; } Browser Refresh key
	    case $A9: { _device = -1; _key = "BRSTOP"; break; } //Windows 2000/XP: { return ""; } Browser Stop key
	    case $AA: { _device = -1; _key = "BRSEARCH"; break; } //Windows 2000/XP: { return ""; } Browser Search key
	    case $AB: { _device = -1; _key = "BRFAVORITES"; break; } //Windows 2000/XP: { return ""; } Browser Favorites key
	    case $AC: { _device = -1; _key = "BRHOME"; break; } //Windows 2000/XP: { return ""; } Browser Start and Home key
	    case $AD: { _device = -1; _key = "VOLMUTE"; break; } //Windows 2000/XP: { return ""; } Volume Mute key
	    case $AE: { _device = -1; _key = "VOLDOWN"; break; } //Windows 2000/XP: { return ""; } Volume Down key
	    case $AF: { _device = -1; _key = "VOLUP"; break; } //Windows 2000/XP: { return ""; } Volume Up key
	    case $B0: { _device = -1; _key = "MEDNEXT"; break; } //Windows 2000/XP: { return ""; } Next Track key
	    case $B1: { _device = -1; _key = "MEDPREV"; break; } //Windows 2000/XP: { return ""; } Previous Track key
	    case $B2: { _device = -1; _key = "MEDSTOP"; break; } //Windows 2000/XP: { return ""; } Stop Media key
	    case $B3: { _device = -1; _key = "MEDPLAY"; break; } //Windows 2000/XP: { return ""; } Play/Pause Media key
	    case $B4: { _device = -1; _key = "MAIL"; break; } //Windows 2000/XP: { return ""; } Start Mail key
	    case $B5: { _device = -1; _key = "MEDIA"; break; } //Windows 2000/XP: { return ""; } Select Media key
	    case $B6: { _device = -1; _key = "APP1"; break; } //Windows 2000/XP: { return ""; } Start Application 1 key
	    case $B7: { _device = -1; _key = "APP2"; break; } //Windows 2000/XP: { return ""; } Start Application 2 key
	    case $BA: { _device = -1; _key = ":"; break; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $BB: { _device = -1; _key = "+"; break; } //Windows 2000/XP: { return ""; } For any country/region, the '+' key
	    case $BC: { _device = -1; _key = ","; break; } //Windows 2000/XP: { return ""; } For any country/region, the ',' key
	    case $BD: { _device = -1; _key = "-"; break; } //Windows 2000/XP: { return ""; } For any country/region, the '-' key
	    case $BE: { _device = -1; _key = "."; break; } //Windows 2000/XP: { return ""; } For any country/region, the '.' key
	    case $BF: { _device = -1; _key = "?"; break; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $C0: { _device = -1; _key = "~"; break; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $DB: { _device = -1; _key = "["; break; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $DC: { _device = -1; _key = "\\"; break; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $DD: { _device = -1; _key = "]"; break; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $DE: { _device = -1; _key = "'"; break; } //Used for miscellaneous characters; it can vary by keyboard.
	    case $E5: { _device = -1; _key = "PROCESS"; break; } //Windows 95/98/Me, Windows NT 4.0, Windows 2000/XP: { return ""; } IME PROCESS key
	    case $E7: { _device = -1; _key = "PACKET"; break; } //Windows 2000/XP: { return ""; } Used to pass Unicode characters as if they were keystrokes. The PACKET key is the low word of a 32-bit Virtual Key value used for non-keyboard input methods. For more information, see Remark in KEYBDINPUT, SendInput, WM_KEYDOWN, and WM_KEYUP
	    case $F6: { _device = -1; _key = "ATTN"; break; } //Attn key  
	    case $F7: { _device = -1; _key = "CRSEL"; break; } //CrSel key  
	    case $F8: { _device = -1; _key = "EXSEL"; break; } //ExSel key  
	    case $F9: { _device = -1; _key = "EREOF"; break; } //Erase EOF key  
	    case $FA: { _device = -1; _key = "PLAY"; break; } //Play key  
	    case $FB: { _device = -1; _key = "ZOOM"; break; } //Zoom key  
	    case $FD: { _device = -1; _key = "PA1"; break; } //PA1 key  
	    case $FE: { _device = -1; _key = "CLEAR"; break; } //Clear key
		case gp_face1: { _device = 0; _key = "A"; break; }
		case gp_face2: { _device = 0; _key = "B"; break; }
		case gp_face3: { _device = 0; _key = "X"; break; }
		case gp_face4: { _device = 0; _key = "Y"; break; }
		case gp_shoulderl: { _device = 0; _key = "LB"; break; }
		case gp_shoulderr: { _device = 0; _key = "RB"; break; }
		case gp_shoulderlb: { _device = 0; _key = "LT"; break; }
		case gp_shoulderrb: { _device = 0; _key = "RT"; break; }
		case gp_select: { _device = 0; _key = "SELECT"; break; }
		case gp_start: { _device = 0; _key = "START"; break; }
		case gp_stickl: { _device = 0; _key = "L STICK"; break; }
		case gp_stickr: { _device = 0; _key = "R STICK"; break; }
		case gp_padu: { _device = 0; _key = "DPAD UP"; break; }
		case gp_padd: { _device = 0; _key = "DPAD DOWN"; break; }
		case gp_padl: { _device = 0; _key = "DPAD LEFT"; break; }
		case gp_padr: { _device = 0; _key = "DPAD RIGHT"; break; }
		case input_axislu: { _device = 0; _key = "L AXIS UP"; break; }
		case input_axisld: { _device = 0; _key = "L AXIS DOWN"; break; }
		case input_axisll: { _device = 0; _key = "L AXIS LEFT"; break; }
		case input_axislr: { _device = 0; _key = "L AXIS RIGHT"; break; }
		case input_axisru: { _device = 0; _key = "R AXIS UP"; break; }
		case input_axisrd: { _device = 0; _key = "R AXIS DOWN"; break; }
		case input_axisrl: { _device = 0; _key = "R AXIS LEFT"; break; }
		case input_axisrr: { _device = 0; _key = "R AXIS RIGHT"; break; }
		case input_mouse_wheel_down: { return "Wheel Down"; }
		case input_mouse_wheel_up: { return "Wheel Up"; }

	    default: { _device = 0; _key = "UNSUPPORTED"; break; }
	}
	
	if ( _device == -1 ) {
		// Keyboard sprite
		switch ( keycode ) {
			case mb_left:
				return [spr_ui_mouse_left,""];
			break;
			
			case mb_right:
				return [spr_ui_mouse_right,""];
			break;
			
			case mb_middle:
				return [spr_ui_mouse_middle,""];
			break;
		}
		
		var _font = draw_get_font();
		draw_set_font(fnt_buttons);
		var _str_width = string_width(_key);
		draw_set_font(_font);
		if ( _str_width <= sprite_get_width(spr_ui_keyboard_small) - 4 ) {
			return [spr_ui_keyboard_small,_key];
		} else if ( _str_width <= sprite_get_width(spr_ui_keyboard_medium) - 4 ) {
			return [spr_ui_keyboard_medium,_key];
		}
		
		return [spr_ui_keyboard_large,_key];
	} else {
		// Gamepad sprite
		if ( global.device_type >= 0 && global.device_type < InputDeviceType.Size ) {
			var _result = global.Device_Sprite_Data[global.device_type][? keycode];
			if ( _result != undefined ) {
				return [_result,_key];
			} else {
				return [spr_empty,_key];
			}
		}
		return [spr_empty,_key];
	}
}

function input_action_device_get_keycode(action) {
	//var _list = input_action_get_key(action);
	if ( global.device_current == -1 ) {
		return input_action_get_key(action)[|!global.mouse_enabled];
	} else {
		return input_action_get_key(action)[|2];
	}
}

function input_action_device_get_sprite(action) {
	return input_get_sprite_keycode(
		input_action_device_get_keycode(action)
	);
}

function input_action_check(action) {
	if (global.input_action_events[action][Event.Down] != -1){
		return global.input_action_events[action][Event.Down]
	}
	
	var _key_list = input_action_get_key(action);
	var _func_list = input_action_get_functions(action);
	
	var i = 0;
	repeat ( ds_list_size(_key_list) ) {
		var _func_struct = _func_list[| i];
		var _key = _key_list[| i];
		
		var _val = _func_list[| i].check(_key_list[| i])
		if ( _val > 0 ) {
			global.input_held_timers[action] += 1;
			global.input_action_events[action][Event.Down] = _val;
			return _val;
		}
		i++;
	}
	
	global.input_held_timers[action] = 0;
	global.input_action_events[action][Event.Down] = false;
	return false;
}

function input_action_check_pressed(action) {
	if (global.input_action_events[action][Event.Pressed] != -1){
		return global.input_action_events[action][Event.Pressed]
	}
	
	var _key_list = input_action_get_key(action);
	var _func_list = input_action_get_functions(action);
	
	var i = 0;
	repeat ( ds_list_size(_key_list) ) {
		var _func_struct = _func_list[| i];
		var _key = _key_list[| i];
		
		var _val = _func_list[| i].check_pressed(_key_list[| i])
		if ( _val > 0 ) {
			global.input_action_events[action][Event.Pressed] = _val;
			return _val;
		}
		i++;
	}
	
	global.input_action_events[action][Event.Pressed] = false;
	return false;
}

function input_action_check_released(action) {
	if (global.input_action_events[action][Event.Released] != -1){
		return global.input_action_events[action][Event.Released]
	}
	
	var _key_list = input_action_get_key(action);
	var _func_list = input_action_get_functions(action);
	
	var i = 0;
	repeat ( ds_list_size(_key_list) ) {
		var _func_struct = _func_list[| i];
		var _key = _key_list[| i];
		
		var _val = _func_list[| i].check_released(_key_list[| i])
		if ( _val > 0 ) {
			global.input_held_timers[action] = 0;
			global.input_action_events[action][Event.Released] = _val;
			return _val;
		}
		i++;
	}
	
	global.input_action_events[action][Event.Released] = false;
	return false;
}

function input_action_check_held(action) {
	if (input_action_check(action)){
		return global.input_held_timers[action]
	}
	else{
		global.input_held_timers[action] = 0;
	}
	return global.input_held_timers[action]
}

function input_action_check_axis(action) {
	if (!input_gamepad_exists()){return false;}
	
	var
	_list = input_action_get_key(action),
	_axis_value = 0;

	var i = 0;
	repeat ( ds_list_size(_list) ) {
		_axis_value += input_check_axis(_list[| i ++]);
	}

	if ( abs(_axis_value) > 0.4 ) {
		_axis_value = sign(_axis_value);
	}

	return _axis_value;
}

function input_action_check_axis_pressed(action) {
	if (!input_gamepad_exists()){return false;}
	
	var _list = input_action_get_key(action);

	var i = 0;
	repeat ( ds_list_size(_list) ) {
		if ( input_check_axis_pressed(_list[| i ++]) ) {
			return true;
		}
	}

	return false;
}

function input_action_check_axis_held(action) {
	if (!input_gamepad_exists()){return false;}
	
	var _list = input_action_get_key(action);

	var i = 0;
	repeat ( ds_list_size(_list) ) {
		if ( input_check_axis_held(_list[| i ++]) ) {
			return true;
		}
	}

	return false;
}

function input_action_check_axis_released(action) {
	if (!input_gamepad_exists()){return false;}
	
	var _list = input_action_get_key(action);

	var i = 0;
	repeat ( ds_list_size(_list) ) {
		if ( input_check_axis_released(_list[| i ++]) ) {
			return true;
		}
	}

	return false;
}

function input_device_get_any_pressed() {
	for ( var i = 0; i < ds_list_size(global.input_device_list); ++ i; ) {
		if ( input_device_check_any_pressed(global.input_device_list[| i]) ) {
			return global.input_device_list[| i];
		}
	}

	return noone;
}

function input_action_assign_key(action,keys) {
	// Assign keys to our action
	for ( var i = 1; i < argument_count; ++ i; ) {
		ds_list_add(global.input_action_list[action],argument[i]);
		
		//assign the type
		var keycode = argument[i];
		var _func = key_get_function_struct(keycode);
		ds_list_add(global.input_action_function_list[action],_func);
	}

	return true;
}

function input_action_get_key(action) {
	return global.input_action_list[action];
}

function input_action_get_functions(action) {
	return global.input_action_function_list[action];
}

function input_action_remove_key(action,keys) {
	// Remove keys from our action
	for ( var _index, i = 1; i < argument_count; ++ i; ) {
		_index = ds_list_find_index(global.input_action_list[action],argument[i]);
		if ( _index != -1 ) {
			ds_list_delete(global.input_action_list[action],_index);
		}
	}
}

function input_action_remove_all(action) {
	ds_list_clear(global.input_action_list[action]);
}

function input_clear_set(enable) {
	global.input_ignore = enable;
}

function input_is_keyboard_key(keycode) {
	switch ( keycode ) {
	    case $00:
	    case mb_left:
	    case mb_right:
	    case mb_middle:
	    case $05:
	    case $06:
	    case $08:
	    case $09:
	    case $0C:
	    case $0D:
	    case $10:
	    case $11:
	    case $12:
	    case $13:
	    case $14:
	    case $15:
	    case $17:
	    case $18:
	    case $19:
	    case $1B:
	    case $1C:
	    case $1D:
	    case $1E:
	    case $1F:
	    case $20:
	    case $21:
	    case $22:
	    case $23:
	    case $24:
	    case $25:
	    case $26:
	    case $27:
	    case $28:
	    case $29:      
	    case $2A:
	    case $2B:
	    case $2C:
	    case $2D:
	    case $2E:
	    case $2F:
	    case $30:
	    case $31:
	    case $32:
	    case $33:
	    case $34:
	    case $35:
	    case $36:
	    case $37:
	    case $38:
	    case $39:
	    case $41:
	    case $42:
	    case $43:
	    case $44:
	    case $45:
	    case $46:
	    case $47:
	    case $48:
	    case $49:
	    case $4A:
	    case $4B:
	    case $4C:
	    case $4D:
	    case $4E:
	    case $4F:
	    case $50:
	    case $51:
	    case $52:
	    case $53:
	    case $54:
	    case $55:
	    case $56:
	    case $57:
	    case $58:
	    case $59:
	    case $5A:
	    case $5B:
	    case $5C:
	    case $5D:
	    case $5F:
	    case $60:
	    case $61:
	    case $62:
	    case $63:
	    case $64:
	    case $65:
	    case $66:
	    case $67:
	    case $68:
	    case $69:
	    case $6A:
	    case $6B:
	    case $6C:
	    case $6D:
	    case $6E:
	    case $6F:
	    case $70:
	    case $71:
	    case $72:
	    case $73:
	    case $74:
	    case $75:
	    case $76:
	    case $77:
	    case $78:
	    case $79:
	    case $7A:
	    case $7B:
	    case $7C:
	    case $7D:
	    case $7E:
	    case $7F:
	    case $80:
	    case $81:
	    case $82:
	    case $83:
	    case $84:
	    case $85:
	    case $86:
	    case $87:
	    case $90:
	    case $91:
	    case $A0:
	    case $A1:
	    case $A2:
	    case $A3:
	    case $A4:
	    case $A5:
	    case $A6:
	    case $A7:
	    case $A8:
	    case $A9:
	    case $AA:
	    case $AB:
	    case $AC:
	    case $AD:
	    case $AE:
	    case $AF:
	    case $B0:
	    case $B1:
	    case $B2:
	    case $B3:
	    case $B4:
	    case $B5:
	    case $B6:
	    case $B7:
	    case $BA:
	    case $BB:
	    case $BC:
	    case $BD:
	    case $BE:
	    case $BF:
	    case $C0:
	    case $DB:
	    case $DC:
	    case $DD:
	    case $DE:
	    case $E5:
	    case $E7:
	    case $F6:
	    case $F7:
	    case $F8:
	    case $F9:
	    case $FA:
	    case $FB:
	    case $FD:
	    case $FE:
		return true;
		break;

	    default:
		return false;
		break;
	}
}

function input_mouse_check_area(x1,y1,x2,y2) {
	return ( global.mouse_enabled && mouse_x >= x1 && mouse_y >= y1 && mouse_x <= x2 && mouse_y <= y2 );
}

function input_mouse_check_area_gui(x1,y1,x2,y2) {
	return ( global.mouse_enabled && device_mouse_x_to_gui(0) >= x1 && device_mouse_y_to_gui(0) >= y1 && device_mouse_x_to_gui(0) <= x2 && device_mouse_y_to_gui(0) <= y2 );
}
	
function input_device_get_type_name(device) {
	show_debug_message(gamepad_get_description(device));
}
	
function input_device_get_type(device) {
	enum InputDeviceType {
		Keyboard,
		Xbox,
		Ps4,
		Size
	}
	
	if ( device == -1 ) {
		return InputDeviceType.Keyboard;
	} else {
		var _device_name = string_lower(gamepad_get_description(device));
		if ( string_pos("xinput",_device_name) ) {
			return InputDeviceType.Xbox;
		} else if ( string_pos("dualshock",_device_name) ) {
			return InputDeviceType.Ps4;
		}
	}
}

function key_get_type(_key){
	if ((_key <= mb_side2) && (_key >= mb_left)) || (mb_any){
		return input_type.mouse;
	}
	if (_key == 0){ // vk_nokey and mb_none
		return input_type.none;
	}
	if ( _key >= input_axislu && _key <= input_axisrr ){
		return input_type.axis;
	}
	if ( _key >= input_mouse_wheel_up && _key <= input_mouse_wheel_down ) || (_key = input_mouse_special){
		return input_type.wheel;
	}
	if (_key >= gp_face1) && (_key <= gp_padr){
		return input_type.face;
	}
	
	return input_type.keyboard;
	
}

function key_get_function_struct(_key){
	//mouse
	if ((_key <= mb_side2) && (_key >= mb_left)) || (mb_any){
		return {
			check: mouse_check_button,
			check_pressed: mouse_check_button_pressed,
			check_released: mouse_check_button_released,
		}
	}
	//none
	if (_key == 0){ // vk_nokey and mb_none
		return {
			type: "none",
			check: function() {return (keyboard_check(0)||mouse_check_button(0))},
			check_pressed: function() {return (keyboard_check_pressed(0)||mouse_check_button_pressed(0))},
			check_released: function() {return (keyboard_check_released(0)||mouse_check_button_released(0))},
		}
	}
	//axis
	if ( _key >= input_axislu && _key <= input_axisrr ){
		return {
			type: "axis",
			check: input_check_axis,
			check_pressed: input_check_axis_pressed,
			check_released: input_check_axis_released,
		}
	}
	//wheel
	if ( _key >= input_mouse_wheel_up && _key <= input_mouse_wheel_down ) || (_key = input_mouse_special){
		return {
			type: "wheel",
			check: function(){return false},
			check_pressed: function(_key){
					switch ( _key ) {
						case input_mouse_wheel_up:
							return mouse_wheel_up();
						break;
			
						case input_mouse_wheel_down:
							return mouse_wheel_down();
						break;
					}
			},
			check_released: function(){return false},
		}
	}
	//face
	if (_key >= gp_face1) && (_key <= gp_padr){
		return {
			type: "face",
			check: function(_key) { return gamepad_all_devices_check(_key) },
			check_pressed: function(_key) { return gamepad_all_devices_check_pressed(_key) },
			check_released: function(_key) { return gamepad_all_devices_check_released(_key) },
		}
	}
	
	return {
			type: "keyboard",
			check: keyboard_check,
			check_pressed: keyboard_check_pressed,
			check_released: keyboard_check_released,
		}
	
}

function key_to_string(_key){
	switch (_key){
		case mb_any: return "mb_any" break;
		case vk_nokey: return "[vk_nokey, mb_none]" break;
		//case vk_anykey: return "vk_anykey" break;
		case mb_left: return "mb_left" break;
		case mb_right: return "mb_right" break;
		case mb_middle: return "mb_middle" break;
		case mb_side1: return "mb_side1" break;
		case mb_side2: return "mb_side2" break;
		case vk_backspace: return "vk_backspace" break;
		case vk_tab: return "vk_tab" break;
		case vk_enter: return "vk_enter" break;
		case vk_shift: return "vk_shift" break;
		case vk_control: return "vk_control" break;
		case vk_alt: return "vk_alt" break;
		case vk_pause: return "vk_pause" break;
		case vk_escape: return "vk_escape" break;
		case vk_space: return "vk_space" break;
		case vk_pageup: return "vk_pageup" break;
		case vk_pagedown: return "vk_pagedown" break;
		case vk_end: return "vk_end" break;
		case vk_home: return "vk_home" break;
		case vk_left: return "vk_left" break;
		case vk_up: return "vk_up" break;
		case vk_right: return "vk_right" break;
		case vk_down: return "vk_down" break;
		case vk_printscreen: return "vk_printscreen" break;
		case vk_insert: return "vk_insert" break;
		case vk_delete: return "vk_delete" break;
		case ord("0"): return "0" break;
		case ord("1"): return "1" break;
		case ord("2"): return "2" break;
		case ord("3"): return "3" break;
		case ord("4"): return "4" break;
		case ord("5"): return "5" break;
		case ord("6"): return "6" break;
		case ord("7"): return "7" break;
		case ord("8"): return "8" break;
		case ord("9"): return "9" break;
		case ord("A"): return "A" break;
		case ord("B"): return "B" break;
		case ord("C"): return "C" break;
		case ord("D"): return "D" break;
		case ord("E"): return "E" break;
		case ord("F"): return "F" break;
		case ord("G"): return "G" break;
		case ord("H"): return "H" break;
		case ord("I"): return "I" break;
		case ord("J"): return "J" break;
		case ord("K"): return "K" break;
		case ord("L"): return "L" break;
		case ord("M"): return "M" break;
		case ord("N"): return "N" break;
		case ord("O"): return "O" break;
		case ord("P"): return "P" break;
		case ord("Q"): return "Q" break;
		case ord("R"): return "R" break;
		case ord("S"): return "S" break;
		case ord("T"): return "T" break;
		case ord("U"): return "U" break;
		case ord("V"): return "V" break;
		case ord("W"): return "W" break;
		case ord("X"): return "X" break;
		case ord("Y"): return "Y" break;
		case ord("Z"): return "Z" break;
		case vk_numpad0: return "vk_numpad0" break;
		case vk_numpad1: return "vk_numpad1" break;
		case vk_numpad2: return "vk_numpad2" break;
		case vk_numpad3: return "vk_numpad3" break;
		case vk_numpad4: return "vk_numpad4" break;
		case vk_numpad5: return "vk_numpad5" break;
		case vk_numpad6: return "vk_numpad6" break;
		case vk_numpad7: return "vk_numpad7" break;
		case vk_numpad8: return "vk_numpad8" break;
		case vk_numpad9: return "vk_numpad9" break;
		case vk_multiply: return "vk_multiply" break;
		case vk_add: return "vk_add" break;
		case vk_subtract: return "vk_subtract" break;
		case vk_decimal: return "vk_decimal" break;
		case vk_divide: return "vk_divide" break;
		case vk_f1: return "vk_f1" break;
		case vk_f2: return "vk_f2" break;
		case vk_f3: return "vk_f3" break;
		case vk_f4: return "vk_f4" break;
		case vk_f5: return "vk_f5" break;
		case vk_f6: return "vk_f6" break;
		case vk_f7: return "vk_f7" break;
		case vk_f8: return "vk_f8" break;
		case vk_f9: return "vk_f9" break;
		case vk_f10: return "vk_f10" break;
		case vk_f11: return "vk_f11" break;
		case vk_f12: return "vk_f12" break;
		case vk_lshift: return "vk_lshift" break;
		case vk_rshift: return "vk_rshift" break;
		case vk_lcontrol: return "vk_lcontrol" break;
		case vk_rcontrol: return "vk_rcontrol" break;
		case vk_lalt: return "vk_lalt" break;
		case vk_ralt: return "vk_ralt" break;
		case gp_face1: return "gp_face1" break;
		case gp_face2: return "gp_face2" break;
		case gp_face3: return "gp_face3" break;
		case gp_face4: return "gp_face4" break;
		case gp_shoulderl: return "gp_shoulderl" break;
		case gp_shoulderr: return "gp_shoulderr" break;
		case gp_shoulderlb: return "gp_shoulderlb" break;
		case gp_shoulderrb: return "gp_shoulderrb" break;
		case gp_select: return "gp_select" break;
		case gp_start: return "gp_start" break;
		case gp_stickl: return "gp_stickl" break;
		case gp_stickr: return "gp_stickr" break;
		case gp_padu: return "gp_padu" break;
		case gp_padd: return "gp_padd" break;
		case gp_padl: return "gp_padl" break;
		case gp_padr: return "gp_padr" break;
		case gp_axislh: return "gp_axislh" break;
		case gp_axislv: return "gp_axislv" break;
		case gp_axisrh: return "gp_axisrh" break;
		case gp_axisrv: return "gp_axisrv" break;
		case gp_axis_acceleration_x: return "gp_axis_acceleration_x" break;
		case gp_axis_acceleration_y: return "gp_axis_acceleration_y" break;
		case gp_axis_acceleration_z: return "gp_axis_acceleration_z" break;
		case gp_axis_angular_velocity_x: return "gp_axis_angular_velocity_x" break;
		case gp_axis_angular_velocity_y: return "gp_axis_angular_velocity_y" break;
		case gp_axis_angular_velocity_z: return "gp_axis_angular_velocity_z" break;
		case gp_axis_orientation_x: return "gp_axis_orientation_x" break;
		case gp_axis_orientation_y: return "gp_axis_orientation_y" break;
		case gp_axis_orientation_z: return "gp_axis_orientation_z" break;
		case gp_axis_orientation_w: return "gp_axis_orientation_w" break;
	}
}

function input_gamepad_is_connected(_device){
	if (array_length(global.input_gamepad_connected_val) <= _device)
	|| (global.input_gamepad_connected_val[_device] == -1){
		global.input_gamepad_connected_val[_device] = gamepad_is_connected(_device);
	}
	return global.input_gamepad_connected_val[_device];
}

function input_gamepad_exists(){
	if (global.input_gamepad_exists == -1){
		var _has_gamepad = false
		var i = 0; var _size = ds_list_size(global.input_device_list)
		repeat(_size){
			var _device = global.input_device_list[| i];
			if (_device != -1)
			&& (input_gamepad_is_connected(_device)) {
				global.input_gamepad_exists = true;
				return true;
			}
		}
		global.input_gamepad_exists = false;
	}
	return global.input_gamepad_exists;
}

function gamepad_all_devices_check(_key){
	if (!input_gamepad_exists()){return false;}
	
	var i = 0;
	repeat ( ds_list_size(global.input_device_list) ) {
		var _device = global.input_device_list[| i];
		if (_device != -1)
		&& (input_gamepad_is_connected(_device)) {
			return gamepad_button_check(_device, _key);
		}
		++ i;
	}

	return 0;
}

function gamepad_all_devices_check_pressed(_key){
	if (!input_gamepad_exists()){return false;}
	
	var i = 0;
	repeat ( ds_list_size(global.input_device_list) ) {
		var _device = global.input_device_list[| i];
		if (_device != -1)
		&& (input_gamepad_is_connected(_device)) {
			return gamepad_button_check_pressed(_device, _key);
		}
		++ i;
	}

	return 0;
}

function gamepad_all_devices_check_released(_key){
	if (!input_gamepad_exists()){return false;}
	
	var i = 0;
	repeat ( ds_list_size(global.input_device_list) ) {
		var _device = global.input_device_list[| i];
		if (_device != -1)
		&& (input_gamepad_is_connected(_device)) {
			return gamepad_button_check_released(_device, _key);
		}
		++ i;
	}

	return 0;
}
