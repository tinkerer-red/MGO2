// Macros

// These macros replace show_message on the server to prevent hanging
#macro DedicatedGameServer:show_message show_debug_message

// Object instantiation
#macro EVENT_ACTIVATE       event_user(11)
#macro EVENT_IMPORT			event_user(12)
#macro EVENT_FSM			event_user(13)
#macro EVENT_CONSTRUCTOR	event_user(14)
#macro EVENT_METHOD			event_user(15)

// GUI
#macro GUI_W display_get_gui_width()
#macro GUI_H display_get_gui_height()

#macro mouse_gui_x device_mouse_x_to_gui(0)
#macro mouse_gui_y device_mouse_y_to_gui(0)

// Tiling
#macro CELL_SIZE 32 
#macro MP_SIZE 8 //how precise collision is
#macro CHUNK_SIZE 32 //tiles across and down

// FPS stuff
#macro CLIENT_FPS 60
#macro GAME_FPS game_get_speed(gamespeed_fps)
#macro GAME_FPM game_get_speed(gamespeed_fps)*60
#macro GAME_FPH game_get_speed(gamespeed_fps)*3600

// ***
// *** Networking timings
// ***
#macro NETWORK_GAME_FPS 10 // speed of the server in FPS
#macro NETWORK_FRAMES 5 // fast tick rate in Hz for rapid dynamic data updates
#macro NETWORK_SECONDS_SLOW_UPDATE 5 // slow tick rate in seconds for slow/idle updates
#macro NETWORK_CHUNK_SIZE 400
#macro NETWORK_SECONDS_PLAYER_ALIVE 10 // how many seconds since last signal, a player is considered connected for

#macro SMOOTHING_FILTER 0.8 // spr filter for smoothing positions