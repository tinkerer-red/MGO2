with ( input ) {
	x_previous = x;
	y_previous = y;
	x = mouse_x;
	y = mouse_y;
	
	x_gui_previous = x_gui;
	y_gui_previous = y_gui;
	x_gui = device_mouse_x_to_gui(0);
	y_gui = device_mouse_y_to_gui(0);
	
	consumed = false;
}

var _data, _i;
for (_i = 0; _i < array_length(input_stack); ++_i) {
	_data = input_stack[_i];
	if ( _data.callback(input) > 0 ) {
		input.consumed = true;
	}
}
