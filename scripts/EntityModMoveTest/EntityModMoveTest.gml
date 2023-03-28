// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EntityModMoveTest() : Modifier("EntityModMoveTest", MOD_SYNC_TYPE.ASYNC, "Test Movement", undefined, "Move only in cardinal directions.", 1) constructor {
	#region jsDoc
	/*
	@func		EntityModMoveTest()
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
			timer_count = 120;
			
		},
		EVENT_TYPE_EV_STEP : {
			EVENT_NUMBER_EV_STEP_BEGIN : function() {
			
			timer_count -= 1;
			
			return timer_count;
		},
		},
		EVENT_TYPE_EV_DRAW : {
			EVENT_NUMBER_EV_DRAW_NORMAL : function() {
				var _timer_count = timer_count
				
				with (owner) {
					var _str = string(_timer_count);
					draw_text(x+8, y+8, _str);
				}
				
				return timer_count;
			},
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
