#region Eventstates
#region Weapon Event States

#macro ITEM_STATE_BUTTON_PRESSED_PRE "WEAPON_BUTTON_PRESSED_PRE"
#macro ITEM_STATE_BUTTON_PRESSED_NORM "WEAPON_BUTTON_PRESSED_NORM"
#macro ITEM_STATE_BUTTON_PRESSED_POST "WEAPON_BUTTON_PRESSED_POST"

#macro ITEM_STATE_SPAWN_PRE "WEAPON_SPAWN_PRE"
#macro ITEM_STATE_SPAWN_NORM "WEAPON_SPAWN_NORM"
#macro ITEM_STATE_SPAWN_POST "WEAPON_SPAWN_POST"

#macro ITEM_STATE_ATTACK_PRE "WEAPON_ATTACK_PRE"
#macro ITEM_STATE_ATTACK_NORM "WEAPON_ATTACK_NORM"
#macro ITEM_STATE_ATTACK_POST "WEAPON_ATTACK_POST"

#macro ITEM_STATE_SPAWN_ENTITY_PRE "WEAPON_SPAWN_ENTITY_PRE"
#macro ITEM_STATE_SPAWN_ENTITY_NORM "WEAPON_SPAWN_ENTITY_NORM"
#macro ITEM_STATE_SPAWN_ENTITY_POST "WEAPON_SPAWN_ENTITY_POST"

#macro ITEM_STATE_COLLIDE_PRE "WEAPON_COLLIDE_PRE"
#macro ITEM_STATE_COLLIDE_NORM "WEAPON_COLLIDE_NORM"
#macro ITEM_STATE_COLLIDE_POST "WEAPON_COLLIDE_POST"

#macro ITEM_STATE_DESPAWN_PRE "WEAPON_DESPAWN_PRE"
#macro ITEM_STATE_DESPAWN_NORM "WEAPON_DESPAWN_NORM"
#macro ITEM_STATE_DESPAWN_POST "WEAPON_DESPAWN_POST"

#endregion
#region Entity Event States
#macro ENTITY_STATE_IDLE_PRE	"ENTITY_STATE_IDLE_PRE"
#macro ENTITY_STATE_IDLE_NORM	"ENTITY_STATE_IDLE_NORM"
#macro ENTITY_STATE_IDLE_POST	"ENTITY_STATE_IDLE_POST"

#macro ENTITY_STATE_MOVE_PRE	"ENTITY_STATE_MOVE_PRE"
#macro ENTITY_STATE_MOVE_NORM	"ENTITY_STATE_MOVE_NORM"
#macro ENTITY_STATE_MOVE_POST	"ENTITY_STATE_MOVE_POST"

#macro ENTITY_STATE_ATTACK_PRE	"ENTITY_STATE_ATTACK_PRE"
#macro ENTITY_STATE_ATTACK_NORM	"ENTITY_STATE_ATTACK_NORM"
#macro ENTITY_STATE_ATTACK_POST	"ENTITY_STATE_ATTACK_POST"

#macro ENTITY_STATE_DAMAGED_PRE	"ENTITY_STATE_DAMAGED_PRE"
#macro ENTITY_STATE_DAMAGED_NORM	"ENTITY_STATE_DAMAGED_NORM"
#macro ENTITY_STATE_DAMAGED_POST	"ENTITY_STATE_DAMAGED_POST"

#macro ENTITY_STATE_DEATH_PRE	"ENTITY_STATE_DEATH_PRE"
#macro ENTITY_STATE_DEATH_NORM	"ENTITY_STATE_DEATH_NORM"
#macro ENTITY_STATE_DEATH_POST	"ENTITY_STATE_DEATH_POST"

#macro ENTITY_STATE_ANIM_PRE	"ENTITY_STATE_ANIM_PRE"
#macro ENTITY_STATE_ANIM_NORM	"ENTITY_STATE_ANIM_NORM"
#macro ENTITY_STATE_ANIM_POST	"ENTITY_STATE_ANIM_POST"
#endregion
#region World Event States

