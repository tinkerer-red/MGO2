/// @desc CSM - Concurrent State Machine
csm = new ConcurrentStateMachine();

csm.add_state("init", {
	enter: function() {
		//enter
		csm.current_state.phase_state = "pre";
	},
	update: function() {
		var _current_state = csm.current_state;
		var _phase = _current_state.phase_state;
		var _postpone_state_change = false;
		
		if (csm.current_state.phase_state == "pre") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_IDLE_PRE);
			if (!_postpone_state_change) {
				csm.current_state.phase_state = "norm";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "norm") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_IDLE_NORM);
			if (!_postpone_state_change) {
				csm.current_state.phase_state = "post";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "post") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_IDLE_POST);
			if (!_postpone_state_change) {
				_current_state.deactivate();
				_postpone_state_change = false;
			}
		}
	},
	leave: function() {
		//leave
	}
});

csm.add_state("idle", {
	enter: function() {
		//enter
		csm.current_state.phase_state = "pre";
	},
	update: function() {
		var _current_state = csm.current_state;
		var _phase = _current_state.phase_state;
		var _postpone_state_change = false;
		
		if (csm.current_state.phase_state == "pre") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_IDLE_PRE);
			if (!_postpone_state_change) {
				csm.current_state.phase_state = "norm";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "norm") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_IDLE_NORM);
			if (!_postpone_state_change) {
				csm.current_state.phase_state = "post";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "post") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_IDLE_POST);
			if (!_postpone_state_change) {
				_current_state.deactivate();
				_postpone_state_change = false;
			}
		}
	},
	leave: function() {
		//leave
	}
});

csm.add_state("movement", {
	enter: function() {
		//enter
		csm.current_state.phase_state = "pre";
		csm.current_state.should_end = false;
	},
	update: function() {
		var _current_state = csm.current_state;
		var _phase = _current_state.phase_state;
		var _postpone_state_change = false;
		
		if (csm.current_state.phase_state == "pre") {
			//log("pre")
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_MOVE_PRE);
			if (!_postpone_state_change) {
				//log(["===1===_current_state", _current_state.toString()])
				csm.current_state.phase_state = "norm";
				//log(["===2===_current_state", _current_state.toString()])
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "norm") {
			//log("norm")
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_MOVE_NORM);
			if (!_postpone_state_change)
			&& (csm.current_state.should_end) {
				csm.current_state.phase_state = "post";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "post") {
			//log("post")
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_MOVE_POST);
			if (!_postpone_state_change) {
				if (csm.current_state.should_end) {
					_current_state.deactivate();
					_postpone_state_change = false;
				}
				else{
					//if we no longer need to end the state we will be returning to pre walk
				}
				
			}
		}
	},
	leave: function() {
		//leave
	}
});

csm.add_state("attack", {
	enter: function() {
		//enter
		csm.current_state.phase_state = "pre";
	},
	update: function() {
		var _current_state = csm.current_state;
		var _phase = _current_state.phase_state;
		var _postpone_state_change = false;
		
		if (csm.current_state.phase_state == "pre") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_ATTACK_PRE);
			if (!_postpone_state_change) {
				csm.current_state.phase_state = "norm";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "norm") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_ATTACK_NORM);
			if (!_postpone_state_change) {
				csm.current_state.phase_state = "post";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "post") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_ATTACK_POST);
			if (!_postpone_state_change) {
				_current_state.deactivate();
				_postpone_state_change = false;
			}
		}
	},
	leave: function() {
		//leave
	}
});

csm.add_state("damaged", {
	enter: function() {
		//enter
		csm.current_state.phase_state = "pre";
	},
	update: function() {
		var _current_state = csm.current_state;
		var _phase = _current_state.phase_state;
		var _postpone_state_change = false;
		
		if (csm.current_state.phase_state == "pre") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_DAMAGED_PRE);
			if (!_postpone_state_change) {
				csm.current_state.phase_state = "norm";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "norm") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_DAMAGED_NORM);
			if (!_postpone_state_change) {
				csm.current_state.phase_state = "post";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "post") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_DAMAGED_POST);
			if (!_postpone_state_change) {
				_current_state.deactivate();
				_postpone_state_change = false;
			}
		}
	},
	leave: function() {
		//leave
	}
});

csm.add_state("death", {
	enter: function() {
		//enter
		csm.current_state.phase_state = "pre";
	},
	update: function() {
		var _current_state = csm.current_state;
		var _phase = _current_state.phase_state;
		var _postpone_state_change = false;
		
		if (csm.current_state.phase_state == "pre") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_DEATH_PRE);
			if (!_postpone_state_change) {
				csm.current_state.phase_state = "norm";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "norm") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_DEATH_NORM);
			if (!_postpone_state_change) {
				csm.current_state.phase_state = "post";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "post") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_DEATH_POST);
			if (!_postpone_state_change) {
				_current_state.deactivate();
				_postpone_state_change = false;
			}
		}
	},
	leave: function() {
		//leave
	}
});

csm.add_state("animation", { //used for anything where the player is locked in a state, like opening chests, ending a dungeon, or teleporting
	enter: function() {
		//enter
		csm.current_state.phase_state = "pre";
	},
	update: function() {
		var _current_state = csm.current_state;
		var _phase = _current_state.phase_state;
		var _postpone_state_change = false;
		
		if (csm.current_state.phase_state == "pre") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_IDLE_PRE);
			if (!_postpone_state_change) {
				csm.current_state.phase_state = "norm";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "norm") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_IDLE_NORM);
			if (!_postpone_state_change) {
				csm.current_state.phase_state = "post";
				_postpone_state_change = false;
			}
		}
		
		if (csm.current_state.phase_state == "post") {
			_postpone_state_change += modifiers.run_modifiers(ENTITY_STATE_IDLE_POST);
			if (!_postpone_state_change) {
				_current_state.deactivate();
				_postpone_state_change = false;
			}
		}
	},
	leave: function() {
		//leave
	}
});
//state
//pre/normal/post
//step event