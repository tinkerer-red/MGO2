var _current_runtime = "2023.2.1.90";
var _current_beta_runtime = "2022.900.0.205";
if (GM_runtime_version != _current_runtime && GM_runtime_version != _current_beta_runtime) {
	show_error("You are using the wrong runtime, please change your runtime in the IDE to " + _current_runtime + " or " + _current_beta_runtime + " (Beta IDE)", true)
}

function scrInit() {
	init_globals();
	//init_entity_library();
	//init_sprite_library();
	//init_item_library();
	//init_decor_library();
	//init_recipe_library();
	
	randomize();
	
	// Config-specific overrides
	global.os_config = os_get_config()
	switch(global.os_config) {
		case "Default": {
			room_goto(rm_main_menu);
		break;}
		case "Dev": {
			room_goto(rm_dev_room);
		break;}
		case "Room Builder": {
			room_goto(rm_room_builder);
		break;}
		default:
			show_error("Config not added in scrInit", true);
	}
}