// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EntityModMoveWalkRacer() : Modifier("EntityModMoveWalkRacer", MOD_SYNC_TYPE.ASYNC, "Tank Treads", undefined, "Description", 1) constructor {
	#region jsDoc
	/*
	@func		EntityModMoveWalkRacer()
	@desc		Move with tank controls with acceleration and breaking
	@returns {bool}	end-able : Return true if the modifier is ready to end.
	
	add @ before if you want these flags to be true
	ignore
	deprecated
	*/
	#endregion
	
	#region Config
	move_max_speed = 1 + modifier_count; //max of 6
	move_speed = 0;
	move_dir = 90;
	move_acceleration = 0.1 + (0.075*modifier_count);
	move_friction = 0.0075;
	#endregion
	
	#region Events
	register_event(ENTITY_STATE_MOVE_NORM, mod_sync_type, {
		init: function() {
			//Define Variables
			
		},
		EVENT_TYPE_EV_STEP : {
			EVENT_NUMBER_EV_STEP_BEGIN : function() {
			
			//step
			if (abs(move_speed)) {
				move_dir += 2 * -sign(owner.input_vector.x);
			}
			
			//apply acceleration
			if (-sign(owner.input_vector.y)) {
				move_speed += (sign(owner.input_vector.y) * move_acceleration);
				move_speed = clamp(move_speed, -move_max_speed, move_max_speed)
			}
			else {
				
				move_speed += (sign(owner.input_vector.y) * move_acceleration / 2);
				move_speed = clamp(move_speed, -move_max_speed/2, move_max_speed/2)
				
				//apply friction
				move_speed = (abs(move_speed) < move_friction) ? 0 : (abs(move_speed) - move_friction) * sign(move_speed)
				
				if (move_speed == 0) return true;
			}
			
			
			
			owner.x += lengthdir_x(move_speed, move_dir);
			owner.y += lengthdir_y(move_speed, move_dir);
			
			return false;
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
