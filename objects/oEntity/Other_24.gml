/// @desc CONSTRUCTOR

state_machine = function() : State() constructor {
	self.next_substate_queued = false;
	self.allow_transition = false;
	
	var _enter_event = function() {
		//init the modifiers
		__owner.modifiers.init_modifiers("ENTITY_STATE_"+string_upper_fast(__owner.csm.current_state_id)+"_"+string_upper_fast(fsm.get_current_state()));
		
		postpone_transition = false;
		
		if (is_undefined(desired_sub_state)) {
			next_substate_queued = false;
		}
		else if (desired_sub_state == fsm.get_current_state()) {
			next_substate_queued = false;
		}
	}
	var _update_event = function() {
		var _ready_to_move_on = __owner.modifiers.run_modifiers("ENTITY_STATE_"+string_upper_fast(__owner.csm.current_state_id)+"_"+string_upper_fast(fsm.get_current_state()));
		
		if (_ready_to_move_on) {
			allow_transition = true;
		}
	}
	var _leave_event = function() {
		__owner.modifiers.clean_up_modifiers("ENTITY_STATE_"+string_upper_fast(__owner.csm.current_state_id)+"_"+string_upper_fast(fsm.get_current_state()));
	}
	
	self.fsm = new SnowState("deactive");
	
	self.fsm.add("pre", {
		enter: _enter_event,
		update: _update_event,
		leave: _leave_event,
	})
	self.fsm.add("norm", {
		enter: _enter_event,
		update: _update_event,
		leave: _leave_event,
	})
	self.fsm.add("post", {
		enter: _enter_event,
		update: _update_event,
		leave: _leave_event,
	})
	
	self.fsm.add("deactive", {
		enter: _enter_event,
		update: _update_event,
	})
	
	self.fsm.add_transition("t_force_next", "deactive", "pre");
	self.fsm.add_transition("t_force_next", "pre", "norm");
	self.fsm.add_transition("t_force_next", "norm", "post");
	self.fsm.add_transition("t_force_next", "post", "deactive");
	
	self.fsm.add_transition("t_queue_next", "deactive", "pre", function() {return (allow_transition)});
	self.fsm.add_transition("t_queue_next", "pre", "norm", function() {return (allow_transition)});
	self.fsm.add_transition("t_queue_next", "norm", "post", function() {return (allow_transition)});
	self.fsm.add_transition("t_queue_next", "post", "deactive", function() {return (allow_transition)});
	
	self.fsm.add_transition("t_attempt_next", "deactive", "pre", function() {return (allow_transition)});
	self.fsm.add_transition("t_attempt_next", "pre", "norm", function() {return (allow_transition)});
	self.fsm.add_transition("t_attempt_next", "norm", "post", function() {return (allow_transition)});
	self.fsm.add_transition("t_attempt_next", "post", "deactive", function() {return (allow_transition)});
	
	self.add_event("update", function() {
		var _reset_postpones =  (event_type == ev_step && event_number == ev_step_begin);
		if (_reset_postpones) {
			if (allow_transition)
			&& (next_substate_queued) {
				var _successful = fsm.trigger("t_attempt_next");
				if (_successful) {
					if (!is_undefined(next_substate_queued_callback)) {
						next_substate_queued_callback();
					}
					next_substate_queued_callback = undefined;
				}
			}
			
			allow_transition = false;
		}
		
		fsm.update();
		
		return allow_transition;
	});
}

async_controller = function() : State() constructor {
	self.add_event("update", function() {
		__owner.modifiers.run_async_modifiers();
	});
}