#endregion
#endregion

enum MOD_SYNC_TYPE {
	SYNC, // the state transitions will be delayed if this mod returns true
	PASSIVE, // the modifier will run until the state changes, it will always return that its 
	ASYNC // the modifier will be queued up to run despite the state changing
}

function Modifier(_modifier_id, _mod_sync_type, _name, _sprite, _description, _quality) constructor {
	modifier_id = _modifier_id;
	name = _name;
	description = _description;
	quality = _quality;
	mod_sync_type = _mod_sync_type;
	owner = other;
	
	mod_ran_this_frame = false;
	
	registed_events = [];
	events = {};
	
	static item_owner = noone; //the item this modifier is attached to
	static owner = noone; // the entity which owns this indevidual modifier
	static modifier_count = 1;
	
	//eventListeners = {};
	static init = function() {
		//init again incase the modifier relies on knowing how many mods it has
		var _size = array_length(self.registed_events);
		var _event, _event_steps, _func;
		var _i=0; repeat(_size) {
			_event = self.registed_events[_i];
			_event_steps = self.events[$ _event];
			
			_func = method(self, _event_steps.init);
			_func();
		_i+=1;}//end repeat loop
	}
	
	static clean_up = function() {
		//init again incase the modifier relies on knowing how many mods it has
		var _size = array_length(self.registed_events);
		var _event, _event_steps, _func;
		var _i=0; repeat(_size) {
			_event = self.registed_events[_i];
			_event_steps = self.events[$ _event];
			
			_func = method(self, _event_steps.clean_up);
			_func();
		_i+=1;}//end repeat loop
	}
	
	static modifier_conditions = function() {
		//if all of the conditions apply, can this modifier be applied to the item?
		
		//return true or false
		return true;
	}
	
	static init_item_flags = function() {
		//once a modifier is applied to an item it will over ride it's existing flags
	}
	
	static register_event = function(_event, _mod_sync_type, _event_struct) {
		array_push(registed_events, _event);
		_event_struct.sync_type = _mod_sync_type;
		events[$ _event] = _event_struct;
	}
	
	static remove_mod_from_queue = function() {
		switch (mod_sync_type) {
			case MOD_SYNC_TYPE.SYNC: {
				
			break; }
			case MOD_SYNC_TYPE.PASSIVE: {
				//do nothing, these mods dont need to be removed
			break; }
			case MOD_SYNC_TYPE.ASYNC: {
				
			break; }
		}
	}
}

