function ItemModWeapContinuous() : ItemModifier() constructor {
	#region jsDoc
	/*
	@func		ItemModWeapContinuous()
	@desc		Whean colliding with an entity, deal damage to the enemy every tick
	@returns {bool}	endable : If the modifier is okay with moving on to the next event
	
	add @ before if you want these flags to be true
	ignore
	deprecated
	*/#endregion
	
	#region Config
	#endregion
	
	#region Events
	static eventListeners = {
		enter: function() {
			//Define Variables
			//massiveley drop the DPS
		  w_damage /= (room_speed*0.8)
		},
		step: function() {
			//step
			has_aoe = has_weapon_mod("ItemModWeapAOE")
		
			if (!has_aoe){
				if (collide_enemy){
			    if instance_exists(collide_enemy){
			      if (object_index = obj_weapon)
			      || (object_index = obj_weap_proj){
			        deal_tick_damage(collide_enemy, w_damage, mod_continuous_timer, owner_id)
			      }else{//if it's a player, summon, tile, enemy, boss, etc
			        deal_tick_damage(collide_enemy, w_damage, mod_continuous_timer, self)
			      }
			    }
			  }
			}
		
			return true;
		},
		leave: function(){
			//leave
			var _return = RunHooks(MC_POST_ENTITY_IDLE_UPDATE)
		}
	}
	#endregion
	
}