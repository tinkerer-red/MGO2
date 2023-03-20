weapon_mods = {}
variable_struct_set(weapon_mods, ITEM_STATE_WEAPON_SPAWN, [])
variable_struct_set(weapon_mods, ITEM_STATE_WEAPON_BUTTON_PRESSED, [])
variable_struct_set(weapon_mods, ITEM_STATE_WEAPON_ATTACK, [])
variable_struct_set(weapon_mods, ITEM_STATE_WEAPON_SPAWN_ENTITY, [])
variable_struct_set(weapon_mods, ITEM_STATE_WEAPON_COLLIDE, [])
variable_struct_set(weapon_mods, ITEM_STATE_WEAPON_DESPAWN, [])

owner = noone;

EVENT_ACTIVATE();
EVENT_IMPORT();
EVENT_FSM();
EVENT_CONSTRUCTOR();
EVENT_METHOD();