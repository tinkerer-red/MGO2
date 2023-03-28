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
	ACTIVE, // the state transitions will be delayed if this mod returns true
	PASSIVE, // the modifier will run until the state changes, it will always return that its 
	ASYNC // the modifier will be queued up to run despite the state changing
}

function Modifier(_modifier_id, _mod_sync_type, _name, _sprite, _description, _quality) constructor {
	modifier_id = _modifier_id;
	name = _name;
	description = _description;
	quality = _quality;
	mod_sync_type = _mod_sync_type;
	
	registed_events = [];
	events = {};
	
	static item_owner = noone; //the item this modifier is attached to
	static owner = noone; // the entity which owns this indevidual modifier
	static modifier_count = 0;
	
	//eventListeners = {};
	
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
		events[$ _event] = _event_struct;
	}
	
	static remove_mod_from_queue = function() {
		switch (mod_sync_type) {
			case MOD_SYNC_TYPE.ACTIVE: {
				
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
	
	add_modifier = function(_mod) {
		if (has_modifier(_mod)) {
			var _current_count = get_modifier_count(_mod);
			set_modifier_count(_mod, _current_count+1);
		}
		else{
			__add_modifier(_mod);
		}
		
		init_modifier(_mod);
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
		var _key, _mod, _func, _mod_ev_type, _event_struct;
		var _postpone_state_change = false;
		
		var _i=0; repeat(_size) {
			_key = _names[_i];
			_mod = modifiers[$ _key];
			
			if (array_contains(_mod.registed_events, _event)) {
				//log("array_contains");
				//log(["_event", _event])
				
				if (is_undefined(_step)) {
					//if step is undefined then run the relevent step event
					var _event_strings = event_to_string_struct();
					var _ev_type = _event_strings.ev_type;
					var _ev_number = _event_strings.ev_number;
				}
				else{
					//otherwise run the specifically defined event such as enter/leave
					var _ev_type = _step.ev_type;
					var _ev_number = _step.ev_number;
				}
				
				//get the event which is being triggered
				if (variable_struct_exists(_mod.events, _event)) {
					_event_struct = _mod.events[$ _event];
					
					//get the parent step
					if (variable_struct_exists(_event_struct, _ev_type)) {
						_mod_ev_type = _event_struct[$ _ev_type];
						
						//get the sub step
						if (variable_struct_exists(_mod_ev_type, _ev_number)) {
							
							log(["_mod.mod_type", _mod.mod_type]);
							log(["MOD_SYNC_TYPE.ACTIVE", MOD_SYNC_TYPE.ACTIVE]);
							log(["MOD_SYNC_TYPE.PASSIVE", MOD_SYNC_TYPE.PASSIVE]);
							log(["MOD_SYNC_TYPE.ASYNC", MOD_SYNC_TYPE.ASYNC]);
							
							switch (_mod.mod_type) {
								case MOD_SYNC_TYPE.ACTIVE: {
									_func = method(_mod, _mod_ev_type[$ _ev_number]);
									_postpone_state_change = _func();
								break;}
								case MOD_SYNC_TYPE.PASSIVE: {
									_func = method(_mod, _mod_ev_type[$ _ev_number]);
									_func();
								break;}
								case MOD_SYNC_TYPE.ASYNC: {
									//add the modifier to the async
								break;}
							}
						}
					}
				}
			}
			
			_returned += _postpone_state_change;
			
		_i+=1;}//end repeat loop
		
		return _returned;
	}
	
	init_modifier = function(_mod) {
		//init again incase the modifier relies on knowing how many mods it has
		var _size = array_length(_mod.registed_events);
		var _event, _event_steps, _func;
		var _i=0; repeat(_size) {
			_event = _mod.registed_events[_i];
			_event_steps = _mod.events[$ _event];
			
			_func = method(_mod, _event_steps.init);
			_func();
		_i+=1;}//end repeat loop
		
	}
	
	clean_up_modifier = function(_mod) {
		//init again incase the modifier relies on knowing how many mods it has
		var _size = array_length(_mod.registed_events);
		var _event, _event_steps, _func;
		var _i=0; repeat(_size) {
			_event = _mod.registed_events[_i];
			_event_steps = _mod.events[$ _event];
			
			_func = method(_mod, _event_steps.clean_up);
			_func();
		_i+=1;}//end repeat loop
		
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
			return modifiers[$ _key].modifier_count
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
			return modifiers[$ _key].modifier_count
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
}

#macro ITEM_FLAGS_IS_ARMOR "IS_ARMOR"
#macro ITEM_FLAGS_IS_WEAPON "IS_WEAPON"
#macro ITEM_FLAGS_CAN_SPAWN_PROJECTILE "CAN_SPAWN_PROJECTILE"
#macro ITEM_FLAGS_CAN_SPAWN_SUMMON "CAN_SPAWN_SUMMON"


