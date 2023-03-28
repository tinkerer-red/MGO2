#region Macros
	#region event_type
		#macro EVENT_TYPE_EV_CREATE "ev_create"
		#macro EVENT_TYPE_EV_DESTROY "ev_destroy"
		#macro EVENT_TYPE_EV_STEP "ev_step"
		#macro EVENT_TYPE_EV_ALARM "ev_alarm"
		#macro EVENT_TYPE_EV_KEYBOARD "ev_keyboard"
		#macro EVENT_TYPE_EV_KEYPRESS "ev_keypress"
		#macro EVENT_TYPE_EV_KEYRELEASE "ev_keyrelease"
		#macro EVENT_TYPE_EV_MOUSE "ev_mouse"
		#macro EVENT_TYPE_EV_COLLISION "ev_collision"
		#macro EVENT_TYPE_EV_OTHER "ev_other"
		#macro EVENT_TYPE_EV_GESTURE "ev_gesture"
		#macro EVENT_TYPE_EV_DRAW "ev_draw"
	#endregion
	#region event_number
		#macro EVENT_NUMBER_0 "0"
		#macro EVENT_NUMBER_1 "1"
		#macro EVENT_NUMBER_2 "2"
		#macro EVENT_NUMBER_3 "3"
		#macro EVENT_NUMBER_4 "4"
		#macro EVENT_NUMBER_5 "5"
		#macro EVENT_NUMBER_6 "6"
		#macro EVENT_NUMBER_7 "7"
		#macro EVENT_NUMBER_8 "8"
		#macro EVENT_NUMBER_9 "9"
		#macro EVENT_NUMBER_10 "10"
		#macro EVENT_NUMBER_11 "11"
		#macro EVENT_NUMBER_EV_ANIMATION_END "ev_animation_end"
		#macro EVENT_NUMBER_EV_ANIMATION_EVENT "ev_animation_event"
		#macro EVENT_NUMBER_EV_ANIMATION_UPDATE "ev_animation_update"
		#macro EVENT_NUMBER_EV_BOUNDARY "ev_boundary"
		#macro EVENT_NUMBER_EV_BOUNDARY_VIEW0 "ev_boundary_view0"
		#macro EVENT_NUMBER_EV_BOUNDARY_VIEW1 "ev_boundary_view1"
		#macro EVENT_NUMBER_EV_BOUNDARY_VIEW2 "ev_boundary_view2"
		#macro EVENT_NUMBER_EV_BOUNDARY_VIEW3 "ev_boundary_view3"
		#macro EVENT_NUMBER_EV_BOUNDARY_VIEW4 "ev_boundary_view4"
		#macro EVENT_NUMBER_EV_BOUNDARY_VIEW5 "ev_boundary_view5"
		#macro EVENT_NUMBER_EV_BOUNDARY_VIEW6 "ev_boundary_view6"
		#macro EVENT_NUMBER_EV_BOUNDARY_VIEW7 "ev_boundary_view7"
		#macro EVENT_NUMBER_EV_BROADCAST_MESSAGE "ev_broadcast_message"
		#macro EVENT_NUMBER_EV_DRAW_BEGIN "ev_draw_begin"
		#macro EVENT_NUMBER_EV_DRAW_END "ev_draw_end"
		#macro EVENT_NUMBER_EV_DRAW_NORMAL "ev_draw_normal"
		#macro EVENT_NUMBER_EV_DRAW_POST "ev_draw_post"
		#macro EVENT_NUMBER_EV_DRAW_PRE "ev_draw_pre"
		#macro EVENT_NUMBER_EV_END_OF_PATH "ev_end_of_path"
		#macro EVENT_NUMBER_EV_GAME_END "ev_game_end"
		#macro EVENT_NUMBER_EV_GAME_START "ev_game_start"
		#macro EVENT_NUMBER_EV_GESTURE_DOUBLE_TAP "ev_gesture_double_tap"
		#macro EVENT_NUMBER_EV_GESTURE_DRAG_END "ev_gesture_drag_end"
		#macro EVENT_NUMBER_EV_GESTURE_DRAG_START "ev_gesture_drag_start"
		#macro EVENT_NUMBER_EV_GESTURE_DRAGGING "ev_gesture_dragging"
		#macro EVENT_NUMBER_EV_GESTURE_FLICK "ev_gesture_flick"
		#macro EVENT_NUMBER_EV_GESTURE_PINCH_END "ev_gesture_pinch_end"
		#macro EVENT_NUMBER_EV_GESTURE_PINCH_IN "ev_gesture_pinch_in"
		#macro EVENT_NUMBER_EV_GESTURE_PINCH_OUT "ev_gesture_pinch_out"
		#macro EVENT_NUMBER_EV_GESTURE_PINCH_START "ev_gesture_pinch_start"
		#macro EVENT_NUMBER_EV_GESTURE_ROTATE_END "ev_gesture_rotate_end"
		#macro EVENT_NUMBER_EV_GESTURE_ROTATE_START "ev_gesture_rotate_start"
		#macro EVENT_NUMBER_EV_GESTURE_ROTATING "ev_gesture_rotating"
		#macro EVENT_NUMBER_EV_GESTURE_TAP "ev_gesture_tap"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_DOUBLE_TAP "ev_global_gesture_double_tap"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_DRAG_END "ev_global_gesture_drag_end"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_DRAG_START "ev_global_gesture_drag_start"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_DRAGGING "ev_global_gesture_dragging"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_FLICK "ev_global_gesture_flick"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_PINCH_END "ev_global_gesture_pinch_end"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_PINCH_IN "ev_global_gesture_pinch_in"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_PINCH_OUT "ev_global_gesture_pinch_out"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_PINCH_START "ev_global_gesture_pinch_start"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_ROTATE_END "ev_global_gesture_rotate_end"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_ROTATE_START "ev_global_gesture_rotate_start"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_ROTATING "ev_global_gesture_rotating"
		#macro EVENT_NUMBER_EV_GLOBAL_GESTURE_TAP "ev_global_gesture_tap"
		#macro EVENT_NUMBER_EV_GLOBAL_LEFT_BUTTON "ev_global_left_button"
		#macro EVENT_NUMBER_EV_GLOBAL_LEFT_PRESS "ev_global_left_press"
		#macro EVENT_NUMBER_EV_GLOBAL_LEFT_RELEASE "ev_global_left_release"
		#macro EVENT_NUMBER_EV_GLOBAL_MIDDLE_BUTTON "ev_global_middle_button"
		#macro EVENT_NUMBER_EV_GLOBAL_MIDDLE_PRESS "ev_global_middle_press"
		#macro EVENT_NUMBER_EV_GLOBAL_MIDDLE_RELEASE "ev_global_middle_release"
		#macro EVENT_NUMBER_EV_GLOBAL_RIGHT_BUTTON "ev_global_right_button"
		#macro EVENT_NUMBER_EV_GLOBAL_RIGHT_PRESS "ev_global_right_press"
		#macro EVENT_NUMBER_EV_GLOBAL_RIGHT_RELEASE "ev_global_right_release"
		#macro EVENT_NUMBER_EV_GUI "ev_gui"
		#macro EVENT_NUMBER_EV_GUI_BEGIN "ev_gui_begin"
		#macro EVENT_NUMBER_EV_GUI_END "ev_gui_end"
		#macro EVENT_NUMBER_EV_LEFT_BUTTON "ev_left_button"
		#macro EVENT_NUMBER_EV_LEFT_PRESS "ev_left_press"
		#macro EVENT_NUMBER_EV_LEFT_RELEASE "ev_left_release"
		#macro EVENT_NUMBER_EV_MIDDLE_BUTTON "ev_middle_button"
		#macro EVENT_NUMBER_EV_MIDDLE_PRESS "ev_middle_press"
		#macro EVENT_NUMBER_EV_MIDDLE_RELEASE "ev_middle_release"
		#macro EVENT_NUMBER_EV_MOUSE_ENTER "ev_mouse_enter"
		#macro EVENT_NUMBER_EV_MOUSE_LEAVE "ev_mouse_leave"
		#macro EVENT_NUMBER_EV_MOUSE_WHEEL_DOWN "ev_mouse_wheel_down"
		#macro EVENT_NUMBER_EV_MOUSE_WHEEL_UP "ev_mouse_wheel_up"
		#macro EVENT_NUMBER_EV_NO_BUTTON "ev_no_button"
		#macro EVENT_NUMBER_EV_OUTSIDE "ev_outside"
		#macro EVENT_NUMBER_EV_OUTSIDE_VIEW0 "ev_outside_view0"
		#macro EVENT_NUMBER_EV_OUTSIDE_VIEW1 "ev_outside_view1"
		#macro EVENT_NUMBER_EV_OUTSIDE_VIEW2 "ev_outside_view2"
		#macro EVENT_NUMBER_EV_OUTSIDE_VIEW3 "ev_outside_view3"
		#macro EVENT_NUMBER_EV_OUTSIDE_VIEW4 "ev_outside_view4"
		#macro EVENT_NUMBER_EV_OUTSIDE_VIEW5 "ev_outside_view5"
		#macro EVENT_NUMBER_EV_OUTSIDE_VIEW6 "ev_outside_view6"
		#macro EVENT_NUMBER_EV_OUTSIDE_VIEW7 "ev_outside_view7"
		#macro EVENT_NUMBER_EV_RIGHT_BUTTON "ev_right_button"
		#macro EVENT_NUMBER_EV_RIGHT_PRESS "ev_right_press"
		#macro EVENT_NUMBER_EV_RIGHT_RELEASE "ev_right_release"
		#macro EVENT_NUMBER_EV_ROOM_END "ev_room_end"
		#macro EVENT_NUMBER_EV_ROOM_START "ev_room_start"
		#macro EVENT_NUMBER_EV_STEP_BEGIN "ev_step_begin"
		#macro EVENT_NUMBER_EV_STEP_END "ev_step_end"
		#macro EVENT_NUMBER_EV_STEP_NORMAL "ev_step_normal"
		#macro EVENT_NUMBER_EV_USER0 "ev_user0"
		#macro EVENT_NUMBER_EV_USER1 "ev_user1"
		#macro EVENT_NUMBER_EV_USER10 "ev_user10"
		#macro EVENT_NUMBER_EV_USER11 "ev_user11"
		#macro EVENT_NUMBER_EV_USER12 "ev_user12"
		#macro EVENT_NUMBER_EV_USER13 "ev_user13"
		#macro EVENT_NUMBER_EV_USER14 "ev_user14"
		#macro EVENT_NUMBER_EV_USER15 "ev_user15"
		#macro EVENT_NUMBER_EV_USER2 "ev_user2"
		#macro EVENT_NUMBER_EV_USER3 "ev_user3"
		#macro EVENT_NUMBER_EV_USER4 "ev_user4"
		#macro EVENT_NUMBER_EV_USER5 "ev_user5"
		#macro EVENT_NUMBER_EV_USER6 "ev_user6"
		#macro EVENT_NUMBER_EV_USER7 "ev_user7"
		#macro EVENT_NUMBER_EV_USER8 "ev_user8"
		#macro EVENT_NUMBER_EV_USER9 "ev_user9"
		#macro EVENT_NUMBER_VK_ADD "vk_add"
		#macro EVENT_NUMBER_VK_ALT "vk_alt"
		#macro EVENT_NUMBER_VK_ANYKEY "vk_anykey"
		#macro EVENT_NUMBER_VK_BACKSPACE "vk_backspace"
		#macro EVENT_NUMBER_VK_CONTROL "vk_control"
		#macro EVENT_NUMBER_VK_DECIMAL "vk_decimal"
		#macro EVENT_NUMBER_VK_DELETE "vk_delete"
		#macro EVENT_NUMBER_VK_DIVIDE "vk_divide"
		#macro EVENT_NUMBER_VK_DOWN "vk_down"
		#macro EVENT_NUMBER_VK_END "vk_end"
		#macro EVENT_NUMBER_VK_ENTER "vk_enter"
		#macro EVENT_NUMBER_VK_ESCAPE "vk_escape"
		#macro EVENT_NUMBER_VK_F1 "vk_f1"
		#macro EVENT_NUMBER_VK_F10 "vk_f10"
		#macro EVENT_NUMBER_VK_F11 "vk_f11"
		#macro EVENT_NUMBER_VK_F12 "vk_f12"
		#macro EVENT_NUMBER_VK_F2 "vk_f2"
		#macro EVENT_NUMBER_VK_F3 "vk_f3"
		#macro EVENT_NUMBER_VK_F4 "vk_f4"
		#macro EVENT_NUMBER_VK_F5 "vk_f5"
		#macro EVENT_NUMBER_VK_F6 "vk_f6"
		#macro EVENT_NUMBER_VK_F7 "vk_f7"
		#macro EVENT_NUMBER_VK_F8 "vk_f8"
		#macro EVENT_NUMBER_VK_F9 "vk_f9"
		#macro EVENT_NUMBER_VK_HOME "vk_home"
		#macro EVENT_NUMBER_VK_INSERT "vk_insert"
		#macro EVENT_NUMBER_VK_LALT "vk_lalt"
		#macro EVENT_NUMBER_VK_LCONTROL "vk_lcontrol"
		#macro EVENT_NUMBER_VK_LEFT "vk_left"
		#macro EVENT_NUMBER_VK_LSHIFT "vk_lshift"
		#macro EVENT_NUMBER_VK_MULTIPLY "vk_multiply"
		#macro EVENT_NUMBER_VK_NOKEY "vk_nokey"
		#macro EVENT_NUMBER_VK_NUMPAD0 "vk_numpad0"
		#macro EVENT_NUMBER_VK_NUMPAD1 "vk_numpad1"
		#macro EVENT_NUMBER_VK_NUMPAD2 "vk_numpad2"
		#macro EVENT_NUMBER_VK_NUMPAD3 "vk_numpad3"
		#macro EVENT_NUMBER_VK_NUMPAD4 "vk_numpad4"
		#macro EVENT_NUMBER_VK_NUMPAD5 "vk_numpad5"
		#macro EVENT_NUMBER_VK_NUMPAD6 "vk_numpad6"
		#macro EVENT_NUMBER_VK_NUMPAD7 "vk_numpad7"
		#macro EVENT_NUMBER_VK_NUMPAD8 "vk_numpad8"
		#macro EVENT_NUMBER_VK_PAGEDOWN "vk_pagedown"
		#macro EVENT_NUMBER_VK_PAGEUP "vk_pageup"
		#macro EVENT_NUMBER_VK_PAUSE "vk_pause"
		#macro EVENT_NUMBER_VK_PRINTSCREEN "vk_printscreen"
		#macro EVENT_NUMBER_VK_RALT "vk_ralt"
		#macro EVENT_NUMBER_VK_RCONTROL "vk_rcontrol"
		#macro EVENT_NUMBER_VK_RIGHT "vk_right"
		#macro EVENT_NUMBER_VK_RSHIFT "vk_rshift"
		#macro EVENT_NUMBER_VK_SHIFT "vk_shift"
		#macro EVENT_NUMBER_VK_SPACE "vk_space"
		#macro EVENT_NUMBER_VK_SUBTRACT "vk_subtract"
		#macro EVENT_NUMBER_VK_TAB "vk_tab"
		#macro EVENT_NUMBER_VK_UP "vk_up"
	#endregion
	#region event_flag

	#endregion
	#region event_stage

	#endregion
