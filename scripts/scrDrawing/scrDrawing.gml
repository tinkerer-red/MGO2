function draw_set_align(_align = 7) {
	/// @desc draw_set_h/valign() in one function
	/// @param {real} [alignment=7]
	
	// 7 8 9
	// 4 5 6
	// 1 2 3
	switch(_align) {
		case 1 : draw_set_halign(fa_left);   draw_set_valign(fa_bottom); break;	
		case 2 : draw_set_halign(fa_center); draw_set_valign(fa_bottom); break;
		case 3 : draw_set_halign(fa_right);	 draw_set_valign(fa_bottom); break;
		case 4 : draw_set_halign(fa_left);	 draw_set_valign(fa_middle); break;
		case 5 : draw_set_halign(fa_center); draw_set_valign(fa_middle); break;
		case 6 : draw_set_halign(fa_right);	 draw_set_valign(fa_middle); break;
		case 7 : draw_set_halign(fa_left);	 draw_set_valign(fa_top);    break;
		case 8 : draw_set_halign(fa_center); draw_set_valign(fa_top);    break;
		case 9 : draw_set_halign(fa_right);	 draw_set_valign(fa_top);    break;
		default: draw_set_halign(fa_left);	 draw_set_valign(fa_top);    break;
	}
}

function draw_reset() {
	/// @desc Resets the draw state
	var _def = global.draw_defaults;
	draw_set_font(_def.font);
	draw_set_color(_def.color);
	draw_set_align(_def.align);
	draw_set_alpha(1.0);
}

function draw_text_col(_x, _y, _str, _col, _alpha = 1) {
	/// @desc Shortended draw_text_color()
	/// @param {real} x
	/// @param {real} y
	/// @param {string} string
	/// @param {color} color
	/// @param {real} [alpha=1]
	return draw_text_color(_x, _y, _str, _col, _col, _col, _col, _alpha);
}

