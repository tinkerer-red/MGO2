/*
/// @desc FSM
#region states
var _states = [
ITEM_STATE_WEAPON_PRE_SPAWN,
ITEM_STATE_WEAPON_SPAWN,
ITEM_STATE_WEAPON_POST_SPAWN,

ITEM_STATE_WEAPON_PRE_ATTACK,
ITEM_STATE_WEAPON_ATTACK,
ITEM_STATE_WEAPON_POST_ATTACK,

ITEM_STATE_WEAPON_PRE_SPAWN_ENTITY,
ITEM_STATE_WEAPON_SPAWN_ENTITY,
ITEM_STATE_WEAPON_POST_SPAWN_ENTITY,

ITEM_STATE_WEAPON_PRE_COLLIDE,
ITEM_STATE_WEAPON_COLLIDE,
ITEM_STATE_WEAPON_POST_COLLIDE,

ITEM_STATE_WEAPON_PRE_DESPAWN,
ITEM_STATE_WEAPON_DESPAWN,
ITEM_STATE_WEAPON_POST_DESPAWN,
]
#endregion

fsm = new SnowState(_states[0]);

//create the states
var _size = _states;
var _i=0; repeat(_size) {
	
	fsm.add(_states[_i], {
		enter: function() {
			__continue_to_next_step = true;
			__state_mods = array_copy(weapon_mods[$ get_current_state()]);
			
			var _size = array_length(__state_mods)
			
			if (_size == 0) {
				fsm.trigger("t_continue")
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
				fsm.trigger("t_continue")
			}
		},
		
		leave: function(){
			//leave
		}
	});
	
_i+=1;}//end repeat loop

//create the transitions
var _i=0; repeat(_size-1) {
	fsm.add_transition("t_continue", _states[_i], _states[_i+1]);
_i+=1;}//end repeat loop