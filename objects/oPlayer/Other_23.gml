/// @desc CSM - Concurrent State Machine

// Inherit the parent event
event_inherited();

var _state = csm.get_state("movement")
_state.add_state("walk", {
	enter: function() {
		log("enter")
	},
	step: function() {
		log("walking")
		
		x += input_vector.x * 2;
		y += input_vector.y * 2;
	},
	leave: function() {
		log("leaving")
	},
});

csm.add_event("idle", function(){
	log("drawing")
	draw_circle(x,y,8,false)
});


