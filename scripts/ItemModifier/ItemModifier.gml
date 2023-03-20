function ItemModifier() constructor{
	#region jsDoc
	/*
	@func		ItemModifier()
	@desc		Some built in simplifier functions all item modifiers will need
	@returns {struct}	self: 
	
	add @ before if you want these flags to be true
	ignore
	deprecated
	*/#endregion
	
	toState = function() {
		var _state = new State();
		_state.eventListeners = self.eventListeners
		_state.eventListeners.toString = method(_state.eventListeners, _state.__eventListeners_to_string)
		return _state
	}
	
	get_event = function() {
		return self.event;
	}
}