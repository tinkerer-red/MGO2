pid = 0 // player id
weapon_mods = undefined;
input_vector = {x:0,y:0};
input_attack_id = undefined;
input_interacting = false;

modifiers = new ModifierHandler();
var _mod = new EntityModMoveTest()
_mod.owner = id;
modifiers.add_modifier(_mod);
var _mod = new EntityModMoveTron()
_mod.owner = id;
modifiers.add_modifier(_mod);
var _mod = new EntityModMoveAnalogWalk()
_mod.owner = id;
modifiers.add_modifier(_mod);

entity_dir = 0;
entity_speed = 0;

EVENT_ACTIVATE
EVENT_IMPORT
EVENT_CONSTRUCTOR
EVENT_FSM
EVENT_METHOD

