EVENT_METHOD;

disable = false;
target = noone;
mouse_inactivity = false;
mouse_down_on_object = false;
mouse_timer = 0;
prev_mouse_xx = -1;
prev_mouse_yy = -1;

#macro EMOTE_RADIAL_ACTIVATION_TIME 10

input_register_id = INPUT.register({
	depth: 50000, // lowest depth
	context: id,
	callback: function(_input) {
		if (disable || _input.consumed) {
			mouse_down_on_object = false;
			return false;
		}
		
		//target = global.logged_in_user_id;
		var _player_inst = oPlayer //ENTITIES.get(target)
		
		//return true if input has been captured
		var _should_consume = false;
		
		with (_player_inst) {
			
			#region Movement
			#region Pressed
			var move_up = INPUT.check(ACTION.MOVE_UP);
			var move_down = INPUT.check(ACTION.MOVE_DOWN);
			var move_left = INPUT.check(ACTION.MOVE_LEFT);
			var move_right = INPUT.check(ACTION.MOVE_RIGHT);
			if (move_down-move_up != 0) || (move_right-move_left != 0) {
				//transition the player to movement state
				var _state = csm.get_state("move");
				if (_state.fsm.get_current_state() == "deactive") {
					_state.move_to_sub_state("norm")
				}
			}
			#endregion
			#region Down
			if (move_down-move_up != 0) || (move_right-move_left != 0) {
				input_vector = normalize_vector_to_analog(move_right-move_left, move_down-move_up)
			}
			#endregion
			#region Released
			//if we're moving and no buttons are pressed
			if (move_down-move_up == 0) && (move_right-move_left == 0) {
				//reset input vector
				input_vector = {x:0,y:0};
				
				//handle state
				var _state = csm.get_state("move");
				_state.move_to_sub_state("deactive");
			}
			#endregion
			#endregion
			
		}
		
		return _should_consume;
	},
});

