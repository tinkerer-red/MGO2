// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EntityModMoveAnalogWalk() : Modifier("EntityModMoveAnalogWalk", MOD_SYNC_TYPE.PASSIVE, "Analog Walk", undefined, "Description", 1) constructor {
	#region jsDoc
	/*
	@func		EntityModMoveAnalogWalk()
	@desc		Walk in any analog direction
	@returns {bool}	end-able : Return true if the modifier needs to postpone moving on to the next phase
	
	add @ before if you want these flags to be true
	ignore
	deprecated
	*/
	#endregion
	
	#region Config
	
	#endregion
	
	#region Events
	register_event(ENTITY_STATE_MOVE_NORM, mod_sync_type, {
		init: function() {
			//Define Variables
			move_max_speed = 1 + modifier_count; //max of 6
			move_vector = {x:0,y:0};
		},
		EVENT_TYPE_EV_STEP : {
			EVENT_NUMBER_EV_STEP_BEGIN : function() {
			
			//step
			move_vector.x = move_vector.x + owner.input_vector.x;
			move_vector.y = move_vector.y + owner.input_vector.y;
			
			//if not pressing an input then just dont move
			if (owner.input_vector.x == 0) && (owner.input_vector.y == 0) {
				move_vector.x = 0;
				move_vector.y = 0;
			}
			
			var _speed = point_distance(0,0,move_vector.x, move_vector.y);
			var _dir = point_direction(0,0,move_vector.x, move_vector.y);
			
			if (_speed > move_max_speed) {
				_speed = clamp(_speed, -move_max_speed, move_max_speed);
			}
			
			move_vector.x = lengthdir_x(_speed, _dir);
			move_vector.y = lengthdir_y(_speed, _dir);
			
			var _update_pos = move_vector
			
			owner.x += _update_pos.x;
			owner.y += _update_pos.y;
			
			
			return true;
		},
		},
		EVENT_TYPE_EV_DRAW : {
			EVENT_NUMBER_EV_DRAW_NORMAL : function() {
				with (owner) {
					draw_circle(x,y,8,false);
					var _str = string(csm.__get_active_states());
					draw_text(x+8, y+8, _str);
				}
			}
		},
		clean_up: function() {
			//leave
		}
	});
	#endregion
	
	static modifier_conditions = function(_item) {
		#region jsDoc
		/*
		@func		modifier_conditions()
		@desc		Checks to see if the modifier can be applied to the item.
		@param {struct}	item : Thhe item to check if we can apply this modifier to.
		@returns {bool}	can_modify : Returns true if the modifier can be applied to the item, and false if it can not.
		
		add @ before if you want these flags to be true
		ignore
		deprecated
		*/#endregion
		
		// if item is a weapon, return true;
		return _item[$ ITEM_FLAGS_IS_WEAPON]
	}
}