#endregion

function event_type_to_string(_event_type) {
	switch (_event_type) {
		case ev_create: return "ev_create"; break;
		case ev_destroy: return "ev_destroy"; break;
		case ev_step: return "ev_step"; break;
		case ev_alarm: return "ev_alarm"; break;
		case ev_keyboard: return "ev_keyboard"; break;
		case ev_keypress: return "ev_keypress"; break;
		case ev_keyrelease: return "ev_keyrelease"; break;
		case ev_mouse: return "ev_mouse"; break;
		case ev_collision: return "ev_collision"; break;
		case ev_other: return "ev_other"; break;
		case ev_gesture: return "ev_gesture"; break;
		case ev_draw: return "ev_draw"; break;
	}
}

function event_to_string_struct(_event_type = event_type, _event_number = event_number) {
switch (_event_type) {
	case ev_create: {
		//Create event
		var _event_type_string = "ev_create";
		var _event_number_string = "";
	break;}
	case ev_destroy: {
		//Destroy event
		var _event_type_string = "ev_destroy";
		var _event_number_string = "";
	break;}
	case ev_cleanup: {
		//Clean Up Event
		var _event_type_string = "ev_cleanup";
		var _event_number_string = "";
	break;}
	case ev_step: {
		//Step event
		var _event_type_string = "ev_step";
		switch (_event_number) {
			case ev_step_normal: {
				//Step
				var _event_number_string = "ev_step_normal";
			break;}
			case ev_step_begin: {
				//Begin Step
				var _event_number_string = "ev_step_begin";
			break;}
			case ev_step_end: {
				//End Step
				var _event_number_string = "ev_step_end";
			break;}
			default: {
				var _event_number_string = "";
			break;}
		}
	break;}
	case ev_alarm: {
		//Alarm event
		var _event_type_string = "ev_alarm";
		switch (_event_number) {
			case 0: {
				//The number relevant to which of the 12 alarms you wish to trigger the event of
				var _event_number_string = "0";
			break;}
			case 1: {
				//The number relevant to which of the 12 alarms you wish to trigger the event of
				var _event_number_string = "1";
			break;}
			case 2: {
				//The number relevant to which of the 12 alarms you wish to trigger the event of
				var _event_number_string = "2";
			break;}
			case 3: {
				//The number relevant to which of the 12 alarms you wish to trigger the event of
				var _event_number_string = "3";
			break;}
			case 4: {
				//The number relevant to which of the 12 alarms you wish to trigger the event of
				var _event_number_string = "4";
			break;}
			case 5: {
				//The number relevant to which of the 12 alarms you wish to trigger the event of
				var _event_number_string = "5";
			break;}
			case 6: {
				//The number relevant to which of the 12 alarms you wish to trigger the event of
				var _event_number_string = "6";
			break;}
			case 7: {
				//The number relevant to which of the 12 alarms you wish to trigger the event of
				var _event_number_string = "7";
			break;}
			case 8: {
				//The number relevant to which of the 12 alarms you wish to trigger the event of
				var _event_number_string = "8";
			break;}
			case 9: {
				//The number relevant to which of the 12 alarms you wish to trigger the event of
				var _event_number_string = "9";
			break;}
			case 10: {
				//The number relevant to which of the 12 alarms you wish to trigger the event of
				var _event_number_string = "10";
			break;}
			case 11: {
				//The number relevant to which of the 12 alarms you wish to trigger the event of
				var _event_number_string = "11";
			break;}
			default: {
				var _event_number_string = "";
			break;}
		}
	break;}
	case ev_keyboard: {
		//Keyboard Down
		var _event_type_string = "ev_keyboard";
		switch (_event_number) {
			case vk_nokey: {
				//keycode representing that no key is pressed
				var _event_number_string = "vk_nokey"
			break;}
			case vk_anykey: {
				//keycode representing that any key is pressed
				var _event_number_string = "vk_anykey"
			break;}
			case vk_left: {
				//keycode for the left arrow key
				var _event_number_string = "vk_left"
			break;}
			case vk_right: {
				//keycode for the right arrow key
				var _event_number_string = "vk_right"
			break;}
			case vk_up: {
				//keycode for the up arrow key
				var _event_number_string = "vk_up"
			break;}
			case vk_down: {
				//keycode for the down arrow key
				var _event_number_string = "vk_down"
			break;}
			case vk_enter: {
				//enter key
				var _event_number_string = "vk_enter"
			break;}
			case vk_escape: {
				//escape key
				var _event_number_string = "vk_escape"
			break;}
			case vk_space: {
				//space key
				var _event_number_string = "vk_space"
			break;}
			case vk_shift: {
				//either of the shift keys
				var _event_number_string = "vk_shift"
			break;}
			case vk_control: {
				//either of the control keys
				var _event_number_string = "vk_control"
			break;}
			case vk_alt: {
				//alt key
				var _event_number_string = "vk_alt"
			break;}
			case vk_backspace: {
				//backspace key
				var _event_number_string = "vk_backspace"
			break;}
			case vk_tab: {
				//tab key
				var _event_number_string = "vk_tab"
			break;}
			case vk_home: {
				//home key
				var _event_number_string = "vk_home"
			break;}
			case vk_end: {
				//end key
				var _event_number_string = "vk_end"
			break;}
			case vk_delete: {
				//delete key
				var _event_number_string = "vk_delete"
			break;}
			case vk_insert: {
				//insert key
				var _event_number_string = "vk_insert"
			break;}
			case vk_pageup: {
				//pageup key
				var _event_number_string = "vk_pageup"
			break;}
			case vk_pagedown: {
				//pagedown key
				var _event_number_string = "vk_pagedown"
			break;}
			case vk_pause: {
				//pause/break key
				var _event_number_string = "vk_pause"
			break;}
			case vk_printscreen: {
				//printscreen/sysrq key
				var _event_number_string = "vk_printscreen"
			break;}
			case vk_f1: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f1"
			break;}
			case vk_f2: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f2"
			break;}
			case vk_f3: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f3"
			break;}
			case vk_f4: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f4"
			break;}
			case vk_f5: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f5"
			break;}
			case vk_f6: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f6"
			break;}
			case vk_f7: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f7"
			break;}
			case vk_f8: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f8"
			break;}
			case vk_f9: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f9"
			break;}
			case vk_f10: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f10"
			break;}
			case vk_f11: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f11"
			break;}
			case vk_f12: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f12"
			break;}
			case vk_numpad0: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad0"
			break;}
			case vk_numpad1: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad1"
			break;}
			case vk_numpad2: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad2"
			break;}
			case vk_numpad3: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad3"
			break;}
			case vk_numpad4: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad4"
			break;}
			case vk_numpad5: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad5"
			break;}
			case vk_numpad6: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad6"
			break;}
			case vk_numpad7: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad7"
			break;}
			case vk_numpad8: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad8"
			break;}
			case vk_numpad9: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad9"
			break;}
			case vk_multiply: {
				//multiply key on the numeric keypad
				var _event_number_string = "vk_multiply"
			break;}
			case vk_divide: {
				//divide key on the numeric keypad
				var _event_number_string = "vk_divide"
			break;}
			case vk_add: {
				//add key on the numeric keypad
				var _event_number_string = "vk_add"
			break;}
			case vk_subtract: {
				//subtract key on the numeric keypad
				var _event_number_string = "vk_subtract"
			break;}
			case vk_decimal: {
				//decimal dot keys on the numeric keypad
				var _event_number_string = "vk_decimal"
			break;}
			case vk_lshift: {
				//left shift key
				var _event_number_string = "vk_lshift"
			break;}
			case vk_lcontrol: {
				//left control key
				var _event_number_string = "vk_lcontrol"
			break;}
			case vk_lalt: {
				//left alt key
				var _event_number_string = "vk_lalt"
			break;}
			case vk_rshift: {
				//right shift key
				var _event_number_string = "vk_rshift"
			break;}
			case vk_rcontrol: {
				//right control key
				var _event_number_string = "vk_rcontrol"
			break;}
			case vk_ralt: {
				//right alt key
				var _event_number_string = "vk_ralt"
			break;}
			default: {
				var _event_number_string = string(_event_number);
			break;}
		}
	break;}
	case ev_keypress: {
		//Keyboard Pressed
		var _event_type_string = "ev_keypress";
		switch (_event_number) {
			case vk_nokey: {
				//keycode representing that no key is pressed
				var _event_number_string = "vk_nokey"
			break;}
			case vk_anykey: {
				//keycode representing that any key is pressed
				var _event_number_string = "vk_anykey"
			break;}
			case vk_left: {
				//keycode for the left arrow key
				var _event_number_string = "vk_left"
			break;}
			case vk_right: {
				//keycode for the right arrow key
				var _event_number_string = "vk_right"
			break;}
			case vk_up: {
				//keycode for the up arrow key
				var _event_number_string = "vk_up"
			break;}
			case vk_down: {
				//keycode for the down arrow key
				var _event_number_string = "vk_down"
			break;}
			case vk_enter: {
				//enter key
				var _event_number_string = "vk_enter"
			break;}
			case vk_escape: {
				//escape key
				var _event_number_string = "vk_escape"
			break;}
			case vk_space: {
				//space key
				var _event_number_string = "vk_space"
			break;}
			case vk_shift: {
				//either of the shift keys
				var _event_number_string = "vk_shift"
			break;}
			case vk_control: {
				//either of the control keys
				var _event_number_string = "vk_control"
			break;}
			case vk_alt: {
				//alt key
				var _event_number_string = "vk_alt"
			break;}
			case vk_backspace: {
				//backspace key
				var _event_number_string = "vk_backspace"
			break;}
			case vk_tab: {
				//tab key
				var _event_number_string = "vk_tab"
			break;}
			case vk_home: {
				//home key
				var _event_number_string = "vk_home"
			break;}
			case vk_end: {
				//end key
				var _event_number_string = "vk_end"
			break;}
			case vk_delete: {
				//delete key
				var _event_number_string = "vk_delete"
			break;}
			case vk_insert: {
				//insert key
				var _event_number_string = "vk_insert"
			break;}
			case vk_pageup: {
				//pageup key
				var _event_number_string = "vk_pageup"
			break;}
			case vk_pagedown: {
				//pagedown key
				var _event_number_string = "vk_pagedown"
			break;}
			case vk_pause: {
				//pause/break key
				var _event_number_string = "vk_pause"
			break;}
			case vk_printscreen: {
				//printscreen/sysrq key
				var _event_number_string = "vk_printscreen"
			break;}
			case vk_f1: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f1"
			break;}
			case vk_f2: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f2"
			break;}
			case vk_f3: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f3"
			break;}
			case vk_f4: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f4"
			break;}
			case vk_f5: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f5"
			break;}
			case vk_f6: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f6"
			break;}
			case vk_f7: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f7"
			break;}
			case vk_f8: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f8"
			break;}
			case vk_f9: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f9"
			break;}
			case vk_f10: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f10"
			break;}
			case vk_f11: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f11"
			break;}
			case vk_f12: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f12"
			break;}
			case vk_numpad0: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad0"
			break;}
			case vk_numpad1: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad1"
			break;}
			case vk_numpad2: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad2"
			break;}
			case vk_numpad3: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad3"
			break;}
			case vk_numpad4: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad4"
			break;}
			case vk_numpad5: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad5"
			break;}
			case vk_numpad6: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad6"
			break;}
			case vk_numpad7: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad7"
			break;}
			case vk_numpad8: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad8"
			break;}
			case vk_numpad9: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad9"
			break;}
			case vk_multiply: {
				//multiply key on the numeric keypad
				var _event_number_string = "vk_multiply"
			break;}
			case vk_divide: {
				//divide key on the numeric keypad
				var _event_number_string = "vk_divide"
			break;}
			case vk_add: {
				//add key on the numeric keypad
				var _event_number_string = "vk_add"
			break;}
			case vk_subtract: {
				//subtract key on the numeric keypad
				var _event_number_string = "vk_subtract"
			break;}
			case vk_decimal: {
				//decimal dot keys on the numeric keypad
				var _event_number_string = "vk_decimal"
			break;}
			case vk_lshift: {
				//left shift key
				var _event_number_string = "vk_lshift"
			break;}
			case vk_lcontrol: {
				//left control key
				var _event_number_string = "vk_lcontrol"
			break;}
			case vk_lalt: {
				//left alt key
				var _event_number_string = "vk_lalt"
			break;}
			case vk_rshift: {
				//right shift key
				var _event_number_string = "vk_rshift"
			break;}
			case vk_rcontrol: {
				//right control key
				var _event_number_string = "vk_rcontrol"
			break;}
			case vk_ralt: {
				//right alt key
				var _event_number_string = "vk_ralt"
			break;}
			default: {
				var _event_number_string = string(_event_number);
			break;}
		}
	break;}
	case ev_keyrelease: {
		//Keyboard Released
		var _event_type_string = "ev_keyrelease";
		switch (_event_number) {
			case vk_nokey: {
				//keycode representing that no key is pressed
				var _event_number_string = "vk_nokey"
			break;}
			case vk_anykey: {
				//keycode representing that any key is pressed
				var _event_number_string = "vk_anykey"
			break;}
			case vk_left: {
				//keycode for the left arrow key
				var _event_number_string = "vk_left"
			break;}
			case vk_right: {
				//keycode for the right arrow key
				var _event_number_string = "vk_right"
			break;}
			case vk_up: {
				//keycode for the up arrow key
				var _event_number_string = "vk_up"
			break;}
			case vk_down: {
				//keycode for the down arrow key
				var _event_number_string = "vk_down"
			break;}
			case vk_enter: {
				//enter key
				var _event_number_string = "vk_enter"
			break;}
			case vk_escape: {
				//escape key
				var _event_number_string = "vk_escape"
			break;}
			case vk_space: {
				//space key
				var _event_number_string = "vk_space"
			break;}
			case vk_shift: {
				//either of the shift keys
				var _event_number_string = "vk_shift"
			break;}
			case vk_control: {
				//either of the control keys
				var _event_number_string = "vk_control"
			break;}
			case vk_alt: {
				//alt key
				var _event_number_string = "vk_alt"
			break;}
			case vk_backspace: {
				//backspace key
				var _event_number_string = "vk_backspace"
			break;}
			case vk_tab: {
				//tab key
				var _event_number_string = "vk_tab"
			break;}
			case vk_home: {
				//home key
				var _event_number_string = "vk_home"
			break;}
			case vk_end: {
				//end key
				var _event_number_string = "vk_end"
			break;}
			case vk_delete: {
				//delete key
				var _event_number_string = "vk_delete"
			break;}
			case vk_insert: {
				//insert key
				var _event_number_string = "vk_insert"
			break;}
			case vk_pageup: {
				//pageup key
				var _event_number_string = "vk_pageup"
			break;}
			case vk_pagedown: {
				//pagedown key
				var _event_number_string = "vk_pagedown"
			break;}
			case vk_pause: {
				//pause/break key
				var _event_number_string = "vk_pause"
			break;}
			case vk_printscreen: {
				//printscreen/sysrq key
				var _event_number_string = "vk_printscreen"
			break;}
			case vk_f1: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f1"
			break;}
			case vk_f2: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f2"
			break;}
			case vk_f3: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f3"
			break;}
			case vk_f4: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f4"
			break;}
			case vk_f5: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f5"
			break;}
			case vk_f6: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f6"
			break;}
			case vk_f7: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f7"
			break;}
			case vk_f8: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f8"
			break;}
			case vk_f9: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f9"
			break;}
			case vk_f10: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f10"
			break;}
			case vk_f11: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f11"
			break;}
			case vk_f12: {
				//keycode for the function keys F1 to F12
				var _event_number_string = "vk_f12"
			break;}
			case vk_numpad0: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad0"
			break;}
			case vk_numpad1: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad1"
			break;}
			case vk_numpad2: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad2"
			break;}
			case vk_numpad3: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad3"
			break;}
			case vk_numpad4: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad4"
			break;}
			case vk_numpad5: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad5"
			break;}
			case vk_numpad6: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad6"
			break;}
			case vk_numpad7: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad7"
			break;}
			case vk_numpad8: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad8"
			break;}
			case vk_numpad9: {
				//number keys on the numeric keypad
				var _event_number_string = "vk_numpad9"
			break;}
			case vk_multiply: {
				//multiply key on the numeric keypad
				var _event_number_string = "vk_multiply"
			break;}
			case vk_divide: {
				//divide key on the numeric keypad
				var _event_number_string = "vk_divide"
			break;}
			case vk_add: {
				//add key on the numeric keypad
				var _event_number_string = "vk_add"
			break;}
			case vk_subtract: {
				//subtract key on the numeric keypad
				var _event_number_string = "vk_subtract"
			break;}
			case vk_decimal: {
				//decimal dot keys on the numeric keypad
				var _event_number_string = "vk_decimal"
			break;}
			case vk_lshift: {
				//left shift key
				var _event_number_string = "vk_lshift"
			break;}
			case vk_lcontrol: {
				//left control key
				var _event_number_string = "vk_lcontrol"
			break;}
			case vk_lalt: {
				//left alt key
				var _event_number_string = "vk_lalt"
			break;}
			case vk_rshift: {
				//right shift key
				var _event_number_string = "vk_rshift"
			break;}
			case vk_rcontrol: {
				//right control key
				var _event_number_string = "vk_rcontrol"
			break;}
			case vk_ralt: {
				//right alt key
				var _event_number_string = "vk_ralt"
			break;}
			default: {
				var _event_number_string = string(_event_number);
			break;}
		}
	break;}
	case ev_mouse: {
		//Mouse event
		var _event_type_string = "ev_mouse";
		switch (_event_number) {
			case ev_left_button: {
				//Left button held down on object
				var _event_number_string = "ev_left_button";
			break;}
			case ev_right_button: {
				//Right button held down on object
				var _event_number_string = "ev_right_button";
			break;}
			case ev_middle_button: {
				//Middle button (or clickable wheel) held down on object
				var _event_number_string = "ev_middle_button";
			break;}
			case ev_no_button: {
				//No buttons held down
				var _event_number_string = "ev_no_button";
			break;}
			case ev_left_press: {
				//Left button just pressed on object
				var _event_number_string = "ev_left_press";
			break;}
			case ev_right_press: {
				//Right button just pressed on object
				var _event_number_string = "ev_right_press";
			break;}
			case ev_middle_press: {
				//Middle button (or clickable wheel) just pressed on object
				var _event_number_string = "ev_middle_press";
			break;}
			case ev_left_release: {
				//Left button just released on object
				var _event_number_string = "ev_left_release";
			break;}
			case ev_right_release: {
				//Right button just released on object
				var _event_number_string = "ev_right_release";
			break;}
			case ev_middle_release: {
				//Middle button just released on object
				var _event_number_string = "ev_middle_release";
			break;}
			case ev_mouse_enter: {
				//Mouse just entered object's bounding box
				var _event_number_string = "ev_mouse_enter";
			break;}
			case ev_mouse_leave: {
				//Mouse just left object's bounding box
				var _event_number_string = "ev_mouse_leave";
			break;}
			case ev_mouse_wheel_up: {
				//Mouse wheel scrolled upwards
				var _event_number_string = "ev_mouse_wheel_up";
			break;}
			case ev_mouse_wheel_down: {
				//Mouse wheel scrolled downwards
				var _event_number_string = "ev_mouse_wheel_down";
			break;}
			case ev_global_left_button: {
				//Left button held down anywhere
				var _event_number_string = "ev_global_left_button";
			break;}
			case ev_global_right_button: {
				//Right button held down anywhere
				var _event_number_string = "ev_global_right_button";
			break;}
			case ev_global_middle_button: {
				//Middle button (or clickable wheel) held down anywhere
				var _event_number_string = "ev_global_middle_button";
			break;}
			case ev_global_left_press: {
				//Left button just pressed anywhere
				var _event_number_string = "ev_global_left_press";
			break;}
			case ev_global_right_press: {
				//Right button just pressed anywhere
				var _event_number_string = "ev_global_right_press";
			break;}
			case ev_global_middle_press: {
				//Middle button (or clickable wheel) just pressed anywhere
				var _event_number_string = "ev_global_middle_press";
			break;}
			case ev_global_left_release: {
				//Left button just released anywhere
				var _event_number_string = "ev_global_left_release";
			break;}
			case ev_global_right_release: {
				//Right button just released anywhere
				var _event_number_string = "ev_global_right_release";
			break;}
			case ev_global_middle_release: {
				//Middle button just released anywhere
				var _event_number_string = "ev_global_middle_release";
			break;}
			default: {
				var _event_number_string = "";
			break;}
		}
	break;}
	case ev_gesture: {
		//A gesture event (Tap, Drag, Flick, Pinch or Rotate)
		var _event_type_string = "ev_gesture";
		switch (_event_number) {
			case ev_gesture_tap: {
				//A single click/touch and release has been detected for an instance
				var _event_number_string = "ev_gesture_tap";
			break;}
			case ev_gesture_double_tap: {
				//Two quick touches/clicks and releases have been detected for an instance
				var _event_number_string = "ev_gesture_double_tap";
			break;}
			case ev_gesture_drag_start: {
				//The beginning of a drag gesture has been detected for an instance
				var _event_number_string = "ev_gesture_drag_start";
			break;}
			case ev_gesture_dragging: {
				//A touch/click has been held and moved for an instance
				var _event_number_string = "ev_gesture_dragging";
			break;}
			case ev_gesture_drag_end: {
				//The release of the touch/click from a drag has been detected for an instance
				var _event_number_string = "ev_gesture_drag_end";
			break;}
			case ev_gesture_flick: {
				//The release of a touch/click from a drag had enough movement for a flick event to be detected for the instance
				var _event_number_string = "ev_gesture_flick";
			break;}
			case ev_gesture_pinch_start: {
				//Two touches and a straight movement have been detected for an instance
				var _event_number_string = "ev_gesture_pinch_start";
			break;}
			case ev_gesture_pinch_in: {
				//The movement between two touches for an instance has been detected as inwards
				var _event_number_string = "ev_gesture_pinch_in";
			break;}
			case ev_gesture_pinch_out: {
				//The movement between two touches for an instance has been detected as outwards
				var _event_number_string = "ev_gesture_pinch_out";
			break;}
			case ev_gesture_pinch_end: {
				//The release of one (or both) touches for a pinch has been detected for an instance
				var _event_number_string = "ev_gesture_pinch_end";
			break;}
			case ev_gesture_rotate_start: {
				//The movement between two touches for an instance has been detected as a rotation
				var _event_number_string = "ev_gesture_rotate_start";
			break;}
			case ev_gesture_rotating: {
				//The movement between two touches for an instance has been detected as rotating
				var _event_number_string = "ev_gesture_rotating";
			break;}
			case ev_gesture_rotate_end: {
				//The release of one (or both) touches for a rotation has been detected for an instance
				var _event_number_string = "ev_gesture_rotate_end";
			break;}
			case ev_global_gesture_tap: {
				//A single click/touch and release has been detected anywhere in the room
				var _event_number_string = "ev_global_gesture_tap";
			break;}
			case ev_global_gesture_double_tap: {
				//Two quick touches/clicks and releases have been detected anywhere in the room
				var _event_number_string = "ev_global_gesture_double_tap";
			break;}
			case ev_global_gesture_drag_start: {
				//The beginning of a drag gesture has been detected anywhere in the room
				var _event_number_string = "ev_global_gesture_drag_start";
			break;}
			case ev_global_gesture_dragging: {
				//A touch/click has been held and moved anywhere in the room
				var _event_number_string = "ev_global_gesture_dragging";
			break;}
			case ev_global_gesture_drag_end: {
				//The release of the touch/click from a drag has been detected anywhere in the room
				var _event_number_string = "ev_global_gesture_drag_end";
			break;}
			case ev_global_gesture_flick: {
				//The release of a touch/click from a drag had enough movement for a flick event to be detected anywhere in the room
				var _event_number_string = "ev_global_gesture_flick";
			break;}
			case ev_global_gesture_pinch_start: {
				//Two touches and a straight movement have been detected anywhere in the room
				var _event_number_string = "ev_global_gesture_pinch_start";
			break;}
			case ev_global_gesture_pinch_in: {
				//The movement between two touches anywhere in the room has been detected as inwards
				var _event_number_string = "ev_global_gesture_pinch_in";
			break;}
			case ev_global_gesture_pinch_out: {
				//The movement between two touches anywhere in the room has been detected as outwards
				var _event_number_string = "ev_global_gesture_pinch_out";
			break;}
			case ev_global_gesture_pinch_end: {
				//The release of one (or both) touches for a pinch has been detected anywhere in the room
				var _event_number_string = "ev_global_gesture_pinch_end";
			break;}
			case ev_global_gesture_rotate_start: {
				//The movement between two touches anywhere in the room has been detected as a rotation
				var _event_number_string = "ev_global_gesture_rotate_start";
			break;}
			case ev_global_gesture_rotating: {
				//The movement between two touches anywhere in the room has been detected as rotating
				var _event_number_string = "ev_global_gesture_rotating";
			break;}
			case ev_global_gesture_rotate_end: {
				//The release of one (or both) touches for a rotation has been detected anywhere in the room
				var _event_number_string = "ev_global_gesture_rotate_end";
			break;}
			default: {
				var _event_number_string = "";
			break;}
		}
	break;}
	case ev_collision: {
		//Collision with an object
		var _event_type_string = "ev_collision";
		var _event_number_string = string(_event_number);
	break;}
	case ev_other: {
		//One of the actions listed under 'Other'
		var _event_type_string = "ev_other";
		switch (_event_number) {
			case ev_outside: {
				//Whether the instance is outside of the room
				var _event_number_string = "ev_outside";
			break;}
			case ev_boundary: {
				//Whether the instance is intersecting the boundary
				var _event_number_string = "ev_boundary";
			break;}
			case ev_outside_view0: {
				//Whether the instance is outside the given view (0 to 7)
				var _event_number_string = "ev_outside_view0";
			break;}
			case ev_outside_view1: {
				//Whether the instance is outside the given view (0 to 7)
				var _event_number_string = "ev_outside_view1";
			break;}
			case ev_outside_view2: {
				//Whether the instance is outside the given view (0 to 7)
				var _event_number_string = "ev_outside_view2";
			break;}
			case ev_outside_view3: {
				//Whether the instance is outside the given view (0 to 7)
				var _event_number_string = "ev_outside_view3";
			break;}
			case ev_outside_view4: {
				//Whether the instance is outside the given view (0 to 7)
				var _event_number_string = "ev_outside_view4";
			break;}
			case ev_outside_view5: {
				//Whether the instance is outside the given view (0 to 7)
				var _event_number_string = "ev_outside_view5";
			break;}
			case ev_outside_view6: {
				//Whether the instance is outside the given view (0 to 7)
				var _event_number_string = "ev_outside_view6";
			break;}
			case ev_outside_view7: {
				//Whether the instance is outside the given view (0 to 7)
				var _event_number_string = "ev_outside_view7";
			break;}
			case ev_boundary_view0: {
				//Whether the instance is interesecting with the boundary of the given view (0 to 7)
				var _event_number_string = "ev_boundary_view0";
			break;}
			case ev_boundary_view1: {
				//Whether the instance is interesecting with the boundary of the given view (0 to 7)
				var _event_number_string = "ev_boundary_view1";
			break;}
			case ev_boundary_view2: {
				//Whether the instance is interesecting with the boundary of the given view (0 to 7)
				var _event_number_string = "ev_boundary_view2";
			break;}
			case ev_boundary_view3: {
				//Whether the instance is interesecting with the boundary of the given view (0 to 7)
				var _event_number_string = "ev_boundary_view3";
			break;}
			case ev_boundary_view4: {
				//Whether the instance is interesecting with the boundary of the given view (0 to 7)
				var _event_number_string = "ev_boundary_view4";
			break;}
			case ev_boundary_view5: {
				//Whether the instance is interesecting with the boundary of the given view (0 to 7)
				var _event_number_string = "ev_boundary_view5";
			break;}
			case ev_boundary_view6: {
				//Whether the instance is interesecting with the boundary of the given view (0 to 7)
				var _event_number_string = "ev_boundary_view6";
			break;}
			case ev_boundary_view7: {
				//Whether the instance is interesecting with the boundary of the given view (0 to 7)
				var _event_number_string = "ev_boundary_view7";
			break;}
			case ev_game_start: {
				//Only triggered at the start of the game
				var _event_number_string = "ev_game_start";
			break;}
			case ev_game_end: {
				//Only triggered at the end of the game
				var _event_number_string = "ev_game_end";
			break;}
			case ev_room_start: {
				//Only triggered at the start of a room
				var _event_number_string = "ev_room_start";
			break;}
			case ev_room_end: {
				//Only triggered at the end of a room
				var _event_number_string = "ev_room_end";
			break;}
			case ev_animation_end: {
				//If the object's sprite has reached the end of its animation
				var _event_number_string = "ev_animation_end";
			break;}
			case ev_animation_update: {
				//Animation event that runs every step for objects that use skeletal animations
				var _event_number_string = "ev_animation_update";
			break;}
			case ev_animation_event: {
				//Animation event that runs for skeletal animations as assigned in the skeletal animation tool
				var _event_number_string = "ev_animation_event";
			break;}
			case ev_end_of_path: {
				//If the object has reached the end of a path it is following
				var _event_number_string = "ev_end_of_path";
			break;}
			case ev_user0: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user0";
			break;}
			case ev_user1: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user1";
			break;}
			case ev_user2: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user2";
			break;}
			case ev_user3: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user3";
			break;}
			case ev_user4: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user4";
			break;}
			case ev_user5: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user5";
			break;}
			case ev_user6: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user6";
			break;}
			case ev_user7: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user7";
			break;}
			case ev_user8: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user8";
			break;}
			case ev_user9: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user9";
			break;}
			case ev_user10: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user10";
			break;}
			case ev_user11: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user11";
			break;}
			case ev_user12: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user12";
			break;}
			case ev_user13: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user13";
			break;}
			case ev_user14: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user14";
			break;}
			case ev_user15: {
				//One of the 16 available user events.
				var _event_number_string = "ev_user15";
			break;}
			case ev_broadcast_message: {
				//Broadcast Message event used for sprites and sequences
				var _event_number_string = "ev_broadcast_message";
			break;}
			default: {
				var _event_number_string = "";
			break;}
		}
	break;}
	case ev_draw: {
		//Draw event. NOTE This event cannot be forced outside of a draw event and the constants are only for identifying the event when performed in these cases.
		var _event_type_string = "ev_draw";
		switch (_event_number) {
			case ev_draw_normal: {
				//The normal draw event.
				var _event_number_string = "ev_draw_normal";
			break;}
			case ev_draw_begin: {
				//The draw begin event.
				var _event_number_string = "ev_draw_begin";
			break;}
			case ev_draw_end: {
				//The draw end event.
				var _event_number_string = "ev_draw_end";
			break;}
			case ev_draw_pre: {
				//The pre draw event.
				var _event_number_string = "ev_draw_pre";
			break;}
			case ev_draw_post: {
				//The post draw event.
				var _event_number_string = "ev_draw_post";
			break;}
			case ev_gui: {
				//The draw gui event.
				var _event_number_string = "ev_gui";
			break;}
			case ev_gui_begin: {
				//The draw gui begin event.
				var _event_number_string = "ev_gui_begin";
			break;}
			case ev_gui_end: {
				//The draw gui end event.
				var _event_number_string = "ev_gui_end";
			break;}
			default: {
				var _event_number_string = "";
			break;}
		}
	break;}
	}
	
	if (_event_number_string == "") {
		return {ev_type: _event_type_string}
	}else{
		return {ev_type: _event_type_string, ev_number: _event_number_string}
	}
}

