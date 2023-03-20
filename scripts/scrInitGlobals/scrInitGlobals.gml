/// @func init_globals()
/// @desc Initialize global resources
function init_globals() {
	// Global logger, used for ingame console logging and ide console logging
	#macro LOGGER global.logger
	//LOGGER = DUNDER.get_shared_logger();
	
	// The entity manager
	#macro ENTITIES global.entity_manager
	//ENTITIES = DUNDER.init(EntityManager,"Entity Manager");
	
	// Manager objects to be spawned later
	#macro CAMERA global.camera_manager
	CAMERA = noone;
	#macro INPUT global.input_manager
	INPUT = instance_create_depth(0,0,15000,oInputManager);
	#macro DISPLAY global.display_manager
	DISPLAY = noone;
	#macro DEBUG global.debug_manager
	DEBUG = noone;
	#macro IMAGE_LOADER global.image_loader
	IMAGE_LOADER = noone;
	#macro CHAT global.chat_manager
	CHAT = noone;
	#macro AUDIO global.audio_manager
	AUDIO = noone;
	
	// Motion Planning struct data.
	#macro MP global.motion_planning
	//MP = new MotionPlanning(MP_SIZE, MP_SIZE);
	
	//Layer Sorter
	#macro LAYER_SORTER global.layer_sorter
	LAYER_SORTER = noone;
	
	//Weather and day night cycles
	#macro WEATHER global.layer_sorter
	WEATHER = noone;
	
	// Data objects to be defined later
	#macro FURNITURE_LIBRARY global.furniture_library
	#macro DECOR_LIBRARY global.decor_library
	#macro SPRITE_LIBRARY global.sprite_library
	#macro ITEM_DATA_INTRINSIC global.item_data_intrinsic
	#macro RECIPE_LIBRARY global.recipe_library
	
	// Settings
	//settings_init();
	//settings_load();
}
	
