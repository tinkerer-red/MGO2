// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EntityModMoveMarble() : Modifier("EntityModMoveMarble", MOD_SYNC_TYPE.ASYNC, "Marble Walk", undefined, "Description", 1) constructor {
	#region jsDoc
	/*
	@func		EntityModMoveMarble()
	@desc		Walk in any analog direction
	@returns {bool}	end-able : Return true if the modifier needs to postpone moving on to the next phase
	
	add @ before if you want these flags to be true
	ignore
	deprecated
	*/
	#endregion
	
	#region Config
	xspeed = 0;
	yspeed = 0;
	
	last_x_pos = owner.x;
	last_y_pos = owner.y;
	#endregion
	
	#region Events
	register_event(ENTITY_STATE_MOVE_NORM, mod_sync_type, {
		init: function() {
			//Define Variables
			player_acceleration = 0.2;
			soft_stop = 0.972 + (0.005*modifier_count);
			max_speed = 6 + modifier_count*2;
			move_vector = {x:0,y:0};
		},
		EVENT_TYPE_EV_STEP : {
			EVENT_NUMBER_EV_STEP_BEGIN : function() {
				//cache last known pos
				last_x_pos = owner.x;
				last_y_pos = owner.y;
				
				//calculate speed from last update
				xspeed += owner.x - last_x_pos;
				yspeed += owner.y - last_y_pos;
				
				//apply inputs
				move_vector.x = move_vector.x + owner.input_vector.x;
				move_vector.y = move_vector.y + owner.input_vector.y;
				
				//apply acceleration
				xspeed += owner.input_vector.x * player_acceleration;
				yspeed += owner.input_vector.y * player_acceleration;
				
				//apply friction
				static _friction = 0.0175;
				xspeed = (abs(xspeed) <= _friction) ? 0 : xspeed - sign(xspeed)*_friction;
				yspeed = (abs(yspeed) <= _friction) ? 0 : yspeed - sign(yspeed)*_friction;
				
				//apply a soft stop
				static _soft_stop = 0.985;
				xspeed *= soft_stop;
				yspeed *= soft_stop;
				
				////apply a hard stop
				xspeed = clamp(xspeed,-max_speed,max_speed);
				yspeed = clamp(yspeed,-max_speed,max_speed);
				
				//apply to owner
				owner.x += xspeed;
				owner.y += yspeed;
				
				if (xspeed == 0 && yspeed == 0) return true;
				
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
