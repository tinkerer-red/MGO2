#region Eventstates
#region Weapon Event States

#macro ITEM_STATE_WEAPON_PRE_BUTTON_PRESSED "WEAPON_PRE_BUTTON_PRESSED"
#macro ITEM_STATE_WEAPON_BUTTON_PRESSED "WEAPON_BUTTON_PRESSED"
#macro ITEM_STATE_WEAPON_POST_BUTTON_PRESSED "WEAPON_POST_BUTTON_PRESSED"

#macro ITEM_STATE_WEAPON_PRE_SPAWN "WEAPON_PRE_SPAWN"
#macro ITEM_STATE_WEAPON_SPAWN "WEAPON_SPAWN"
#macro ITEM_STATE_WEAPON_POST_SPAWN "WEAPON_POST_SPAWN"

#macro ITEM_STATE_WEAPON_PRE_ATTACK "WEAPON_PRE_ATTACK"
#macro ITEM_STATE_WEAPON_ATTACK "WEAPON_ATTACK"
#macro ITEM_STATE_WEAPON_POST_ATTACK "WEAPON_POST_ATTACK"

#macro ITEM_STATE_WEAPON_PRE_SPAWN_ENTITY "WEAPON_PRE_SPAWN_ENTITY"
#macro ITEM_STATE_WEAPON_SPAWN_ENTITY "WEAPON_SPAWN_ENTITY"
#macro ITEM_STATE_WEAPON_POST_SPAWN_ENTITY "WEAPON_POST_SPAWN_ENTITY"

#macro ITEM_STATE_WEAPON_PRE_COLLIDE "WEAPON_PRE_COLLIDE"
#macro ITEM_STATE_WEAPON_COLLIDE "WEAPON_COLLIDE"
#macro ITEM_STATE_WEAPON_POST_COLLIDE "WEAPON_POST_COLLIDE"

#macro ITEM_STATE_WEAPON_PRE_DESPAWN "WEAPON_PRE_DESPAWN"
#macro ITEM_STATE_WEAPON_DESPAWN "WEAPON_DESPAWN"
#macro ITEM_STATE_WEAPON_POST_DESPAWN "WEAPON_POST_DESPAWN"


#endregion
#region Entity Event States

#endregion
#endregion

function Modifier(_modifier_id, _name, _sprite, _description, _quality) constructor {
	modifier_id = _modifier_id;
	name = _name;
	description = _description;
	quality = _quality;
	
	item_owner = noone; //the item this modifier is attached to
	owner = noone; // the entity which owns this indevidual modifier
	
	#region example state
	example_state = {
		enter: empty_function,
		
		begin_step: empty_function,
		step: empty_function,
		end_step: empty_function,
		
		draw_begin: empty_function,
		draw: empty_function,
		draw_end: empty_function,
		
		leave: empty_function
	}
	#endregion
	
	#region Private
	__defined_states = {} //this struct contains a list of all of the states which need effecting
	#endregion
	
	#region Public
	
	#endregion
	
	
	
	static add_state = function(_name, _struct = {}) {
		if self.has_state(_name) {
			show_debug_message("Modifier state : "+_name+" already exists, changing the state")
		}
		
		variable_struct_set(__defined_states, _name, _struct)
	}
	
	static has_state = function(_name) {
		if is_undefined(variable_struct_get(__defined_states, _name)){
			return false;
		}
		return true;
	}
	
	static change_state = function(_name, _struct) {
		variable_struct_set(__defined_states, _name, _struct);
	}
	
	static get_states = function() {
		return variable_struct_get_names(__defined_states);
	}
		
	static modifier_conditions = function() {
		//if all of the conditions apply, can this modifier be applied to the item?
		
		//return true or false
		return true;
	}
	
	static init_weapon_flags = function() {
		//once a modifier is applied to an item it will over ride it's existing flags
		
	}
	
	
	/*
	aply the modifiers to the weapon
	weapon runs a section of the modifiers
	if no state changes occur, continue to next state
	*/
	
	//example
	//	var example_func = function() {
	//		show_debug_message("Player is currently attacking")
	//	}
	//	defineCallback(MC_ENTITY_ATTACK, example_func)
}

#macro ITEM_FLAGS_IS_ARMOR "IS_ARMOR"
#macro ITEM_FLAGS_IS_WEAPON "IS_WEAPON"
#macro ITEM_FLAGS_CAN_SPAWN_PROJECTILE "CAN_SPAWN_PROJECTILE"
#macro ITEM_FLAGS_CAN_SPAWN_SUMMON "CAN_SPAWN_SUMMON"