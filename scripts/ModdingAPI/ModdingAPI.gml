function RunHooks(_hook_id) {
	return false;
	
	var _size = ds_list_size(_hook_id);
	
	if (_size) {
		var i = 0;
		repeat (_size) {
			var callback = _hook_id[| i];
			callback();
			i++;
		}
	}
	
	return false;
}


//callback events
#region notes
	#region Rooms
		#region Generation
		#macro MC_PRE_NEW_LEVEL [] // Called before a new level is generated.
		#macro MC_NEW_LEVEL [] // Called whenever a new level is generated.
		#macro MC_POST_NEW_LEVEL [] // Called after a new level is generated.
	
		#macro MC_PRE_ROOM_GENERATION [] // Called before a room is generated.
		#macro MC_ROOM_GENERATION [] // Called whenever a room is generated.
		#macro MC_POST_ROOM_GENERATION [] // Called after a room is generated.
	
		#macro MC_PRE_PICKUP_GENERATE [] // Called before a pickup is generated.
		#macro MC_PICKUP_GENERATE [] // Called whenever a pickup is generated.
		#macro MC_POST_PICKUP_GENERATE [] // Called after a pickup is generated.
	
		#macro MC_PRE_NPC_GENERATE [] // Called before a NPC is generated.
		#macro MC_NPC_GENERATE [] // Called whenever a NPC is generated.
		#macro MC_POST_NPC_GENERATE [] // Called after a NPC is generated.
	
		#macro MC_PRE_BOSS_GENERATE [] // Called before a BOSS is generated.
		#macro MC_BOSS_GENERATE [] // Called whenever a BOSS is generated.
		#macro MC_POST_BOSS_GENERATE [] // Called after a BOSS is generated.
	
		#macro MC_PRE_ITEM_GENERATE [] // Called before a ITEM is generated.
		#macro MC_ITEM_GENERATE [] // Called whenever a ITEM is generated.
		#macro MC_POST_ITEM_GENERATE [] // Called after a ITEM is generated.
	
		#macro MC_PRE_ENTITY_GENERATE [] // Called before a ENTITY is generated.
		#macro MC_ENTITY_GENERATE [] // Called whenever a ENTITY is generated.
		#macro MC_POST_ENTITY_GENERATE [] // Called after a ENTITY is generated.
	
		#macro MC_PRE_ITEM_POOL_UPDATE [] // Called before the item pool is updated.
		#macro MC_ITEM_POOL_UPDATE [] // Called whenever the item pool is updated.
		#macro MC_POST_ITEM_POOL_UPDATE [] // Called after the item pool is updated.

		#macro MC_PRE_CHEST_GENERATE [] // Called before a CHEST is generated.
		#macro MC_CHEST_GENERATE [] // Called whenever a CHEST is generated.
		#macro MC_POST_CHEST_GENERATE [] // Called after a CHEST is generated.
		#endregion
		#region General Changes
		#macro MC_PRE_ROOM_CHANGE [] // Called before the room changes.
		#macro MC_ROOM_CHANGE [] // Called whenever the room changes.
		#macro MC_POST_ROOM_CHANGE [] // Called after the room changes.
	
		#macro MC_PRE_ROOM_RESTART [] // Called before a room is restarted.
		#macro MC_ROOM_RESTART [] // Called whenever a room is restarted.
		#macro MC_POST_ROOM_RESTART [] // Called after a room is restarted.
		#endregion
		#region all rooms
		#macro MC_PRE_ROOM_LOAD [] // Called before a room is loaded.
		#macro MC_ROOM_LOAD [] // Called whenever a room is loaded.
		#macro MC_POST_ROOM_LOAD [] // Called after a room is loaded.
	
		#macro MC_PRE_ROOM_START [] // Called before a room starts.
		#macro MC_ROOM_START [] // Called whenever a room starts.
		#macro MC_POST_ROOM_START [] // Called after a room starts.
	
		#macro MC_PRE_ROOM_ENTER [] // Called before the player enters a room.
		#macro MC_ROOM_ENTER [] // Called whenever the player enters a room.
		#macro MC_POST_ROOM_ENTER [] // Called after the player enters a room.
	
		#macro MC_PRE_ROOM_UPDATE [] // Called before the room's update function is called.
		#macro MC_ROOM_UPDATE [] // Called every frame for the room.
		#macro MC_POST_ROOM_UPDATE [] // Called after the room's update function is called.
	
		#macro MC_PRE_ROOM_RENDER [] // Called before the current room is rendered.
		#macro MC_ROOM_RENDER [] // Called whenever the current room is rendered.
		#macro MC_POST_ROOM_RENDER [] // Called after the current room is rendered.
	
		#macro MC_PRE_ROOM_CLEAR [] // Called before the current room is cleared of enemies and objects.
		#macro MC_ROOM_CLEAR [] // Called whenever the current room is cleared of enemies and objects.
		#macro MC_POST_ROOM_CLEAR [] // Called after the current room is cleared of enemies and objects.
	
		#macro MC_PRE_ROOM_EXIT [] // Called before the player exits a room.
		#macro MC_ROOM_EXIT [] // Called whenever the player exits a room.
		#macro MC_POST_ROOM_EXIT [] // Called after the player exits a room.
	
		#macro MC_PRE_ROOM_UNLOAD [] // Called before a room is un-loaded.
		#macro MC_ROOM_UNLOAD [] // Called whenever a room is un-loaded.
		#macro MC_POST_ROOM_UNLOAD [] // Called after a room is un-loaded.
		#endregion
		#region BOSS_room
		#macro MC_PRE_BOSS_ROOM_LOAD [] // Called before a BOSS_room is loaded.
		#macro MC_BOSS_ROOM_LOAD [] // Called whenever a BOSS_room is loaded.
		#macro MC_POST_BOSS_ROOM_LOAD [] // Called after a BOSS_room is loaded.
	
		#macro MC_PRE_BOSS_ROOM_START [] // Called before a BOSS_room starts.
		#macro MC_BOSS_ROOM_START [] // Called whenever a BOSS_room starts.
		#macro MC_POST_BOSS_ROOM_START [] // Called after a BOSS_room starts.
	
		#macro MC_PRE_BOSS_ROOM_ENTER [] // Called before the player enters a BOSS_room.
		#macro MC_BOSS_ROOM_ENTER [] // Called whenever the player enters a BOSS_room.
		#macro MC_POST_BOSS_ROOM_ENTER [] // Called after the player enters a BOSS_room.
	
		#macro MC_PRE_BOSS_ROOM_UPDATE [] // Called before the BOSS_room's update function is called.
		#macro MC_BOSS_ROOM_UPDATE [] // Called every frame for the BOSS_room.
		#macro MC_POST_BOSS_ROOM_UPDATE [] // Called after the BOSS_room's update function is called.
	
		#macro MC_PRE_BOSS_ROOM_RENDER [] // Called before the current BOSS_room is rendered.
		#macro MC_BOSS_ROOM_RENDER [] // Called whenever the current BOSS_room is rendered.
		#macro MC_POST_BOSS_ROOM_RENDER [] // Called after the current BOSS_room is rendered.
	
		#macro MC_PRE_BOSS_ROOM_CLEAR [] // Called before the current BOSS_room is cleared of enemies and objects.
		#macro MC_BOSS_ROOM_CLEAR [] // Called whenever the current BOSS_room is cleared of enemies and objects.
		#macro MC_POST_BOSS_ROOM_CLEAR [] // Called after the current BOSS_room is cleared of enemies and objects.
	
		#macro MC_PRE_BOSS_ROOM_EXIT [] // Called before the player exits a BOSS_room.
		#macro MC_BOSS_ROOM_EXIT [] // Called whenever the player exits a BOSS_room.
		#macro MC_POST_BOSS_ROOM_EXIT [] // Called after the player exits a BOSS_room.
	
		#macro MC_PRE_BOSS_ROOM_UNLOAD [] // Called before a BOSS_room is un-loaded.
		#macro MC_BOSS_ROOM_UNLOAD [] // Called whenever a BOSS_room is un-loaded.
		#macro MC_POST_BOSS_ROOM_UNLOAD [] // Called after a BOSS_room is un-loaded.
		#endregion
		#region CHALLENGE_room
		#macro MC_PRE_CHALLENGE_ROOM_LOAD [] // Called before a CHALLENGE_room is loaded.
		#macro MC_CHALLENGE_ROOM_LOAD [] // Called whenever a CHALLENGE_room is loaded.
		#macro MC_POST_CHALLENGE_ROOM_LOAD [] // Called after a CHALLENGE_room is loaded.
	
		#macro MC_PRE_CHALLENGE_ROOM_START [] // Called before a CHALLENGE_room starts.
		#macro MC_CHALLENGE_ROOM_START [] // Called whenever a CHALLENGE_room starts.
		#macro MC_POST_CHALLENGE_ROOM_START [] // Called after a CHALLENGE_room starts.
	
		#macro MC_PRE_CHALLENGE_ROOM_ENTER [] // Called before the player enters a CHALLENGE_room.
		#macro MC_CHALLENGE_ROOM_ENTER [] // Called whenever the player enters a CHALLENGE_room.
		#macro MC_POST_CHALLENGE_ROOM_ENTER [] // Called after the player enters a CHALLENGE_room.
	
		#macro MC_PRE_CHALLENGE_ROOM_UPDATE [] // Called before the CHALLENGE_room's update function is called.
		#macro MC_CHALLENGE_ROOM_UPDATE [] // Called every frame for the CHALLENGE_room.
		#macro MC_POST_CHALLENGE_ROOM_UPDATE [] // Called after the CHALLENGE_room's update function is called.
	
		#macro MC_PRE_CHALLENGE_ROOM_RENDER [] // Called before the current CHALLENGE_room is rendered.
		#macro MC_CHALLENGE_ROOM_RENDER [] // Called whenever the current CHALLENGE_room is rendered.
		#macro MC_POST_CHALLENGE_ROOM_RENDER [] // Called after the current CHALLENGE_room is rendered.
	
		#macro MC_PRE_CHALLENGE_ROOM_CLEAR [] // Called before the current CHALLENGE_room is cleared of enemies and objects.
		#macro MC_CHALLENGE_ROOM_CLEAR [] // Called whenever the current CHALLENGE_room is cleared of enemies and objects.
		#macro MC_POST_CHALLENGE_ROOM_CLEAR [] // Called after the current CHALLENGE_room is cleared of enemies and objects.

		#macro MC_PRE_CHALLENGE_ROOM_EXIT [] // Called before the player exits a CHALLENGE_room.
		#macro MC_CHALLENGE_ROOM_EXIT [] // Called whenever the player exits a CHALLENGE_room.
		#macro MC_POST_CHALLENGE_ROOM_EXIT [] // Called after the player exits a CHALLENGE_room.
	
		#macro MC_PRE_CHALLENGE_ROOM_UNLOAD [] // Called before a CHALLENGE_room is un-loaded.
		#macro MC_CHALLENGE_ROOM_UNLOAD [] // Called whenever a CHALLENGE_room is un-loaded.
		#macro MC_POST_CHALLENGE_ROOM_UNLOAD [] // Called after a CHALLENGE_room is un-loaded.
		#endregion
		#region PUZZLE_room
		#macro MC_PRE_PUZZLE_ROOM_LOAD [] // Called before a PUZZLE_room is loaded.
		#macro MC_PUZZLE_ROOM_LOAD [] // Called whenever a PUZZLE_room is loaded.
		#macro MC_POST_PUZZLE_ROOM_LOAD [] // Called after a PUZZLE_room is loaded.
	
		#macro MC_PRE_PUZZLE_ROOM_START [] // Called before a PUZZLE_room starts.
		#macro MC_PUZZLE_ROOM_START [] // Called whenever a PUZZLE_room starts.
		#macro MC_POST_PUZZLE_ROOM_START [] // Called after a PUZZLE_room starts.
	
		#macro MC_PRE_PUZZLE_ROOM_ENTER [] // Called before the player enters a PUZZLE_room.
		#macro MC_PUZZLE_ROOM_ENTER [] // Called whenever the player enters a PUZZLE_room.
		#macro MC_POST_PUZZLE_ROOM_ENTER [] // Called after the player enters a PUZZLE_room.
	
		#macro MC_PRE_PUZZLE_ROOM_UPDATE [] // Called before the PUZZLE_room's update function is called.
		#macro MC_PUZZLE_ROOM_UPDATE [] // Called every frame for the PUZZLE_room.
		#macro MC_POST_PUZZLE_ROOM_UPDATE [] // Called after the PUZZLE_room's update function is called.

		#macro MC_PRE_PUZZLE_ROOM_RENDER [] // Called before the current PUZZLE_room is rendered.
		#macro MC_PUZZLE_ROOM_RENDER [] // Called whenever the current PUZZLE_room is rendered.
		#macro MC_POST_PUZZLE_ROOM_RENDER [] // Called after the current PUZZLE_room is rendered.
	
		#macro MC_PRE_PUZZLE_ROOM_CLEAR [] // Called before the current PUZZLE_room is cleared of enemies and objects.
		#macro MC_PUZZLE_ROOM_CLEAR [] // Called whenever the current PUZZLE_room is cleared of enemies and objects.
		#macro MC_POST_PUZZLE_ROOM_CLEAR [] // Called after the current PUZZLE_room is cleared of enemies and objects.
	
		#macro MC_PRE_PUZZLE_ROOM_EXIT [] // Called before the player exits a PUZZLE_room.
		#macro MC_PUZZLE_ROOM_EXIT [] // Called whenever the player exits a PUZZLE_room.
		#macro MC_POST_PUZZLE_ROOM_EXIT [] // Called after the player exits a PUZZLE_room.
	
		#macro MC_PRE_PUZZLE_ROOM_UNLOAD [] // Called before a PUZZLE_room is un-loaded.
		#macro MC_PUZZLE_ROOM_UNLOAD [] // Called whenever a PUZZLE_room is un-loaded.
		#macro MC_POST_PUZZLE_ROOM_UNLOAD [] // Called after a PUZZLE_room is un-loaded.
		#endregion
	#endregion
	#region Entity
		#region General Entity
			#region init
			#macro MC_PRE_ENTITY_INIT [] // Called before the ENTITY is initialized.
			#macro MC_ENTITY_INIT [] // Called whenever the ENTITY is initialized.
			#macro MC_POST_ENTITY_INIT [] // Called after the ENTITY is initialized.
		
			#macro MC_PRE_ENTITY_INIT_HEALTH [] // Called before the ENTITY's health is initialized.
			#macro MC_ENTITY_INIT_HEALTH [] // Called whenever the ENTITY's health is initialized.
			#macro MC_POST_ENTITY_INIT_HEALTH [] // Called after the ENTITY's health is initialized.
		
			#macro MC_PRE_ENTITY_ITEM_PICKUP [] // Called before the ENTITY picks up an item.
			#macro MC_ENTITY_ITEM_PICKUP [] // Called whenever the ENTITY picks up an item.
			#macro MC_POST_ENTITY_ITEM_PICKUP [] // Called after the ENTITY picks up an item.
			#endregion
			#region idle
			#macro MC_PRE_ENTITY_IDLE_UPDATE [] // Called before the ENTITY's update function is called.
			#macro MC_ENTITY_IDLE_UPDATE [] // Called whenever the ENTITY's update function is called.
			#macro MC_POST_ENTITY_IDLE_UPDATE [] // Called after the ENTITY's update function is called.
			#endregion
			#region Collision
			#macro MC_PRE_ENTITY_ENTITY_COLLISION [] // Called before the ENTITY collides with another entity.
			#macro MC_ENTITY_ENTITY_COLLISION [] // Called whenever the ENTITY collides with another entity.
			#macro MC_POST_ENTITY_ENTITY_COLLISION [] // Called after the ENTITY collides with another entity.
	
			#macro MC_PRE_ENTITY_ENEMY_COLLISION [] // Called before a ENTITY collides with a ENEMY.
			#macro MC_ENTITY_ENEMY_COLLISION [] // Called whenever a ENTITY collides with a ENEMY.
			#macro MC_POST_ENTITY_ENEMY_COLLISION [] // Called after a ENTITY collides with a ENEMY.
	
			#macro MC_PRE_ENTITY_ITEM_COLLISION [] // Called before a ENTITY collides with a ITEM.
			#macro MC_ENTITY_ITEM_COLLISION [] // Called whenever a ENTITY collides with a ITEM.
			#macro MC_POST_ENTITY_ITEM_COLLISION [] // Called after a ENTITY collides with a ITEM.
	
			#macro MC_PRE_ENTITY_FAMILIAR_COLLISION [] // Called before a ENTITY collides with a FAMILIAR.
			#macro MC_ENTITY_FAMILIAR_COLLISION [] // Called whenever a ENTITY collides with a FAMILIAR.
			#macro MC_POST_ENTITY_FAMILIAR_COLLISION [] // Called after a ENTITY collides with a FAMILIAR.
	
			#macro MC_PRE_ENTITY_PROJECTILE_COLLISION [] // Called before a ENTITY collides with a PROJECTILE.
			#macro MC_ENTITY_PROJECTILE_COLLISION [] // Called whenever a ENTITY collides with a PROJECTILE.
			#macro MC_POST_ENTITY_PROJECTILE_COLLISION [] // Called after a ENTITY collides with a PROJECTILE.
			
	
			#macro MC_PRE_ENTITY_NPC_COLLISION [] // Called before a ENTITY collides with a NPC.
			#macro MC_ENTITY_NPC_COLLISION [] // Called whenever a ENTITY collides with a NPC.
			#macro MC_POST_ENTITY_NPC_COLLISION [] // Called after a ENTITY collides with a NPC.
			#endregion
			#region attacking
			#macro MC_PRE_ENTITY_ATTACK [] // Called before the ENTITY uses an item.
			#macro MC_ENTITY_ATTACK [] // Called whenever the ENTITY uses an item.
			#macro MC_POST_ENTITY_ATTACK [] // Called after the ENTITY uses an item.
			
			#macro MC_PRE_ENTITY_SUMMON [] // Called before the ENTITY summons a new entity.
			#macro MC_ENTITY_SUMMON [] // Called whenever the ENTITY summons a new entity.
			#macro MC_POST_ENTITY_SUMMON [] // Called after the ENTITY summons a new entity.
			#endregion
			#region movement
			#macro MC_PRE_ENTITY_MOVE [] // Called before the ENTITY moves.
			#macro MC_ENTITY_MOVE [] // Called whenever the ENTITY moves.
			#macro MC_POST_ENTITY_MOVE [] // Called after the ENTITY moves.
		
			#macro MC_PRE_ENTITY_MOUNTED [] // Called before the ENTITY is mounted.
			#macro MC_ENTITY_MOUNTED [] // Called whenever the ENTITY is mounted.
			#macro MC_POST_ENTITY_MOUNTED [] // Called after the ENTITY is mounted.
	
			#macro MC_PRE_ENTITY_MOUNTING [] // Called before the ENTITY is mounting something.
			#macro MC_ENTITY_MOUNTING [] // Called whenever the ENTITY is mounting something.
			#macro MC_POST_ENTITY_MOUNTING [] // Called after the ENTITY is mounting something.
			#endregion
			#region damage
			#macro MC_PRE_ENTITY_DAMAGE [] // Called before the ENTITY takes damage.
			#macro MC_ENTITY_DAMAGE [] // Called whenever the ENTITY takes damage.
			#macro MC_POST_ENTITY_DAMAGE [] // Called after the ENTITY takes damage.
			#endregion
			#region death
			#macro MC_PRE_ENTITY_DEATH [] // Called before a ENTITY dies.
			#macro MC_ENTITY_DEATH [] // Called whenever a ENTITY dies.
			#macro MC_POST_ENTITY_DEATH [] // Called after a ENTITY dies.
			#endregion
			#region UNUSED
			#macro MC_PRE_ENTITY_JUMP [] // Called before the ENTITY jumps.
			#macro MC_ENTITY_JUMP [] // Called whenever the ENTITY jumps.
			#macro MC_POST_ENTITY_JUMP [] // Called after the ENTITY jumps.
			#endregion
			#region misc
			#macro MC_PRE_ENTITY_ANIMATION [] // Called before the ENTITY ANIMATIONs.
			#macro MC_ENTITY_ANIMATION [] // Called whenever the ENTITY ANIMATIONs.
			#macro MC_POST_ENTITY_ANIMATION [] // Called after the ENTITY ANIMATIONs.
			
			#macro MC_PRE_ENTITY_UPDATE [] // Called before the ENTITY's update function is called.
			#macro MC_ENTITY_UPDATE [] // Called whenever the ENTITY's update function is called.
			#macro MC_POST_ENTITY_UPDATE [] // Called after the ENTITY's update function is called.
			
	
			#macro MC_PRE_ENTITY_STAT_CHANGE [] // Called before the ENTITY's stats are changed.
			#macro MC_ENTITY_STAT_CHANGE [] // Called whenever the ENTITY's stats are changed.
			#macro MC_POST_ENTITY_STAT_CHANGE [] // Called after the ENTITY's stats are changed.
			#endregion
		#endregion
		#region Grid Entity
		#macro MC_PRE_GRID_ENTITY_UPDATE [] // Called before a grid entity's update function is called.
		#macro MC_GRID_ENTITY_UPDATE [] // Called whenever a grid entity's update function is called.
		#macro MC_POST_GRID_ENTITY_UPDATE [] // Called after a grid entity's update function is called.
		
		#macro MC_PRE_SPAWN_GRID_ENTITY [] // Called before a grid entity is spawned.
		#macro MC_SPAWN_GRID_ENTITY [] // Called whenever a grid entity is spawned.
		#macro MC_POST_SPAWN_GRID_ENTITY [] // Called after a grid entity is spawned.
		
		#macro MC_PRE_DESPAWN_GRID_ENTITY [] // Called before a grid entity is despawned.
		#macro MC_DESPAWN_GRID_ENTITY [] // Called whenever a grid entity is despawned.
		#macro MC_POST_DESPAWN_GRID_ENTITY [] // Called after a grid entity is despawned.
		#endregion
	#endregion
	#region Game
	#macro MC_PRE_GAMEPAD_BUTTON_HELD [] // Called before a gamepad button is held.
	#macro MC_GAMEPAD_BUTTON_HELD [] // Called whenever a gamepad button is held.
	#macro MC_POST_GAMEPAD_BUTTON_HELD [] // Called after a gamepad button is held.
	
	#macro MC_PRE_GAMEPAD_BUTTON_PRESS [] // Called before a gamepad button is pressed.
	#macro MC_GAMEPAD_BUTTON_PRESS [] // Called whenever a gamepad button is pressed.
	#macro MC_POST_GAMEPAD_BUTTON_PRESS [] // Called after a gamepad button is pressed.
	
	#macro MC_PRE_GAMEPAD_BUTTON_RELEASE [] // Called before a gamepad button is released.
	#macro MC_GAMEPAD_BUTTON_RELEASE [] // Called whenever a gamepad button is released.
	#macro MC_POST_GAMEPAD_BUTTON_RELEASE [] // Called after a gamepad button is released.
	
	#macro MC_PRE_GAME_END [] // Called before the game ends.
	#macro MC_GAME_END [] // Called when the game ends.
	#macro MC_POST_GAME_END [] // Called after the game ends.
	
	#macro MC_PRE_GAME_EXIT [] // Called before the game exits.
	#macro MC_GAME_EXIT [] // Called whenever the game exits.
	#macro MC_POST_GAME_EXIT [] // Called after the game exits.
	
	#macro MC_PRE_GAME_LOAD [] // Called before the game is loaded.
	#macro MC_GAME_LOAD [] // Called whenever the game is loaded.
	#macro MC_POST_GAME_LOAD [] // Called after the game is loaded.
	
	#macro MC_PRE_GAME_RENDER [] // Called before the game's graphics are rendered.
	#macro MC_GAME_RENDER [] // Called whenever the game's graphics are rendered.
	#macro MC_POST_GAME_RENDER [] // Called after the game's graphics are rendered.
	
	#macro MC_PRE_GAME_SAVE [] // Called before the game is saved.
	#macro MC_GAME_SAVE [] // Called whenever the game is saved.
	#macro MC_POST_GAME_SAVE [] // Called after the game is saved.
	
	#macro MC_PRE_GAME_STARTED [] // Called before the game starts.
	#macro MC_GAME_STARTED [] // Called when the game starts.
	#macro MC_POST_GAME_STARTED [] // Called after the game starts.
	
	#macro MC_PRE_GAME_UPDATE [] // Called before the game's update function is called.
	#macro MC_GAME_UPDATE [] // Called whenever the game's update function is called.
	#macro MC_POST_GAME_UPDATE [] // Called after the game's update function is called.
	
	#macro MC_PRE_RENDER [] // Called after the game's graphics have been rendered.
	#macro MC_RENDER [] // Called while the game's graphics have been rendered.
	#macro MC_POST_RENDER [] // Called after the game's graphics have been rendered.
	
	#macro MC_PRE_RUN_ENDED [] // Called before a run ends.
	#macro MC_RUN_ENDED [] // Called when a run ends.
	#macro MC_POST_RUN_ENDED [] // Called after a run ends.
	
	#macro MC_PRE_RUN_STARTED [] // Called before the current run starts.
	#macro MC_RUN_STARTED [] // Called whenever the current run starts.
	#macro MC_POST_RUN_STARTED [] // Called after the current run starts.
	
	#macro MC_PRE_UI_UPDATE [] // Called before the UI is updated.
	#macro MC_UI_UPDATE [] // Called whenever the UI is updated.
	#macro MC_POST_UI_UPDATE [] // Called after the UI is updated.
	
	#endregion
	#region Audio
	#macro MC_PRE_SOUND_PLAY [] // Called before a sound is played.
	#macro MC_SOUND_PLAY [] // Called whenever a sound is played.
	#macro MC_POST_SOUND_PLAY [] // Called after a sound is played.
	
	#macro MC_PRE_SOUND_STOP [] // Called before a sound is stopped.
	#macro MC_SOUND_STOP [] // Called whenever a sound is stopped.
	#macro MC_POST_SOUND_STOP [] // Called after a sound is stopped.
	#endregion
	
	#region Damage Types
	#macro DAMAGE_NOKILL [] // damage can not kill the receiver
	#macro DAMAGE_FIRE [] // source is some sort of fire (ie. fireplace)
	#macro DAMAGE_EXPLOSION [] // damage comes from an explosion
	#macro DAMAGE_LASER [] // damage comes from laser
	#macro DAMAGE_ACID [] // damage comes from acid, e.g. blood acid
	#macro DAMAGE_RED_HEARTS [] // damage affects only red hearts if > 1 (ex: razor)
	#macro DAMAGE_COUNTDOWN [] // damage from unicorn horn, the nail, game kid that has cooldown
	#macro DAMAGE_SPIKES [] // damage from spikes
	#macro DAMAGE_CLONES [] // damage is done by clones when they took damage, avoid infinite loops
	#macro DAMAGE_POOP [] // damage from red poop
	#macro DAMAGE_DEVIL [] // damage comes from devil room deal
	#macro DAMAGE_ISAAC_HEART [] // Indicates the damage has been redirected from Isaac's Heart familiar
	#macro DAMAGE_TNT [] // damage comes from a TNT barrel
	#macro DAMAGE_INVINCIBLE [] // damages even if invincible (currently only for player). Used on IV Bag.
	#macro DAMAGE_SPAWN_FLY [] // creates a fly when damage is applied
	#macro DAMAGE_POISON_BURN [] // damage comes from POISON/BURN flags
	#macro DAMAGE_CURSED_DOOR [] // damage comes from a cursed door
	#macro DAMAGE_TIMER [] // damage comes from the passage of time (used for player damage by time limited special seeds)
	#macro DAMAGE_IV_BAG [] // damage from using the IV Bag
	#macro DAMAGE_PITFALL [] // damage comes from the passage of time (used for player damage by time limited special seeds)
	#macro DAMAGE_CHEST [] // damage comes from spiked chest
	#macro DAMAGE_FAKE [] // fake damage that should trigger player's damage effects.
	
	#macro DAMAGE_SUFFOCATION [] // damage from suffocation (e.g. being trapped underwater or in a wall)
	#macro DAMAGE_FREEZE [] // damage comes from being frozen
	#macro DAMAGE_ELECTRICITY [] // damage comes from electric shock
	#macro DAMAGE_BULLET [] // damage comes from a bullet or projectile
	#macro DAMAGE_RADIATION [] // damage comes from exposure to radiation
	#macro DAMAGE_DROWN [] // damage comes from drowning
	#macro DAMAGE_BLEED [] // damage causes the receiver to bleed
	#macro DAMAGE_FALL [] // damage comes from falling from a height
	#macro DAMAGE_HEALING [] // damage that actually heals the receiver (used for enemies with opposite polarity)
	#macro DAMAGE_MELT [] // damage comes from melting (e.g. from lava)
	#macro DAMAGE_ENEMY_EXPLOSION [] // damage caused by an enemy exploding (e.g. kamikaze enemies)
	#macro DAMAGE_SUICIDE [] // damage caused by the receiver themselves (e.g. self-destruct items)
	#macro DAMAGE_LIGHTNING [] // damage caused by a lightning strike
	#macro DAMAGE_CRUSH [] // damage caused by being crushed or squished
	#macro DAMAGE_DEATH [] // instant death caused by a specific event or condition (e.g. sacrifice alter)
	#macro DAMAGE_HOLY [] // damage comes from holy sources (e.g. holy water, Bible)
	#macro DAMAGE_CURSE [] // damage caused by a curse (e.g. curse of darkness, curse of the lost)
	#macro DAMAGE_MIST [] // damage caused by a mist or fog
	#macro DAMAGE_TOXIC [] // damage caused by toxic or poisonous substances
	#macro DAMAGE_MAGIC [] // damage caused by magical sources (e.g. spell books, magic missiles)
	#macro DAMAGE_SHOCKWAVE [] // damage caused by a shockwave (e.g. from an explosion or earthquake)
	#macro DAMAGE_BURNING [] // damage caused by burning or being on fire
	#macro DAMAGE_SHADOW [] // damage caused by shadowy or dark sources (e.g. dark matter, shadow beams)
	#macro DAMAGE_TIME_TRAVEL [] // damage caused by time travel (e.g. time paradoxes or chrono anomalies)
	#macro DAMAGE_MIND_CONTROL [] // damage caused by mental manipulation or mind control
	#macro DAMAGE_SHRAPNEL [] // damage caused by shrapnel or fragments (e.g. from a bomb or grenade)
	#macro DAMAGE_NECROTIC [] // damage caused by necrotic sources (e.g. undead or decayed flesh)
	#macro DAMAGE_DISINTEGRATE [] // damage caused by disintegration or vaporization (e.g. from a laser or disintegrator gun)
	#macro DAMAGE_ANIMAL [] // damage caused by animal sources (e.g. animal bites or claws)
	#macro DAMAGE_PSYCHIC [] // damage caused by psychic or telekinetic sources (e.g. mind blasts or telekinetic projectiles)
	#macro DAMAGE_CORRUPTION [] // damage caused by corruption or decay (e.g. from a corrupting aura or necrotic energy)
	#endregion
#endregion
