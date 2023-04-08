pid = 0 // player id
weapon_mods = undefined;
input_vector = {x:0,y:0};
input_attack_id = undefined;
input_interacting = false;

modifiers = new ModifierHandler();

modifiers.add_modifier(new EntityModMoveAnalogWalk());
modifiers.add_modifier(new EntityModMoveMarble());
//modifiers.add_modifier(new EntityModMoveMarble());
//modifiers.add_modifier(new EntityModMoveMarble());
//modifiers.add_modifier(new EntityModMoveMarble());
//modifiers.add_modifier(new EntityModMoveMarble());




entity_dir = 0;
entity_speed = 0;

EVENT_ACTIVATE
EVENT_IMPORT
EVENT_CONSTRUCTOR
EVENT_FSM
EVENT_METHOD

