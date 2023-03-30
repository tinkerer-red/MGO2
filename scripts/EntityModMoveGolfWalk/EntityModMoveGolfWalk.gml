// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EntityModMoveGolfWalk() : Modifier("EntityModMoveGolfWalk", MOD_SYNC_TYPE.SYNC, "Putter Legs", undefined, "Description", 1) constructor {
	#region jsDoc
	/*
	@func		EntityModMoveGolfWalk()
	@desc		Movement is more like golf
	@returns {bool}	end-able : Return true if finished, or ready to move end at any time
	
	add @ before if you want these flags to be true
	ignore
	deprecated
	*/
	#endregion
	
	#region Config
	//this region is used for things which will only ever be calculated once, usually good to make everything here a static variable
	putt_power_time = GAME_FPS;
	move_putt_max_distance = 256*modifier_count;
	move_putt_friction = 0.1
	
	enum MOVE_GOLF_STATE {
		PUTTING,
		ROLLING
	}
	#endregion
	
	#region Events
	register_event(ENTITY_STATE_MOVE_PRE, mod_sync_type, {
		init: function() {
			//this region is run every time a modifier is added to the mod handler, and every time the registered event is first called
			
			//Define Variables
			move_putt_state = MOVE_GOLF_STATE.PUTTING;
			
			move_putt_momentum = 0;
			var _simulated_distance = 0;
			while (_simulated_distance < move_putt_max_distance) {
				move_putt_momentum += move_putt_friction;
				_simulated_distance += move_putt_momentum
			}
			
			
			move_vector = {x:owner.input_vector.x,y:owner.input_vector.y};
			log(["move_vector", move_vector])
			
			timer_incrementer = 2/putt_power_time;
			timer_direction = 1;
			timer = 0; //initialize timer
			
			log("init")
		},
		EVENT_TYPE_EV_STEP : {
			EVENT_NUMBER_EV_STEP_NORMAL : function() {
				//step
				if (move_putt_state = MOVE_GOLF_STATE.PUTTING) {
					//move_vector.x = move_vector.x + owner.input_vector.x * 0.2;
					//move_vector.y = move_vector.y + owner.input_vector.y * 0.2;
					
					if (abs(owner.input_vector.x) || abs(owner.input_vector.y)){
						var _input_dir = point_direction(0,0,owner.input_vector.x,owner.input_vector.y);
						var _aim_dir = point_direction(0,0,move_vector.x,move_vector.y);
						_aim_dir = approach_angle(_aim_dir, _input_dir, 2);
						move_vector.x = lengthdir_x(1, _aim_dir);
						move_vector.y = lengthdir_y(1, _aim_dir);
					}
					
					//increment timer
					timer += timer_incrementer*timer_direction; //cycles from 0-1
				
					if (timer >= 1) {
						timer = 1 - abs(timer - 1);
						timer_direction = -1;
					}
					else if (timer <= 0) {
						timer = abs(timer);
						timer_direction = 1;
					}
				
					//check for button press
					if (INPUT.pressed(ACTION.INTERACT)) {
							move_putt_state = MOVE_GOLF_STATE.ROLLING;
							var _dir = point_direction(0,0,move_vector.x,move_vector.y)
							
							var _x = lengthdir_x(move_putt_momentum, _dir);
							var _y = lengthdir_y(move_putt_momentum, _dir);
							
							momentum_vector = {x: _x,y: _y};
							
					}
				}
				
				if (move_putt_state = MOVE_GOLF_STATE.ROLLING) {
					var _momentum_vector = momentum_vector
					owner.x += _momentum_vector.x;
					owner.y += _momentum_vector.y;
					
					//apply friction
					var _dir = point_direction(0,0,momentum_vector.x,momentum_vector.y)
					var _x = lengthdir_x(move_putt_friction, _dir);
					var _y = lengthdir_y(move_putt_friction, _dir);
					
					momentum_vector.x -= _x;
					momentum_vector.y -= _y;
					
					if (abs(momentum_vector.x) < 0.2) 
					&& (abs(momentum_vector.y) < 0.2) {
						log("returning")
						return true;
					}
				}
				
			},
		},
		EVENT_TYPE_EV_DRAW : {
			EVENT_NUMBER_EV_DRAW_NORMAL : function() {
				var _timer = timer;
				
				var _dir = point_direction(0,0,move_vector.x,move_vector.y);
				var _x = lengthdir_x(100, _dir);
				var _y = lengthdir_y(100, _dir);
				
				with (owner) {
					draw_line(x,y,x+_x, y+_y)
					
					//draw an arrow which represents the 0-1 value from the step event above
					var arrow_length = 64;
					var arrow_thickness = 32;
					var arrow_x = x - arrow_length / 2;
					var arrow_y = y + 32;
					
					//draw the arrow outline
					draw_triangle_color(arrow_x, arrow_y,
															arrow_x + arrow_length * _timer, arrow_y - arrow_thickness / 2,
															arrow_x + arrow_length * _timer, arrow_y + arrow_thickness / 2,
															c_white, c_white, c_white, false);
						
					//fill the arrow based on the timer value
					var arrow_fill_color = make_color_hsv(_timer * 120, 1, 1); //color changes from green to red as the arrow fills up
					draw_triangle_color(arrow_x, arrow_y,
															arrow_x + arrow_length * _timer, arrow_y - arrow_thickness / 2,
															arrow_x + arrow_length * _timer, arrow_y + arrow_thickness / 2,
															arrow_fill_color, arrow_fill_color, arrow_fill_color, true);
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