function draw_text_with_background(_x, _y, _str, _col, _padding=6, _alpha=0.5) {
	/// @desc Draws text with background
	/// @param {real} x
	/// @param {real} y
	/// @param {string} string
	/// @param {color} color
	/// @param {real} [padding=6]
	
	draw_set_alpha(_alpha)
	var _height = string_height(_str);
	draw_rectangle_color(_x, _y, _x+string_width(_str)+2*_padding, _y+_height+2*_padding-1, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
	draw_set_align(7);
	draw_text_col(_x+_padding+1, _y+_padding+1, _str, c_white);
}

#region sprite center functions
function sprite_get_bbox_center_x(spr) {
	/// @desc Get's the center x possition of the bbox of a sprite
	/// @param {sprite} sprite
	
	var xoff = sprite_get_xoffset(spr),
			ww = bbox_right-bbox_left,
			cx = xoff - (ww/2),
	
	return cx;
}

function sprite_get_bbox_center_y(spr) {
	/// @desc Get's the center y possition of the bbox of a sprite
	/// @param {sprite} sprite
	
	var yoff = sprite_get_yoffset(spr),
			hh = bbox_bottom-bbox_top,
			cy = yoff - (hh/2);
	
	return cy;
}

function sprite_get_center_x(spr) {
	/// @desc Get's the center x possition of the sprite
	/// @param {sprite} sprite
	var xoff = sprite_get_xoffset(spr),
			ww = sprite_get_width(spr),
			cx = (xoff - (ww/2));
	
	return cx;
}

function sprite_get_center_y(spr) {
	/// @desc Get's the center y possition of the sprite
	/// @param {sprite} sprite
	var yoff = sprite_get_yoffset(spr),
			hh = sprite_get_height(spr),
			cy = (yoff - (hh/2));
	
	return cy;
}

function avatar_get_bounds(spr, _img = 0) {
	/// @desc Get actual bounds of avatar
	/// @param {sprite} sprite
	var xoff = sprite_get_xoffset(spr);
	var yoff = sprite_get_yoffset(spr);
	
	return {
		centre_x: xoff,
		centre_y: yoff,
		left: sprite_get_bbox_left(spr),
		right: sprite_get_bbox_right(spr),
		top: sprite_get_bbox_top(spr),
		bottom: sprite_get_bbox_bottom(spr)
	}
}

function sprite_get_canvas(_spr) {
	/// @desc Get's the bounding area offsets of the sprite (similar to bbox or nineslice except for the sprite canvas)
	return {
		left   : sprite_get_xoffset(_spr),
		top    : sprite_get_yoffset(_spr),
		right  : sprite_get_xoffset(_spr)+sprite_get_width(_spr),
		bottom : sprite_get_yoffset(_spr)+sprite_get_height(_spr),
	}
}
#endregion

function sprite_get_cropped_width(_spr, _img, _uv = -1) {	
	//returns the cropped canvas size after the compiler removes access data
	//this is slow and should be cached
	var _uvs = _uv == -1 ? sprite_get_uvs(_spr, _img) : _uv;
	var _tex = sprite_get_texture(_spr, _img);
	var _sprite_tex_width = (1/texture_get_texel_width(_tex)*(_uvs[2]-_uvs[0]));
	return _sprite_tex_width;
};

function sprite_get_cropped_height(_spr, _img, _uv = -1) {
	//returns the cropped canvas size after the compiler removes access data
	//this is slow and should be cached
	var _uvs = _uv == -1 ? sprite_get_uvs(_spr, _img) : _uv;
	var _tex = sprite_get_texture(_spr, _img);
	var _sprite_tex_height = (1/texture_get_texel_height(_tex)*(_uvs[3]-_uvs[1]));
	return _sprite_tex_height;
};

function sprite_get_current_frame(_spr, _offset = 0) {
	/// @desc Get's the current frame to draw based off the current_time
	/// @param {sprite} sprite
	if (sprite_get_number(_spr) == 0) { return 0; };
	
	var _frame = (sprite_get_speed_type(_spr) == spritespeed_framespersecond) ? (current_time/(1000/sprite_get_speed(_spr))) : (current_time/((1000/room_speed)/sprite_get_speed(_spr)));
	_frame = _frame+_offset;
	_frame = _frame mod sprite_get_number(_spr);
	
	return _frame;
}

function sprite_get_animation_time(_spr) {
	/// @desc Returns the number of frames the animation will take to finish
	/// @param {sprite} sprite
	if (sprite_get_speed_type(_spr) = spritespeed_framespersecond){
		return room_speed/sprite_get_speed(_spr)*sprite_get_number(_spr);
	}else{
		return room_speed*sprite_get_speed(_spr)*sprite_get_number(_spr);
	}
}

function scale_canvas(base_width,base_height,current_width,current_heigh,center) {
	var _aspect = (base_width / base_height);

	if ((current_width / _aspect) > current_heigh) {
	    window_set_size((current_heigh *_aspect), current_heigh);
	} else {
	    window_set_size(current_width, (current_width / _aspect));
	}
	
	if (center) {
	    window_center();
	}

	surface_resize(application_surface,min(window_get_width(),base_width),min(window_get_height(),base_height));
}

function draw_set_text(font,halign,valign,color) {
	draw_set_font(font);
	draw_set_halign(halign);
	draw_set_valign(valign);
	draw_set_color(color);
}

function draw_rectangle_spr(x1,y1,x2,y2,color,alpha) {
	draw_sprite_ext(sPixel,0,argument0,argument1,argument2-argument0,argument3-argument1,0,argument4,argument5);
}

function draw_rectangle_spr_outline(x1,y1,x2,y2,color,alpha,thickness) {
	// Top
	draw_sprite_ext(sPixel,0,argument0,argument1,argument2-argument0,argument6,0,argument4,argument5);

	// Bottom
	draw_sprite_ext(sPixel,0,argument0,argument3 - (argument6 - 1),argument2-argument0,argument6,0,argument4,argument5);

	// Left
	draw_sprite_ext(sPixel,0,argument0,argument1,argument6,argument3 - argument1,0,argument4,argument5);

	// Right
	draw_sprite_ext(sPixel,0,argument2 - (argument6 - 1),argument1,argument6,argument3 - argument1 + 1,0,argument4,argument5);
}

function draw_text_outline(x,y,str,textColor,textAlpha,outlineColor,outlineAlpha,xscale,yscale,angle) {
	// Create the outline
	draw_text_transformed_color(x + 1,y,str,xscale,yscale,angle,outlineColor,outlineColor,outlineColor,outlineColor,outlineAlpha);		// Direction: 0
	draw_text_transformed_color(x + 1,y - 1,str,xscale,yscale,angle,outlineColor,outlineColor,outlineColor,outlineColor,outlineAlpha);	// Direction: 45
	draw_text_transformed_color(x,y - 1,str,xscale,yscale,angle,outlineColor,outlineColor,outlineColor,outlineColor,outlineAlpha);		// Direction: 90
	draw_text_transformed_color(x - 1,y - 1,str,xscale,yscale,angle,outlineColor,outlineColor,outlineColor,outlineColor,outlineAlpha);	// Direction: 135
	draw_text_transformed_color(x - 1,y,str,xscale,yscale,angle,outlineColor,outlineColor,outlineColor,outlineColor,outlineAlpha);		// Direction: 180
	draw_text_transformed_color(x - 1,y + 1,str,xscale,yscale,angle,outlineColor,outlineColor,outlineColor,outlineColor,outlineAlpha);	// Direction: 225
	draw_text_transformed_color(x,y + 1,str,xscale,yscale,angle,outlineColor,outlineColor,outlineColor,outlineColor,outlineAlpha);		// Direction: 270
	draw_text_transformed_color(x + 1,y + 1,str,xscale,yscale,angle,outlineColor,outlineColor,outlineColor,outlineColor,outlineAlpha);	// Direction: 315
	
	// Now create the base text
	draw_text_transformed_color(x,y,str,xscale,yscale,angle,textColor,textColor,textColor,textColor,textAlpha);
}

function draw_sprite_ext_skew(_sprite,_subimg,ox,oy,sx,sy,kx,ky,rot,alpha) {
	for (var c = 0; c < 4; c++) {
	    var lx = -sprite_get_xoffset(_sprite);
	    if (c & 1) lx += sprite_get_width(_sprite);
	    var ly = -sprite_get_yoffset(_sprite);
	    if (c & 2) ly += sprite_get_height(_sprite);
	    //
	    var rx = lengthdir_x(lx, rot) + lengthdir_x(ly, rot - 90);
	    var ry = lengthdir_y(lx, rot) + lengthdir_y(ly, rot - 90);
	    global._draw_sprite_ext_skew_x[c] = ox + (rx + ry * kx) * sx;
	    global._draw_sprite_ext_skew_y[c] = oy + (ry + rx * ky) * sy;
	}
	
	draw_sprite_pos(
		_sprite,
		_subimg,
	    global._draw_sprite_ext_skew_x[0],
	    global._draw_sprite_ext_skew_y[0],
	    global._draw_sprite_ext_skew_x[1],
	    global._draw_sprite_ext_skew_y[1],
	    global._draw_sprite_ext_skew_x[3],
	    global._draw_sprite_ext_skew_y[3],
	    global._draw_sprite_ext_skew_x[2],
	    global._draw_sprite_ext_skew_y[2],
	    alpha
	);
}
	
function draw_sprite_tile(sprite,subimg,x1,y1,x2,y2,xscale,yscale,color,alpha) {
	var
	_sprite_width_scaled = sprite_get_width(sprite) * xscale,
	_sprite_height_scaled = sprite_get_height(sprite) * yscale;
	
	for ( var _x = x1; _x < x2; _x += _sprite_width_scaled; ) {
		for ( var _y = y1; _y < y2; _y += _sprite_height_scaled; ) {
			draw_sprite_ext(sprite,subimg,_x,_y,xscale,yscale,0,color,alpha); 
		}
	}
}
	
function draw_sprite_tile_ext(sprite,subimg,x1,y1,x2,y2,x_offset,y_offset,xscale,yscale,color,alpha) {
	var
	_sprite_width_scaled = sprite_get_width(sprite) * xscale,
	_sprite_height_scaled = sprite_get_height(sprite) * yscale;
	
	for ( var _x = x1; _x < x2; _x += _sprite_width_scaled; ) {
		for ( var _y = y1; _y < y2; _y += _sprite_height_scaled; ) {
			draw_sprite_ext(sprite,subimg,_x + x_offset,_y + y_offset,xscale,yscale,0,color,alpha); 
		}
	}
}
	
function draw_texture_quad(tex,x1,y1,x2,y2,x3,y3,x4,y4,step) {
	var w1xs,w1ys,w2xs,w2ys;

	w1xs = (x2-x1)/step;
	w1ys = (y2-y1)/step;
	w2xs = (x4-x3)/step;
	w2ys = (y4-y3)/step;

	var w1xat,w1yat,w2xat,w2yat;

	w1xat = x2;
	w1yat = y2;
	w2xat = x4;
	w2yat = y4;

	var us; us = 1/step;
	var uat; uat = 1;

	var c; c = draw_get_color();
	draw_set_color(c_white);
	draw_primitive_begin_texture(pr_trianglestrip, tex);


	repeat ( step+1 ) {
	    draw_vertex_texture(w1xat,w1yat,uat,0)
	    draw_vertex_texture(w2xat,w2yat,uat,1)
	    uat-=us;
	    w1xat-=w1xs;
	    w1yat-=w1ys;
	    w2xat-=w2xs;
	    w2yat-=w2ys;
	}
	draw_primitive_end();
	draw_set_color(c);
}

function draw_sprite_outline(sprite,subimage,x,y,xscale,yscale,rot,thickness,color,alpha) {
	var
	_r = color_get_red(color) / 255,
	_g = color_get_green(color) / 255,
	_b = color_get_blue(color) / 255;
	
	shader_set(shd_color);
	shader_set_uniform_f_array(shader_get_uniform(shd_color,"color"),[_r,_g,_b,alpha])
	for ( var _y = -thickness; _y <= thickness; ++ _y ) {
		for ( var _x = -thickness; _x <= thickness; ++ _x ) {
			draw_sprite_ext(
				sprite,
				subimage,
				x + _x,
				y + _y,
				xscale,
				yscale,
				rot,
				c_white,
				1
			);
		}
	}
	shader_reset();
}

function draw_sprite_part_ext_outline(sprite,subimage,left,top,w,h,x,y,xscale,yscale,thickness,color,alpha) {
	var
	_r = color_get_red(color) / 255,
	_g = color_get_green(color) / 255,
	_b = color_get_blue(color) / 255;
	
	shader_set(shd_color);
	shader_set_uniform_f_array(shader_get_uniform(shd_color,"color"),[_r,_g,_b,alpha])
	for ( var _y = -thickness; _y <= thickness; ++ _y ) {
		for ( var _x = -thickness; _x <= thickness; ++ _x ) {
			draw_sprite_part_ext(
				sprite,
				subimage,
				left,
				top,
				w,
				h,
				x + _x,
				y + _y,
				xscale,
				yscale,
				c_white,
				1
			);
		}
	}
	shader_reset();
}

function make_color_rgba(red,green,blue,alpha) {
	return (argument3 << 24) | (argument2 << 0) | (argument1 << 8) | (argument0 << 16);
}
