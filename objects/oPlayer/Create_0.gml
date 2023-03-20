pid = 0 // player id

event_inherited();

log("created player")

var _inputs = instance_create_depth(0,0,15000,oPlayerInput)
_inputs.target = self.id;