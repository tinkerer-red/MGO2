function surface_rebuild(surface,width,height) {
	var _surface = surface;
	if ( surface_exists(_surface) ) {
		if (
			surface_get_width(_surface) != floor(width) ||
			surface_get_height(_surface) != floor(height)
		) {
			surface_free(_surface);
			
			_surface = surface_create(floor(width),floor(height));
		}
	} else {
		_surface = surface_create(floor(width),floor(height));
	}
	
	return _surface;
}

function draw_surface_center(surface,_x,_y,xscale,yscale,rot,col,alpha) {
	var
	_x_offset = (-surface_get_width(surface) * 0.5) * xscale,
	_y_offset = (-surface_get_height(surface) * 0.5) * yscale;
 
	draw_surface_ext(
	    surface,
	    (_x - 1) + lengthdir_x(_x_offset,rot) + lengthdir_x(_y_offset,rot - 90),
	    (_y - 1) + lengthdir_y(_x_offset,rot) + lengthdir_y(_y_offset,rot - 90),
	    xscale,
	    yscale,
	    rot,
	    col,
	    alpha
	);
}

function draw_surface_origin(surface,_x,_y,xorigin,yorigin,xscale,yscale,rot,col,alpha) {
	draw_surface_ext(
	    surface,
	    (_x - 1) + lengthdir_x(xorigin,rot) + lengthdir_x(yorigin,rot - 90),
	    (_y - 1) + lengthdir_y(xorigin,rot) + lengthdir_y(yorigin,rot - 90),
	    xscale,
	    yscale,
	    rot,
	    col,
	    alpha
	);
}
