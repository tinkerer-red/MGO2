function ConcurrentStateMachine() : State() constructor {
	//This is just a state internally
}

function State() constructor {
	self.states = [];
	self.active = true;
	self.eventListeners = {};
	self.state_id = undefined;
	self.parent_state = undefined;
	self.__owner = other;
	self.current_state = undefined;
	self.current_state_id = undefined;
	self.desired_sub_state = undefined;
	
	#region Private
	__state_variables = {};
	
	__eventListeners_to_string = function() {
		var _str = "{"
		
		var _names = variable_struct_get_names(self);
		var _size = variable_struct_names_count(self);
		
		if (_size == 0) { return "{}"}
		
		var _key, _val, _func_str;
		
		var _i=0; repeat(_size) {
			_key = _names[_i];
			_val = self[$ _key];
			if (is_callable(_val)) {
				if (_key != "toString") {
					_func_str = func_to_readable_string(_val);
					_str += _key+": "+_func_str+","
				}
			}
		_i+=1;}//end repeat loop
		
		var _length = string_length(_str);
		_str = string_delete(_str, _length, 1);
		_str += "}";
		return _str;
	}
	
	__struct_is_state = function(_struct) {
		if !variable_struct_exists(_struct, "states")
		|| !variable_struct_exists(_struct, "active")
		|| !variable_struct_exists(_struct, "eventListeners")
		|| !variable_struct_exists(_struct, "state_id")
		|| !variable_struct_exists(_struct, "parent_state") {
			return false
		}
		return true
	}
	
	__get_state_index = function(_state_id) {
		var _func = method({state_id: _state_id}, function(_element, _index) {
			if (_element.state_id == self.state_id) {
				return true;
			}
			return false;
		})
		var _index = array_find_index(self.states, _func);
		
		return _index;
	}
	
	__get_state = function(_state_id) {
		var _index = __get_state_index(_state_id);
		
		if (_index == -1) return undefined;
		return self.states[_index];
	}
	
	__get_active_states = function() {
		var _active_states = [];
		var _state;
		var _size = array_length(self.states);
		
		var _i=0; repeat(_size) {
			_state = self.states[_i];
			if (_state.active) {
				array_push(_active_states, _state.state_id);
			}
		_i+=1;}//end repeat loop
		
		return _active_states;
	}
	
	__get_deactive_states = function() {
		var _deactive_states = [];
		var _state;
		var _size = array_length(self.states);
		
		var _i=0; repeat(_size) {
			_state = self.states[_i];
			if (!_state.active) {
				array_push(_deactive_states, _state.state_id);
			}
		_i+=1;}//end repeat loop
		
		return _deactive_states;
	}
	
	__is_event_defined = function(_event_name) {
		return variable_struct_exists(self.eventListeners, _event_name);
	}
	
	__set_current_state = function(_state) {
		current_state_id = _state.state_id;
		current_state = _state;
		
		if (!is_undefined(parent_state))
		&& (__struct_is_state(parent_state)) {
			parent_state.__set_current_state(_state);
		}
	}
	
	toString = function() {
		var _str = "{"
		var _names = variable_struct_get_names(self);
		var _size = array_length(_names);
		var _key, _val;
		
		var _i=0; repeat(_size) {
			_key = _names[_i];
			_val = self[$ _key]
			
			if (is_callable(_val)) {
				_i+=1;
				continue;
			}
			
			if (!is_undefined(_val))
			&& (is_struct(_val))
			&& (__struct_is_state(_val)){
				_str += _key + ": " + string(_val.state_id) + ","
				_i+=1;
				continue;
			}
			
			if (is_object_instance(_val)) {
				_str += _key + ": " + object_get_name(_val.object_index)+"_"+string_digits(string(_val.id)) + ","
				_i+=1;
				continue;
			}
			
			_str += _key + ": " + string(_val) + ","
			
		_i+=1;}//end repeat loop
		
		var _length = string_length(_str);
		_str = string_delete(_str, _length, 1);
		_str += "}";
		return _str;
	}
	#endregion
	
	#region Activations
	activate = function(_state = undefined) {
		if (is_undefined(_state)) {
			self.active = true;
		}
		else{
			var _csm_state = get_state(_state);
			_csm_state.activate()
		}
		return self;
	}
	
	deactivate = function(_state = undefined) {
		if (is_undefined(_state)) {
			self.active = false;
		}
		else{
			var _csm_state = get_state(_state);
			_csm_state.deactivate()
		}
		
		return self;
	}
	
	next_sub_state = function(_state = undefined) {
		if (is_undefined(_state)) {
			self.next_substate_queued = true;
			self.fsm.trigger("t_queue_next")
		}
		else{
			var _csm_state = get_state(_state);
			_csm_state.next_sub_state()
		}
		
		return self;
	}
	
	move_to_sub_state = function(_sub_state, _callback) {
		#region jsDoc
		/*
		@func		move_to_sub_state()
		@desc		queue up what the next desired state will be.
		@param {type}	sub_state : The state id you would like to end up all
		@returns {type}	callback : The function to call when the state has reached the desired substate.
		
		add @ before if you want these flags to be true
		ignore
		deprecated
		*/#endregion
		
		if (fsm.state_exists(_sub_state)) {
			self.desired_sub_state = _sub_state;
			
			if (fsm.get_current_state() != _sub_state) {
				self.next_substate_queued = true;
				self.next_substate_queued_callback = _callback;
			}
			else {
				if (!is_undefined(_callback)) {
					_callback();
				}
				
			}
		}
		else{
			show_error("argument 1, must be a valid sub state", true)
		}
	}
	
	get_sub_state = function(_state = undefined) {
		if (is_undefined(_state)) {
			return self.fsm.get_current_state();
		}
		else{
			var _csm_state = get_state(_state);
			return _csm_state.get_sub_state()
		}
		
	}
	#endregion
	
	#region Event Listeners
	add_event = function(_event_name, callback) {
		self.eventListeners[$ _event_name] = callback;
		
		return self;
	}
	
	remove_event = function(_event_name) {
		if (variable_struct_exists(self.eventListeners, _event_name)) {
			variable_struct_remove(self.eventListeners, _event_name)
		}
		
		return self;
	}
	
	has_event = function(_event_name) {
		if (variable_struct_exists(self.eventListeners, _event_name)) {
			return true;
		}
		
		return false;
	}
	
	fire_event = function(_event_name, eventData) {
		if (!__is_event_defined(_event_name)) {
			return;
		}
		
		__set_current_state(self);
		
		var _callback = self.eventListeners[$ _event_name]
		_callback(eventData);
	}
	#endregion
	
	#region State handlers
	add_state = function(_name, _struct, _start_active=true) {
		if (__struct_is_state(_struct)) {
			var _state = _struct;
		}
		else {
			//create and init a new state
			var _state = new State();
			_state.eventListeners = _struct;
			_state.eventListeners.toString = method(_state.eventListeners, __eventListeners_to_string)
		}
		
		_state.state_id = _name;
		_state.parent_state = self;
		_state.__owner = __owner;
		
		array_push(self.states, _state);
		
		if (_start_active) {
			activate(_name);
		}
		else{
			deactivate(_name);
		}
		
		return _state;
	}
	
	remove_state = function(_state_id) {
		var _index = __get_state_index(_state_id);
		array_delete(self.states, _index, 1);
		
		return self;
	}
	
	get_state = function(_state_id) {
		return __get_state(_state_id)
	}
	
	has_state = function(_state_id) {
		var _index = __get_state_index(_state_id);
		return (_index != -1);
	}
	
	run = function(_event_name) {
		if (!self.active) { return; }
		
		fire_event(_event_name);
		
		var _size = array_length(self.states)
		if (_size == 0) { return; }
		
		var _state;
		var _i=0; repeat(_size) {
			_state = self.states[_i];
			_state.run(_event_name);
		_i+=1;}//end repeat loop
	}
	
	get_current_state = function() {
		return self.current_state
	}
	
	get_current_state_id = function() {
		return self.current_state_id
	}
	
	get_state_var = function(_var) {
		return variable_struct_get(__state_variables, _var)
		
	}
	
	set_state_var = function(_var, _val) {
		__state_variables[$ _var] = _val;
	}
	
	state_var_exists = function(_var) {
		return variable_struct_exists(__state_variables, _var)
	}
	#endregion
	
}