function event_string_to_struct(_struct) {
	
	var _has_event_number = (variable_struct_names_count(_struct) > 1);
	var _event_struct = {};
	
	if (_has_event_number) {
		var _event_type = _struct.ev_number;
		var _event_number = _struct.ev_type;
	}
	else{
		var _event_type = _struct.ev_number;
		var _event_number = "";
	}
	
	switch (_event_type) {
		case "ev_create": {
			//Create event
			_event_struct.event_type = ev_create;
		break;}
		case "ev_destroy": {
			//Destroy event
			_event_struct.event_type = ev_destroy;
		break;}
		case "ev_cleanup": {
			//Clean Up Event
			_event_struct.event_type = ev_cleanup;
		break;}
		case "ev_step": {
			//Step event
			_event_struct.event_type = ev_step;
			switch (_event_number) {
				case "ev_step_normal": {
					//Step
					_event_struct.event_number = ev_step_normal;
				break;}
				case "ev_step_begin": {
					//Begin Step
					_event_struct.event_number = ev_step_begin;
				break;}
				case "ev_step_end": {
					//End Step
					_event_struct.event_number = ev_step_end;
				break;}
			}
		break;}
		case "ev_alarm": {
			//Alarm event
			switch (_event_number) {
				case "0": {
					//The number relevant to which of the 12 alarms you wish to trigger the event of
					_event_struct.event_number = 0;
				break;}
				case "1": {
					//The number relevant to which of the 12 alarms you wish to trigger the event of
					_event_struct.event_number = 1;
				break;}
				case "2": {
					//The number relevant to which of the 12 alarms you wish to trigger the event of
					_event_struct.event_number = 2;
				break;}
				case "3": {
					//The number relevant to which of the 12 alarms you wish to trigger the event of
					_event_struct.event_number = 3;
				break;}
				case "4": {
					//The number relevant to which of the 12 alarms you wish to trigger the event of
					_event_struct.event_number = 4;
				break;}
				case "5": {
					//The number relevant to which of the 12 alarms you wish to trigger the event of
					_event_struct.event_number = 5;
				break;}
				case "6": {
					//The number relevant to which of the 12 alarms you wish to trigger the event of
					_event_struct.event_number = 6;
				break;}
				case "7": {
					//The number relevant to which of the 12 alarms you wish to trigger the event of
					_event_struct.event_number = 7;
				break;}
				case "8": {
					//The number relevant to which of the 12 alarms you wish to trigger the event of
					_event_struct.event_number = 8;
				break;}
				case "9": {
					//The number relevant to which of the 12 alarms you wish to trigger the event of
					_event_struct.event_number = 9;
				break;}
				case "10": {
					//The number relevant to which of the 12 alarms you wish to trigger the event of
					_event_struct.event_number = 10;
				break;}
				case "11": {
					//The number relevant to which of the 12 alarms you wish to trigger the event of
					_event_struct.event_number = 11;
				break;}
			}
		break;}
		case "ev_keyboard": {
			//Keyboard Down
			_event_struct.event_type = ev_keyboard;
			switch (_event_number) {
				case "vk_nokey": {
					//keycode representing that no key is pressed
					_event_struct.event_number = vk_nokey;
				break;}
				case "vk_anykey": {
					//keycode representing that any key is pressed
					_event_struct.event_number = vk_anykey;
				break;}
				case "vk_left": {
					//keycode for the left arrow key
					_event_struct.event_number = vk_left;
				break;}
				case "vk_right": {
					//keycode for the right arrow key
					_event_struct.event_number = vk_right;
				break;}
				case "vk_up": {
					//keycode for the up arrow key
					_event_struct.event_number = vk_up;
				break;}
				case "vk_down": {
					//keycode for the down arrow key
					_event_struct.event_number = vk_down;
				break;}
				case "vk_enter": {
					//enter key
					_event_struct.event_number = vk_enter;
				break;}
				case "vk_escape": {
					//escape key
					_event_struct.event_number = vk_escape;
				break;}
				case "vk_space": {
					//space key
					_event_struct.event_number = vk_space;
				break;}
				case "vk_shift": {
					//either of the shift keys
					_event_struct.event_number = vk_shift;
				break;}
				case "vk_control": {
					//either of the control keys
					_event_struct.event_number = vk_control;
				break;}
				case "vk_alt": {
					//alt key
					_event_struct.event_number = vk_alt;
				break;}
				case "vk_backspace": {
					//backspace key
					_event_struct.event_number = vk_backspace;
				break;}
				case "vk_tab": {
					//tab key
					_event_struct.event_number = vk_tab;
				break;}
				case "vk_home": {
					//home key
					_event_struct.event_number = vk_home;
				break;}
				case "vk_end": {
					//end key
					_event_struct.event_number = vk_end;
				break;}
				case "vk_delete": {
					//delete key
					_event_struct.event_number = vk_delete;
				break;}
				case "vk_insert": {
					//insert key
					_event_struct.event_number = vk_insert;
				break;}
				case "vk_pageup": {
					//pageup key
					_event_struct.event_number = vk_pageup;
				break;}
				case "vk_pagedown": {
					//pagedown key
					_event_struct.event_number = vk_pagedown;
				break;}
				case "vk_pause": {
					//pause/break key
					_event_struct.event_number = vk_pause;
				break;}
				case "vk_printscreen": {
					//printscreen/sysrq key
					_event_struct.event_number = vk_printscreen;
				break;}
				case "vk_f1": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f1;
				break;}
				case "vk_f2": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f2;
				break;}
				case "vk_f3": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f3;
				break;}
				case "vk_f4": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f4;
				break;}
				case "vk_f5": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f5;
				break;}
				case "vk_f6": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f6;
				break;}
				case "vk_f7": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f7;
				break;}
				case "vk_f8": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f8;
				break;}
				case "vk_f9": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f9;
				break;}
				case "vk_f10": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f10;
				break;}
				case "vk_f11": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f11;
				break;}
				case "vk_f12": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f12;
				break;}
				case "vk_numpad0": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad0;
				break;}
				case "vk_numpad1": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad1;
				break;}
				case "vk_numpad2": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad2;
				break;}
				case "vk_numpad3": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad3;
				break;}
				case "vk_numpad4": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad4;
				break;}
				case "vk_numpad5": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad5;
				break;}
				case "vk_numpad6": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad6;
				break;}
				case "vk_numpad7": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad7;
				break;}
				case "vk_numpad8": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad8;
				break;}
				case "vk_numpad9": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad9;
				break;}
				case "vk_multiply": {
					//multiply key on the numeric keypad
					_event_struct.event_number = vk_multiply;
				break;}
				case "vk_divide": {
					//divide key on the numeric keypad
					_event_struct.event_number = vk_divide;
				break;}
				case "vk_add": {
					//add key on the numeric keypad
					_event_struct.event_number = vk_add;
				break;}
				case "vk_subtract": {
					//subtract key on the numeric keypad
					_event_struct.event_number = vk_subtract;
				break;}
				case "vk_decimal": {
					//decimal dot keys on the numeric keypad
					_event_struct.event_number = vk_decimal;
				break;}
				case "vk_lshift": {
					//left shift key
					_event_struct.event_number = vk_lshift;
				break;}
				case "vk_lcontrol": {
					//left control key
					_event_struct.event_number = vk_lcontrol;
				break;}
				case "vk_lalt": {
					//left alt key
					_event_struct.event_number = vk_lalt;
				break;}
				case "vk_rshift": {
					//right shift key
					_event_struct.event_number = vk_rshift;
				break;}
				case "vk_rcontrol": {
					//right control key
					_event_struct.event_number = vk_rcontrol;
				break;}
				case "vk_ralt": {
					//right alt key
					_event_struct.event_number = vk_ralt;
				break;}
				default: {
					_event_struct.event_number = real(_event_number);
				break;}
			}
		break;}
		case "ev_keypress": {
			//Keyboard Pressed
			_event_struct.event_type = ev_keypress;
			switch (_event_number) {
				case "vk_nokey": {
					//keycode representing that no key is pressed
					_event_struct.event_number = vk_nokey;
				break;}
				case "vk_anykey": {
					//keycode representing that any key is pressed
					_event_struct.event_number = vk_anykey;
				break;}
				case "vk_left": {
					//keycode for the left arrow key
					_event_struct.event_number = vk_left;
				break;}
				case "vk_right": {
					//keycode for the right arrow key
					_event_struct.event_number = vk_right;
				break;}
				case "vk_up": {
					//keycode for the up arrow key
					_event_struct.event_number = vk_up;
				break;}
				case "vk_down": {
					//keycode for the down arrow key
					_event_struct.event_number = vk_down;
				break;}
				case "vk_enter": {
					//enter key
					_event_struct.event_number = vk_enter;
				break;}
				case "vk_escape": {
					//escape key
					_event_struct.event_number = vk_escape;
				break;}
				case "vk_space": {
					//space key
					_event_struct.event_number = vk_space;
				break;}
				case "vk_shift": {
					//either of the shift keys
					_event_struct.event_number = vk_shift;
				break;}
				case "vk_control": {
					//either of the control keys
					_event_struct.event_number = vk_control;
				break;}
				case "vk_alt": {
					//alt key
					_event_struct.event_number = vk_alt;
				break;}
				case "vk_backspace": {
					//backspace key
					_event_struct.event_number = vk_backspace;
				break;}
				case "vk_tab": {
					//tab key
					_event_struct.event_number = vk_tab;
				break;}
				case "vk_home": {
					//home key
					_event_struct.event_number = vk_home;
				break;}
				case "vk_end": {
					//end key
					_event_struct.event_number = vk_end;
				break;}
				case "vk_delete": {
					//delete key
					_event_struct.event_number = vk_delete;
				break;}
				case "vk_insert": {
					//insert key
					_event_struct.event_number = vk_insert;
				break;}
				case "vk_pageup": {
					//pageup key
					_event_struct.event_number = vk_pageup;
				break;}
				case "vk_pagedown": {
					//pagedown key
					_event_struct.event_number = vk_pagedown;
				break;}
				case "vk_pause": {
					//pause/break key
					_event_struct.event_number = vk_pause;
				break;}
				case "vk_printscreen": {
					//printscreen/sysrq key
					_event_struct.event_number = vk_printscreen;
				break;}
				case "vk_f1": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f1;
				break;}
				case "vk_f2": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f2;
				break;}
				case "vk_f3": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f3;
				break;}
				case "vk_f4": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f4;
				break;}
				case "vk_f5": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f5;
				break;}
				case "vk_f6": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f6;
				break;}
				case "vk_f7": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f7;
				break;}
				case "vk_f8": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f8;
				break;}
				case "vk_f9": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f9;
				break;}
				case "vk_f10": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f10;
				break;}
				case "vk_f11": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f11;
				break;}
				case "vk_f12": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f12;
				break;}
				case "vk_numpad0": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad0;
				break;}
				case "vk_numpad1": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad1;
				break;}
				case "vk_numpad2": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad2;
				break;}
				case "vk_numpad3": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad3;
				break;}
				case "vk_numpad4": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad4;
				break;}
				case "vk_numpad5": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad5;
				break;}
				case "vk_numpad6": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad6;
				break;}
				case "vk_numpad7": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad7;
				break;}
				case "vk_numpad8": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad8;
				break;}
				case "vk_numpad9": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad9;
				break;}
				case "vk_multiply": {
					//multiply key on the numeric keypad
					_event_struct.event_number = vk_multiply;
				break;}
				case "vk_divide": {
					//divide key on the numeric keypad
					_event_struct.event_number = vk_divide;
				break;}
				case "vk_add": {
					//add key on the numeric keypad
					_event_struct.event_number = vk_add;
				break;}
				case "vk_subtract": {
					//subtract key on the numeric keypad
					_event_struct.event_number = vk_subtract;
				break;}
				case "vk_decimal": {
					//decimal dot keys on the numeric keypad
					_event_struct.event_number = vk_decimal;
				break;}
				case "vk_lshift": {
					//left shift key
					_event_struct.event_number = vk_lshift;
				break;}
				case "vk_lcontrol": {
					//left control key
					_event_struct.event_number = vk_lcontrol;
				break;}
				case "vk_lalt": {
					//left alt key
					_event_struct.event_number = vk_lalt;
				break;}
				case "vk_rshift": {
					//right shift key
					_event_struct.event_number = vk_rshift;
				break;}
				case "vk_rcontrol": {
					//right control key
					_event_struct.event_number = vk_rcontrol;
				break;}
				case "vk_ralt": {
					//right alt key
					_event_struct.event_number = vk_ralt;
				break;}
				default: {
					_event_struct.event_number = real(_event_number);
				break;}
			}
		break;}
		case "ev_keyrelease": {
			//Keyboard Released
			_event_struct.event_type = ev_keyrelease;
			switch (_event_number) {
				case "vk_nokey": {
					//keycode representing that no key is pressed
					_event_struct.event_number = vk_nokey;
				break;}
				case "vk_anykey": {
					//keycode representing that any key is pressed
					_event_struct.event_number = vk_anykey;
				break;}
				case "vk_left": {
					//keycode for the left arrow key
					_event_struct.event_number = vk_left;
				break;}
				case "vk_right": {
					//keycode for the right arrow key
					_event_struct.event_number = vk_right;
				break;}
				case "vk_up": {
					//keycode for the up arrow key
					_event_struct.event_number = vk_up;
				break;}
				case "vk_down": {
					//keycode for the down arrow key
					_event_struct.event_number = vk_down;
				break;}
				case "vk_enter": {
					//enter key
					_event_struct.event_number = vk_enter;
				break;}
				case "vk_escape": {
					//escape key
					_event_struct.event_number = vk_escape;
				break;}
				case "vk_space": {
					//space key
					_event_struct.event_number = vk_space;
				break;}
				case "vk_shift": {
					//either of the shift keys
					_event_struct.event_number = vk_shift;
				break;}
				case "vk_control": {
					//either of the control keys
					_event_struct.event_number = vk_control;
				break;}
				case "vk_alt": {
					//alt key
					_event_struct.event_number = vk_alt;
				break;}
				case "vk_backspace": {
					//backspace key
					_event_struct.event_number = vk_backspace;
				break;}
				case "vk_tab": {
					//tab key
					_event_struct.event_number = vk_tab;
				break;}
				case "vk_home": {
					//home key
					_event_struct.event_number = vk_home;
				break;}
				case "vk_end": {
					//end key
					_event_struct.event_number = vk_end;
				break;}
				case "vk_delete": {
					//delete key
					_event_struct.event_number = vk_delete;
				break;}
				case "vk_insert": {
					//insert key
					_event_struct.event_number = vk_insert;
				break;}
				case "vk_pageup": {
					//pageup key
					_event_struct.event_number = vk_pageup;
				break;}
				case "vk_pagedown": {
					//pagedown key
					_event_struct.event_number = vk_pagedown;
				break;}
				case "vk_pause": {
					//pause/break key
					_event_struct.event_number = vk_pause;
				break;}
				case "vk_printscreen": {
					//printscreen/sysrq key
					_event_struct.event_number = vk_printscreen;
				break;}
				case "vk_f1": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f1;
				break;}
				case "vk_f2": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f2;
				break;}
				case "vk_f3": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f3;
				break;}
				case "vk_f4": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f4;
				break;}
				case "vk_f5": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f5;
				break;}
				case "vk_f6": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f6;
				break;}
				case "vk_f7": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f7;
				break;}
				case "vk_f8": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f8;
				break;}
				case "vk_f9": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f9;
				break;}
				case "vk_f10": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f10;
				break;}
				case "vk_f11": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f11;
				break;}
				case "vk_f12": {
					//keycode for the function keys F1 to F12
					_event_struct.event_number = vk_f12;
				break;}
				case "vk_numpad0": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad0;
				break;}
				case "vk_numpad1": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad1;
				break;}
				case "vk_numpad2": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad2;
				break;}
				case "vk_numpad3": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad3;
				break;}
				case "vk_numpad4": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad4;
				break;}
				case "vk_numpad5": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad5;
				break;}
				case "vk_numpad6": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad6;
				break;}
				case "vk_numpad7": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad7;
				break;}
				case "vk_numpad8": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad8;
				break;}
				case "vk_numpad9": {
					//number keys on the numeric keypad
					_event_struct.event_number = vk_numpad9;
				break;}
				case "vk_multiply": {
					//multiply key on the numeric keypad
					_event_struct.event_number = vk_multiply;
				break;}
				case "vk_divide": {
					//divide key on the numeric keypad
					_event_struct.event_number = vk_divide;
				break;}
				case "vk_add": {
					//add key on the numeric keypad
					_event_struct.event_number = vk_add;
				break;}
				case "vk_subtract": {
					//subtract key on the numeric keypad
					_event_struct.event_number = vk_subtract;
				break;}
				case "vk_decimal": {
					//decimal dot keys on the numeric keypad
					_event_struct.event_number = vk_decimal;
				break;}
				case "vk_lshift": {
					//left shift key
					_event_struct.event_number = vk_lshift;
				break;}
				case "vk_lcontrol": {
					//left control key
					_event_struct.event_number = vk_lcontrol;
				break;}
				case "vk_lalt": {
					//left alt key
					_event_struct.event_number = vk_lalt;
				break;}
				case "vk_rshift": {
					//right shift key
					_event_struct.event_number = vk_rshift;
				break;}
				case "vk_rcontrol": {
					//right control key
					_event_struct.event_number = vk_rcontrol;
				break;}
				case "vk_ralt": {
					//right alt key
					_event_struct.event_number = vk_ralt;
				break;}
				default: {
					_event_struct.event_number = real(_event_number);
				break;}
			}
		break;}
		case "ev_mouse": {
			//Mouse event
			switch (_event_number) {
				case "ev_left_button": {
					//Left button held down on object
					_event_struct.event_number = ev_left_button;
				break;}
				case "ev_right_button": {
					//Right button held down on object
					_event_struct.event_number = ev_right_button;
				break;}
				case "ev_middle_button": {
					//Middle button (or clickable wheel) held down on object
					_event_struct.event_number = ev_middle_button;
				break;}
				case "ev_no_button": {
					//No buttons held down
					_event_struct.event_number = ev_no_button;
				break;}
				case "ev_left_press": {
					//Left button just pressed on object
					_event_struct.event_number = ev_left_press;
				break;}
				case "ev_right_press": {
					//Right button just pressed on object
					_event_struct.event_number = ev_right_press;
				break;}
				case "ev_middle_press": {
					//Middle button (or clickable wheel) just pressed on object
					_event_struct.event_number = ev_middle_press;
				break;}
				case "ev_left_release": {
					//Left button just released on object
					_event_struct.event_number = ev_left_release;
				break;}
				case "ev_right_release": {
					//Right button just released on object
					_event_struct.event_number = ev_right_release;
				break;}
				case "ev_middle_release": {
					//Middle button just released on object
					_event_struct.event_number = ev_middle_release;
				break;}
				case "ev_mouse_enter": {
					//Mouse just entered object's bounding box
					_event_struct.event_number = ev_mouse_enter;
				break;}
				case "ev_mouse_leave": {
					//Mouse just left object's bounding box
					_event_struct.event_number = ev_mouse_leave;
				break;}
				case "ev_mouse_wheel_up": {
					//Mouse wheel scrolled upwards
					_event_struct.event_number = ev_mouse_wheel_up;
				break;}
				case "ev_mouse_wheel_down": {
					//Mouse wheel scrolled downwards
					_event_struct.event_number = ev_mouse_wheel_down;
				break;}
				case "ev_global_left_button": {
					//Left button held down anywhere
					_event_struct.event_number = ev_global_left_button;
				break;}
				case "ev_global_right_button": {
					//Right button held down anywhere
					_event_struct.event_number = ev_global_right_button;
				break;}
				case "ev_global_middle_button": {
					//Middle button (or clickable wheel) held down anywhere
					_event_struct.event_number = ev_global_middle_button;
				break;}
				case "ev_global_left_press": {
					//Left button just pressed anywhere
					_event_struct.event_number = ev_global_left_press;
				break;}
				case "ev_global_right_press": {
					//Right button just pressed anywhere
					_event_struct.event_number = ev_global_right_press;
				break;}
				case "ev_global_middle_press": {
					//Middle button (or clickable wheel) just pressed anywhere
					_event_struct.event_number = ev_global_middle_press;
				break;}
				case "ev_global_left_release": {
					//Left button just released anywhere
					_event_struct.event_number = ev_global_left_release;
				break;}
				case "ev_global_right_release": {
					//Right button just released anywhere
					_event_struct.event_number = ev_global_right_release;
				break;}
				case "ev_global_middle_release": {
					//Middle button just released anywhere
					_event_struct.event_number = ev_global_middle_release;
				break;}
			}
		break;}
		case "ev_gesture": {
			//A gesture event (Tap, Drag, Flick, Pinch or Rotate)
			switch (_event_number) {
				case "ev_gesture_tap": {
					//A single click/touch and release has been detected for an instance
					_event_struct.event_number = ev_gesture_tap;
				break;}
				case "ev_gesture_double_tap": {
					//Two quick touches/clicks and releases have been detected for an instance
					_event_struct.event_number = ev_gesture_double_tap;
				break;}
				case "ev_gesture_drag_start": {
					//The beginning of a drag gesture has been detected for an instance
					_event_struct.event_number = ev_gesture_drag_start;
				break;}
				case "ev_gesture_dragging": {
					//A touch/click has been held and moved for an instance
					_event_struct.event_number = ev_gesture_dragging;
				break;}
				case "ev_gesture_drag_end": {
					//The release of the touch/click from a drag has been detected for an instance
					_event_struct.event_number = ev_gesture_drag_end;
				break;}
				case "ev_gesture_flick": {
					//The release of a touch/click from a drag had enough movement for a flick event to be detected for the instance
					_event_struct.event_number = ev_gesture_flick;
				break;}
				case "ev_gesture_pinch_start": {
					//Two touches and a straight movement have been detected for an instance
					_event_struct.event_number = ev_gesture_pinch_start;
				break;}
				case "ev_gesture_pinch_in": {
					//The movement between two touches for an instance has been detected as inwards
					_event_struct.event_number = ev_gesture_pinch_in;
				break;}
				case "ev_gesture_pinch_out": {
					//The movement between two touches for an instance has been detected as outwards
					_event_struct.event_number = ev_gesture_pinch_out;
				break;}
				case "ev_gesture_pinch_end": {
					//The release of one (or both) touches for a pinch has been detected for an instance
					_event_struct.event_number = ev_gesture_pinch_end;
				break;}
				case "ev_gesture_rotate_start": {
					//The movement between two touches for an instance has been detected as a rotation
					_event_struct.event_number = ev_gesture_rotate_start;
				break;}
				case "ev_gesture_rotating": {
					//The movement between two touches for an instance has been detected as rotating
					_event_struct.event_number = ev_gesture_rotating;
				break;}
				case "ev_gesture_rotate_end": {
					//The release of one (or both) touches for a rotation has been detected for an instance
					_event_struct.event_number = ev_gesture_rotate_end;
				break;}
				case "ev_global_gesture_tap": {
					//A single click/touch and release has been detected anywhere in the room
					_event_struct.event_number = ev_global_gesture_tap;
				break;}
				case "ev_global_gesture_double_tap": {
					//Two quick touches/clicks and releases have been detected anywhere in the room
					_event_struct.event_number = ev_global_gesture_double_tap;
				break;}
				case "ev_global_gesture_drag_start": {
					//The beginning of a drag gesture has been detected anywhere in the room
					_event_struct.event_number = ev_global_gesture_drag_start;
				break;}
				case "ev_global_gesture_dragging": {
					//A touch/click has been held and moved anywhere in the room
					_event_struct.event_number = ev_global_gesture_dragging;
				break;}
				case "ev_global_gesture_drag_end": {
					//The release of the touch/click from a drag has been detected anywhere in the room
					_event_struct.event_number = ev_global_gesture_drag_end;
				break;}
				case "ev_global_gesture_flick": {
					//The release of a touch/click from a drag had enough movement for a flick event to be detected anywhere in the room
					_event_struct.event_number = ev_global_gesture_flick;
				break;}
				case "ev_global_gesture_pinch_start": {
					//Two touches and a straight movement have been detected anywhere in the room
					_event_struct.event_number = ev_global_gesture_pinch_start;
				break;}
				case "ev_global_gesture_pinch_in": {
					//The movement between two touches anywhere in the room has been detected as inwards
					_event_struct.event_number = ev_global_gesture_pinch_in;
				break;}
				case "ev_global_gesture_pinch_out": {
					//The movement between two touches anywhere in the room has been detected as outwards
					_event_struct.event_number = ev_global_gesture_pinch_out;
				break;}
				case "ev_global_gesture_pinch_end": {
					//The release of one (or both) touches for a pinch has been detected anywhere in the room
					_event_struct.event_number = ev_global_gesture_pinch_end;
				break;}
				case "ev_global_gesture_rotate_start": {
					//The movement between two touches anywhere in the room has been detected as a rotation
					_event_struct.event_number = ev_global_gesture_rotate_start;
				break;}
				case "ev_global_gesture_rotating": {
					//The movement between two touches anywhere in the room has been detected as rotating
					_event_struct.event_number = ev_global_gesture_rotating;
				break;}
				case "ev_global_gesture_rotate_end": {
					//The release of one (or both) touches for a rotation has been detected anywhere in the room
					_event_struct.event_number = ev_global_gesture_rotate_end;
				break;}
			}
		break;}
		case "ev_collision": {
			//Collision with an object
			_event_struct.event_type = ev_collision;
			_event_struct.event_number = real(_event_number);
		break;}
		case "ev_other": {
			//One of the actions listed under 'Other'
			switch (_event_number) {
				case "ev_outside": {
					//Whether the instance is outside of the room
					_event_struct.event_number = ev_outside;
				break;}
				case "ev_boundary": {
					//Whether the instance is intersecting the boundary
					_event_struct.event_number = ev_boundary;
				break;}
				case "ev_outside_view0": {
					//Whether the instance is outside the given view (0 to 7)
					_event_struct.event_number = ev_outside_view0;
				break;}
				case "ev_outside_view1": {
					//Whether the instance is outside the given view (0 to 7)
					_event_struct.event_number = ev_outside_view1;
				break;}
				case "ev_outside_view2": {
					//Whether the instance is outside the given view (0 to 7)
					_event_struct.event_number = ev_outside_view2;
				break;}
				case "ev_outside_view3": {
					//Whether the instance is outside the given view (0 to 7)
					_event_struct.event_number = ev_outside_view3;
				break;}
				case "ev_outside_view4": {
					//Whether the instance is outside the given view (0 to 7)
					_event_struct.event_number = ev_outside_view4;
				break;}
				case "ev_outside_view5": {
					//Whether the instance is outside the given view (0 to 7)
					_event_struct.event_number = ev_outside_view5;
				break;}
				case "ev_outside_view6": {
					//Whether the instance is outside the given view (0 to 7)
					_event_struct.event_number = ev_outside_view6;
				break;}
				case "ev_outside_view7": {
					//Whether the instance is outside the given view (0 to 7)
					_event_struct.event_number = ev_outside_view7;
				break;}
				case "ev_boundary_view0": {
					//Whether the instance is interesecting with the boundary of the given view (0 to 7)
					_event_struct.event_number = ev_boundary_view0;
				break;}
				case "ev_boundary_view1": {
					//Whether the instance is interesecting with the boundary of the given view (0 to 7)
					_event_struct.event_number = ev_boundary_view1;
				break;}
				case "ev_boundary_view2": {
					//Whether the instance is interesecting with the boundary of the given view (0 to 7)
					_event_struct.event_number = ev_boundary_view2;
				break;}
				case "ev_boundary_view3": {
					//Whether the instance is interesecting with the boundary of the given view (0 to 7)
					_event_struct.event_number = ev_boundary_view3;
				break;}
				case "ev_boundary_view4": {
					//Whether the instance is interesecting with the boundary of the given view (0 to 7)
					_event_struct.event_number = ev_boundary_view4;
				break;}
				case "ev_boundary_view5": {
					//Whether the instance is interesecting with the boundary of the given view (0 to 7)
					_event_struct.event_number = ev_boundary_view5;
				break;}
				case "ev_boundary_view6": {
					//Whether the instance is interesecting with the boundary of the given view (0 to 7)
					_event_struct.event_number = ev_boundary_view6;
				break;}
				case "ev_boundary_view7": {
					//Whether the instance is interesecting with the boundary of the given view (0 to 7)
					_event_struct.event_number = ev_boundary_view7;
				break;}
				case "ev_game_start": {
					//Only triggered at the start of the game
					_event_struct.event_number = ev_game_start;
				break;}
				case "ev_game_end": {
					//Only triggered at the end of the game
					_event_struct.event_number = ev_game_end;
				break;}
				case "ev_room_start": {
					//Only triggered at the start of a room
					_event_struct.event_number = ev_room_start;
				break;}
				case "ev_room_end": {
					//Only triggered at the end of a room
					_event_struct.event_number = ev_room_end;
				break;}
				case "ev_animation_end": {
					//If the object's sprite has reached the end of its animation
					_event_struct.event_number = ev_animation_end;
				break;}
				case "ev_animation_update": {
					//Animation event that runs every step for objects that use skeletal animations
					_event_struct.event_number = ev_animation_update;
				break;}
				case "ev_animation_event": {
					//Animation event that runs for skeletal animations as assigned in the skeletal animation tool
					_event_struct.event_number = ev_animation_event;
				break;}
				case "ev_end_of_path": {
					//If the object has reached the end of a path it is following
					_event_struct.event_number = ev_end_of_path;
				break;}
				case "ev_user0": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user0;
				break;}
				case "ev_user1": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user1;
				break;}
				case "ev_user2": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user2;
				break;}
				case "ev_user3": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user3;
				break;}
				case "ev_user4": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user4;
				break;}
				case "ev_user5": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user5;
				break;}
				case "ev_user6": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user6;
				break;}
				case "ev_user7": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user7;
				break;}
				case "ev_user8": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user8;
				break;}
				case "ev_user9": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user9;
				break;}
				case "ev_user10": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user10;
				break;}
				case "ev_user11": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user11;
				break;}
				case "ev_user12": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user12;
				break;}
				case "ev_user13": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user13;
				break;}
				case "ev_user14": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user14;
				break;}
				case "ev_user15": {
					//One of the 16 available user events.
					_event_struct.event_number = ev_user15;
				break;}
				case "ev_broadcast_message": {
					//Broadcast Message event used for sprites and sequences
					_event_struct.event_number = ev_broadcast_message;
				break;}
			}
		break;}
		case "ev_draw": {
			//Draw event. NOTE This event cannot be forced outside of a draw event and the constants are only for identifying the event when performed in these cases.
			switch (_event_number) {
				case "ev_draw_normal": {
					//The normal draw event.
					_event_struct.event_number = ev_draw_normal;
				break;}
				case "ev_draw_begin": {
					//The draw begin event.
					_event_struct.event_number = ev_draw_begin;
				break;}
				case "ev_draw_end": {
					//The draw end event.
					_event_struct.event_number = ev_draw_end;
				break;}
				case "ev_draw_pre": {
					//The pre draw event.
					_event_struct.event_number = ev_draw_pre;
				break;}
				case "ev_draw_post": {
					//The post draw event.
					_event_struct.event_number = ev_draw_post;
				break;}
				case "ev_gui": {
					//The draw gui event.
					_event_struct.event_number = ev_gui;
				break;}
				case "ev_gui_begin": {
					//The draw gui begin event.
					_event_struct.event_number = ev_gui_begin;
				break;}
				case "ev_gui_end": {
					//The draw gui end event.
					_event_struct.event_number = ev_gui_end;
				break;}
			}
		break;}
		}
	
	return _event_struct;
}