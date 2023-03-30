enum BODY_PART {
	HEAD,
	BODY,
	SHADOW,
	EFFECTS
}

entity_draw_set_sprite = function(_body_part, _sprite) {
	
};
entity_draw_set_image = function(_body_part, _sprite) {
	
};
entity_draw_set_x = function(_body_part, _sprite) {
	
};
entity_draw_set_y = function(_body_part, _sprite) {
	
};
entity_draw_set_xscale = function(_body_part, _sprite) {
	
};
entity_draw_set_yscale = function(_body_part, _sprite) {
	
};
entity_draw_set_rot = function(_body_part, _sprite) {
	
};
entity_draw_set_col = function(_body_part, _sprite) {
	
};
entity_draw_set_alpha = function(_body_part, _sprite) {
	
};

draw_body_part = function(_body_part) {
	var _data = body_data[_body_part];
	
	var _sprite_index = _data.draw_sprite_index;
	var _image_index = _data.draw_image_index;
	var _x = x+_data.draw_x_off;
	var _y = y+_data.draw_y_off;
	var _image_xscale = image_xscale+_data.draw_image_xscale;
	var _image_yscale = image_yscale+_data.draw_image_yscale;
	var _image_angle = image_angle+_data.draw_image_angle;
	var _image_blend = image_blend+_data.draw_image_blend;
	var _image_alpha = image_alpha+_data.draw_image_alpha;
	
	//doing this save a ton of performance for default walking with default size
	// tried seporating out the blend and alpha too but doing so makes it slightly less performant
	// really only noticable difference with upwards of 100+ players
	if (_image_xscale == 1) && (_image_yscale == 1) && (_image_angle == 0) {
		draw_sprite(_sprite_index,
								_image_index,
								_x,
								_y)
	}
	else {
		draw_sprite_ext(_sprite_index,
										_image_index,
										_x,
										_y,
										_image_xscale,
										_image_yscale,
										_image_angle,
										_image_blend,
										_image_alpha);
	}
	
}