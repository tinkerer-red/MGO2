csm.run("update")

var _test = {
	move: {
		active: csm.get_state("move").active,
		queued: csm.get_state("move").next_substate_queued,
		postponed: csm.get_state("move").postpone_transition,
		substate: csm.get_state("move").fsm.get_current_state(),
	},
};

var _str = json_beautify(_test)
draw_text(x+32,y+32,_str)

draw_circle(x,y,8,false);
var _str = string(csm.__get_active_states());
draw_text(x+8, y+8, _str);
