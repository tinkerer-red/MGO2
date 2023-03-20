/// @desc CSM - Concurrent State Machine
csm = new ConcurrentStateMachine();

csm.add_state("init", {
	enter: function() {
		//enter
		var _return = RunHooks(MC_PRE_ENTITY_INIT);
	},
	step: function() {
		//step
		var _return = RunHooks(MC_ENTITY_INIT)
	},
	leave: function() {
		//leave
		var _return = RunHooks(MC_POST_ENTITY_INIT);
	}
});

csm.add_state("idle", {
	enter: function() {
		//enter
		var _return = RunHooks(MC_PRE_ENTITY_IDLE_UPDATE);
	},
	step: function() {
		//step
		var _return = RunHooks(MC_ENTITY_IDLE_UPDATE)
	},
	leave: function(){
		//leave
		var _return = RunHooks(MC_POST_ENTITY_IDLE_UPDATE)
	}
});

csm.add_state("movement", {
	enter: function() {
		//enter
		var _return = RunHooks(MC_PRE_ENTITY_MOVE);
	},
	step: function() {
		//step
		var _return = RunHooks(MC_ENTITY_MOVE)
	},
	leave: function(){
		//leave
		var _return = RunHooks(MC_POST_ENTITY_MOVE)
	}
});
log(["self", self])
is_object_instance(self)
log(["id", id])
is_object_instance(id)

log(["csm", csm])

/*
csm.add_state("attack_button", {
	enter: function() {
		//find out what button is being pressed
		
		//assign the weapon mods
		weapon_mods = struct_copy()
		
		//trigger the transition
		csm.trigger("t_"+ITEM_STATE_WEAPON_PRE_BUTTON_PRESSED)
	},
});
csm.add_state_child("attack_button", ITEM_STATE_WEAPON_PRE_BUTTON_PRESSED, {
	enter: function() {
		__continue_to_next_step = true;
		__state_mods = array_copy(weapon_mods[$ get_current_state()]);
			
		var _size = array_length(__state_mods)
			
		if (_size == 0) {
			csm.trigger("t_continue")
		}
	},
	
	begin_step: function() {
		__continue_to_next_step = true;
		run_step_modifiers();
	},
	step: function() {
		run_step_modifiers();
	},
	end_step: function() {
		run_step_modifiers();
	},
	
	draw_begin: function() {
		run_step_modifiers()
	},
	draw: function() {
		run_step_modifiers()
	},
	draw_end: function() {
		run_step_modifiers();
			
		if (__continue_to_next_step){
			csm.trigger("t_"+ITEM_STATE_WEAPON_BUTTON_PRESSED)
		}
	},
	
	leave: function(){
		//leave
	}
});
csm.add_state_child("attack_button", ITEM_STATE_WEAPON_BUTTON_PRESSED, {
	enter: function() {
		__continue_to_next_step = true;
		__state_mods = array_copy(weapon_mods[$ get_current_state()]);
			
		var _size = array_length(__state_mods)
			
		if (_size == 0) {
			csm.trigger("t_continue")
		}
	},
	
	begin_step: function() {
		__continue_to_next_step = true;
		run_step_modifiers();
	},
	step: function() {
		run_step_modifiers();
	},
	end_step: function() {
		run_step_modifiers();
	},
	
	draw_begin: function() {
		run_step_modifiers()
	},
	draw: function() {
		run_step_modifiers()
	},
	draw_end: function() {
		run_step_modifiers();
			
		if (__continue_to_next_step){
			csm.trigger("t_"+ITEM_STATE_WEAPON_POST_BUTTON_PRESSED)
		}
	},
	
	leave: function(){
		//leave
	}
});
csm.add_state_child("attack_button", ITEM_STATE_WEAPON_POST_BUTTON_PRESSED, {
	enter: function() {
		__continue_to_next_step = true;
		__state_mods = array_copy(weapon_mods[$ get_current_state()]);
			
		var _size = array_length(__state_mods)
			
		if (_size == 0) {
			csm.trigger("t_continue")
		}
	},
	
	begin_step: function() {
		__continue_to_next_step = true;
		run_step_modifiers();
	},
	step: function() {
		run_step_modifiers();
	},
	end_step: function() {
		run_step_modifiers();
	},
	
	draw_begin: function() {
		run_step_modifiers()
	},
	draw: function() {
		run_step_modifiers()
	},
	draw_end: function() {
		run_step_modifiers();
			
		if (__continue_to_next_step){
			csm.trigger("t_attack")
		}
	},
	
	leave: function(){
		//leave
	}
});
*/
csm.add_state("attack", {
	enter: function() {
		//enter
		var _return = RunHooks(MC_PRE_ENTITY_ATTACK);
	},
	step: function() {
		//step
		var _return = RunHooks(MC_ENTITY_ATTACK)
	},
	leave: function(){
		//leave
		input_attack_id = undefined;
		var _return = RunHooks(MC_POST_ENTITY_ATTACK);
	}
});

csm.add_state("damaged", {
	enter: function() {
		//enter
		var _return = RunHooks(MC_PRE_ENTITY_DAMAGE);
	},
	step: function() {
		//step
		var _return = RunHooks(MC_ENTITY_DAMAGE)
	},
	leave: function(){
		//leave
		var _return = RunHooks(MC_POST_ENTITY_DAMAGE)
	}
});

csm.add_state("death", {
	enter: function() {
		//enter
		var _return = RunHooks(MC_PRE_ENTITY_DEATH);
	},
	step: function() {
		//step
		var _return = RunHooks(MC_ENTITY_DEATH)
	},
	leave: function(){
		//leave
		var _return = RunHooks(MC_POST_ENTITY_DEATH)
	}
});

csm.add_state("animation", { //used for anything where the player is locked in a state, like opening chests, ending a dungeon, or teleporting
	enter: function() {
		//enter
		var _return = RunHooks(MC_PRE_ENTITY_ANIMATION);
	},
	step: function() {
		//step
		var _return = RunHooks(MC_ENTITY_ANIMATION)
	},
	leave: function(){
		//leave
		var _return = RunHooks(MC_POST_ENTITY_ANIMATION)
	}
});