function ModifierHandler() constructor {
	modifiers = {};
	
	async_mod_queue = {};
	
	__add_modifier = function(_mod) {
		modifiers[$ _mod.modifier_id] = _mod;
	}
	
	__remove_modifier = function(_mod) {
		var _key = get_mod_id(_mod);
		var _deleted_mod = modifiers[$ _key.modifier_id];
		
		variable_struct_remove(modifiers, _key);
		//init again incase the modifier relies on knowing how many mods it has
		_deleted_mod.eventListeners.destroy();
		delete _deleted_mod;
	}
	
	add_modifier = function(_mod, _count = undefined) {
		var _input_count = (is_undefined(_count)) ? 1 : _count;
		
		if (has_modifier(_mod)) {
			var _current_count = get_modifier_count(_mod);
			set_modifier_count(_mod, _current_count+_input_count);
		}
		else {
			_mod.modifier_count = _input_count;
			__add_modifier(_mod);
		}
		
		init_mod(_mod);
	}
	
	remove_modifier = function(_mod) {
		if (has_modifier(_mod)) {
			var _current_count = get_modifier_count(_mod);
			
			if (_current_count > 1) {
				set_modifier_count(_mod, _current_count-1)
				_mod.eventListeners.destroy();
			}
			else {
				__remove_modifier(_mod)
			}
		}
	}
	
	get_mod_id = function(_mod) {
		if (is_string(_mod)) {
			return _mod;
		}
		else {
			return _mod.modifier_id;
		}
	}
	
	run_modifiers = function(_event, _step = undefined) {
		var _names = variable_struct_get_names(modifiers);
		var _size = variable_struct_names_count(modifiers);
		var _returned = false;
		var _event_struct, 
		var _key, _mod, _return;
		var _ready_to_move_on = true;
		
		var _i=0; repeat(_size) {
			_key = _names[_i];
			_mod = modifiers[$ _key];
			
			if (array_contains(_mod.registed_events, _event)) {
				//get the event which is being triggered
				if (variable_struct_exists(_mod.events, _event)) {
					_event_struct = _mod.events[$ _event];
					
					if (_event_struct.sync_type == MOD_SYNC_TYPE.ASYNC) {
						queue_async_mod(_mod);
						_i+=1;
						continue;
					}
					
					_return = run_modifiers_steps(_mod, _event_struct, _step);
					
					_ready_to_move_on = (is_undefined(_return)) ? false : _return;
				}
			}
			
			_returned += _ready_to_move_on;
			
		_i+=1;}//end repeat loop
		
		//return true if all modifiers are ready to be deleted or move on
		return (_size <= _returned);
	}
	
	run_async_modifiers = function() {
		var _names = variable_struct_get_names(async_mod_queue);
		var _size = variable_struct_names_count(async_mod_queue);
		var _event_struct, 
		var _key, _mod, _event_key, _event_struct;
		var _ready_to_delete = undefined;
		var _j;
		
		
		var _i=0; repeat(_size) {
			_key = _names[_i];
			_mod = async_mod_queue[$ _key];
			
			var _event_names = variable_struct_get_names(_mod.events);
			var _event_size = variable_struct_names_count(_mod.events);
			
			_j=0; repeat(_event_size) {
				_event_key = _event_names[_j];
				_event_struct = _mod.events[$ _event_key];
				
				if (_event_struct.sync_type == MOD_SYNC_TYPE.ASYNC) {
					_ready_to_delete = run_modifiers_steps(_mod, _event_struct);
					
					if (!_ready_to_delete) {
						var _func = method(_mod, _event_struct.clean_up);
						_func();
						variable_struct_remove(async_mod_queue, _key);
					}
				}
			_j+=1; }; //end inner repeat
		_i+=1;}//end repeat loop
		
		
	}
	
	run_modifiers_steps = function(_mod, _event_struct, _step = undefined) {
		
		if (is_undefined(_step)) {
			//if step is undefined then run the relevent step event
			var _event_strings = event_to_string_struct();
			var _ev_type = _event_strings.ev_type;
			var _ev_number = _event_strings.ev_number;
		}
		else {
			//otherwise run the specifically defined event such as enter/leave
			var _ev_type = _step.ev_type;
			var _ev_number = _step.ev_number;
		}
		
		//get the parent step
		if (variable_struct_exists(_event_struct, _ev_type)) {
			var _mod_ev_type = _event_struct[$ _ev_type];
						
			//get the sub step
			if (variable_struct_exists(_mod_ev_type, _ev_number)) {
				_mod.mod_ran_this_frame = true;
				
				switch (_event_struct.sync_type) {
					case MOD_SYNC_TYPE.SYNC: {
						var _func = method(_mod, _mod_ev_type[$ _ev_number]);
						return _func();
					break;}
					case MOD_SYNC_TYPE.PASSIVE: {
						var _func = method(_mod, _mod_ev_type[$ _ev_number]);
						_func();
						return true;
					break;}
					case MOD_SYNC_TYPE.ASYNC: {
						var _func = method(_mod, _mod_ev_type[$ _ev_number]);
						var _temp = _func();
						return _temp;
					break;}
				}
							
			}
		}
		
		//default returns if the modifier doesnt have the current step event
		switch (_event_struct.sync_type) {
			case MOD_SYNC_TYPE.SYNC: {
				return false;
			break;}
			case MOD_SYNC_TYPE.PASSIVE: {
				return true;
			break;}
			case MOD_SYNC_TYPE.ASYNC: {
				return false;
			break;}
		}
	}
	
	init_mod = function(_mod) {
		_mod.init()
	}
	
	init_modifiers = function(_event) {
		var _names = variable_struct_get_names(modifiers);
		var _size = variable_struct_names_count(modifiers);
		var _returned = false;
		var _event_struct, 
		var _key, _mod, _return;
		var _ready_to_move_on = true;
		
		var _i=0; repeat(_size) {
			_key = _names[_i];
			_mod = modifiers[$ _key];
			
			if (array_contains(_mod.registed_events, _event)) {
				//get the event which is being triggered
				if (variable_struct_exists(_mod.events, _event)) {
					_mod.init()
				}
			}
		
		_i+=1;}
	}
	
	clean_up_modifiers = function(_event) {
		var _names = variable_struct_get_names(modifiers);
		var _size = variable_struct_names_count(modifiers);
		var _returned = false;
		var _event_struct, 
		var _key, _mod, _return;
		var _ready_to_move_on = true;
		
		var _i=0; repeat(_size) {
			_key = _names[_i];
			_mod = modifiers[$ _key];
			
			if (array_contains(_mod.registed_events, _event)) {
				//get the event which is being triggered
				if (variable_struct_exists(_mod.events, _event)) {
					_mod.clean_up();
				}
			}
		
		_i+=1;}
	}
	
	has_modifier = function(_mod_or_mod_id) {
		if (is_string(_mod_or_mod_id)) {
			return variable_struct_exists(modifiers, _mod_or_mod_id);
		}
		else{
			var _key = get_mod_id(_mod_or_mod_id);
			return variable_struct_exists(modifiers, _key);
		}
	}
	
	get_modifier_count = function(_mod) {
		if (has_modifier(_mod)) {
			var _orig_mod = get_modifier(_mod)
			return _orig_mod.modifier_count
		}
		else{
			return 0;
		}
	}
	
	get_modifier = function(_mod_or_mod_id) {
		if (is_string(_mod_or_mod_id)) {
			return variable_struct_get(modifiers, _mod_or_mod_id);
		}
		else{
			var _key = get_mod_id(_mod_or_mod_id);
			return variable_struct_get(modifiers, _key);
		}
	}
	
	set_modifier_count = function(_mod, _count) {
		if (has_modifier(_mod)) {
			var _orig_mod = get_modifier(_mod)
			_orig_mod.modifier_count = _count;
			return _orig_mod.modifier_count;
		}
		else{
			return 0;
		}
	}
	
	generate_mod_from_string = function(_str) {
		var _func = asset_get_index(_str);
		
		var _mod = new _func();
		
		return _mod
	}
	
	queue_async_mod = function(_mod) {
		if (!variable_struct_exists(async_mod_queue, _mod.modifier_id)) {
			async_mod_queue[$ _mod.modifier_id] = _mod;
			
			var _names = variable_struct_get_names(_mod.events);
			var _size = variable_struct_names_count(_mod.events);
			var _event_key, _event_struct;
			
			var _i=0; repeat(_size) {
				_event_key = _names[_i];
				_event_struct = _mod.events[$ _event_key];
				if (_event_struct.sync_type == MOD_SYNC_TYPE.ASYNC) {
					
					var _func = method(_mod, _event_struct.init);
					_func();
				}
			_i+=1;}//end repeat loop
		}
	}
}

#macro ITEM_FLAGS_IS_ARMOR "IS_ARMOR"
#macro ITEM_FLAGS_IS_WEAPON "IS_WEAPON"
#macro ITEM_FLAGS_CAN_SPAWN_PROJECTILE "CAN_SPAWN_PROJECTILE"
#macro ITEM_FLAGS_CAN_SPAWN_SUMMON "CAN_SPAWN_SUMMON"


