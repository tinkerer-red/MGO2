global.String_Illegal_Characters = [
	"\\",@"\","\t","\r",
];

function func_to_readable_string(_func) {
	var _orig_str = string(_func) 
	if (string_pos("function ", _orig_str)) {
		//convert global function names
		if (string_count("gml", _orig_str) == 1) {
			var _names = variable_struct_get_names(global);
			var _size = variable_struct_names_count(global);
			var _key, _val;
			var _i=0; repeat(_size) {
				_key = _names[_i];
				_val = variable_struct_get(global, _key);
				if (_val == _func) {
					var _str = "global."+_key;
				}
			_i+=1;}//end repeat loop
		}
		
		else {//convert object or known script function names
			while (string_pos("gml", _orig_str)) {
				_orig_str = string_delete(_orig_str, 1, string_pos("gml_", _orig_str)+3)
			}
			_str = "function "+_orig_str
		}
	}
	else {
		var _str = "function "+script_get_name(_func);
	}
	
	return _str;
}

function string_legal(str) {
	var _str = str;
	for ( var i = 1; i <= string_length(_str); ++ i; ) {
		if ( array_find_index(global.String_Illegal_Characters,string_char_at(_str,i)) != -1 ) {
		    _str = string_delete(_str,i --,1);
		}
	}

	return _str;
}

function string_real_commas(value) {
	if ( is_real(value) ) {
	    var str = string(value);
	} else {
	    var str = value;
	}
 
	var _str = "";
 
	var str_length = string_length(str);
 
	var space_count = 0;
 
	for ( var i = str_length; i > 0; i --; )
	{
	    _str = string_char_at(str,i) + _str;
	    space_count ++;
	    if ( space_count == 3 )
	    {
	space_count = 0;
	if ( i > 1 )
	{
	    _str = "," + _str;
	}
	    }
	}
 
	return _str;
}

function string_real_short(value) {
	if ( is_real(value) ) {
	    var str = string(value);
	} else {
	    var str = value;
	}
	
	var _is_positive = string_length(string_digits(string_char_at(str, 1)));
	
	if (!_is_positive){
		str = string_delete(str, 1, 1);	
	}
 
	var _str = "";
 
	var str_length = string_length(str);
 
	var space_count = 0;
 
	for ( var i = str_length; i > 0; i --; ) {
	    _str = string_char_at(str,i) + _str;
	    space_count ++;
	    if ( space_count == 3 ) {
			space_count = 0;
			if ( i > 1 ) {
			    _str = "," + _str;
			}
	    }
	}
	
	var _count = string_count(",",_str);
	
	var _closing_character = "";
	if ( _count == 1 ) {
		_closing_character = "k";
	} else if ( _count == 2 ) {
		_closing_character = "m";
	} else if ( _count == 3 ) {
		_closing_character = "b";
	} else if ( _count == 4 ) {
		_closing_character = "t";
	} else if ( _count == 5 ) {
		_closing_character = "q";
	}
	
	_str = string_replace_all(_str,",",".");
	var _pos = string_pos(".",_str );
	if ( _pos != 0 ) {
		_str = string_delete(_str,_pos + 2,string_length(_str)) + _closing_character;
	}
	
	if (!_is_positive){
		_str = string_insert("-", _str, 1);	
	}
 
	return _str;
}

function string_split(str,width,split) {
	var pos_space, pos_current, text_current, text_output;
	pos_space = -1;
	pos_current = 1;
	text_current = str;

	text_output = "";

	while ( string_length(text_current) >= pos_current ) {
	    if ( string_width(string_copy(text_current,1,pos_current)) > width ) {
	//if there is a space in this line then we can break there
	if ( pos_space != -1 ) {
	    text_output += string_copy(text_current,1,pos_space) + "\n";
	    //remove the text we just looked at from the current text string
	    text_current = string_copy(text_current,pos_space + 1,string_length(text_current) - pos_space);
	    pos_current = 1;
	    pos_space = -1;
	} else if ( split ) {
	    //if not, we can force line breaks
	    text_output += string_copy(text_current,1,pos_current-1) + "\n";
	    //remove the text we just looked at from the current text string
	    text_current = string_copy(text_current,pos_current,string_length(text_current) - (pos_current - 1));
	    pos_current = 1;
	    pos_space = -1;
	}
	    }
	
	    if ( string_char_at(text_current,pos_current) == " " ) {
			pos_space = pos_current;
		}
	
	    pos_current += 1;
	}

	if (string_length(text_current) > 0) {
		text_output += text_current;
	}

	return text_output;
}
	
function string_value0_div_value1(a,b) {
	return string(ceil(a)) + "/" + string(ceil(b));
}

function string_make_readable(str) {
	return string_replace_all(str,"\t","\n");
}

function string_concat() {
	/// @param {string} [str]
	/// @returns {string}
	
	var _str = "";
	var _i = 0; repeat (argument_count) {
		_str += string(argument[_i]);
		++_i;
	}
	return _str;
}

function string_clense(_str, _font) {
	/// @param {string} str
	/// @returns {string}
	
	var _font_info = font_get_info(_font);
	var _approved_char = variable_struct_get_names(_font_info.glyphs);
	
	var _approved_str = _str;
	var _remaining_char = _str;
	
	//remove approved strings
	for (var _i = 0; _i < array_length(_approved_char); _i++){
		var _char = _approved_char[_i];
		_remaining_char = string_replace_all(_remaining_char, _char, "");
	}
	
	//remove the non approved 
	while(string_length(_remaining_char) != 0){
		var _char = string_copy(_remaining_char, 1, 1);
		_approved_str = string_replace_all(_approved_str, _char, "");
		_remaining_char = string_replace_all(_remaining_char, _char, "");
	}
	
	return _approved_str;
}

function string_pad_right(_string, _length, _pad){
	///scr_string_pad_right(string, length, pad)
	
	/**
	 * Pads the string to the desired length with subject string from the right
	 *
	 * @param   string   The input string, string
	 * @param   length   The desired length of the string, real
	 * @param   subject  The subject string to use for padding, string
	 * 
	 * @return  Returns the string to the desired length with subject string from the right, real
	 */
	
	var _pad_size, _padding, _out;
	
	_pad_size = string_length(_pad);
	_padding = max(0, _length - string_length(_string));
	
	_out  = _string;
	_out += string_repeat(_pad, _padding div _pad_size);
	_out += string_copy(_pad, 1, _padding mod _pad_size);
	_out  = string_copy(_out, 1, _length);
	
	return _out;
}

function string_get(_str, prefix, suffix){
	///string_get(_str, prefix, suffix)
	//
	// @para   _str     the string to look through
	// @para   prefix       the begining of the string to find
	// @para   suffix       the end of the string to find
	//
	// Returns : string
	_string_copy = _str
	var prefixPos = string_pos(prefix, _string_copy)
	if (prefixPos != 0) {
	    var _string_copy = string_delete(_string_copy, 1, prefixPos-1);
			var _length = string_length(prefix);
	    _str   = string_copy(_string_copy, 1, _length );
	    var _string_copy = string_delete(_string_copy, 1, _length );
	    var suffixPos = string_pos(suffix, _string_copy);
	    if (suffixPos != 0) {
	        var suffixLength = string_length(suffix);
	        _str = (_str + string_copy(_string_copy,1,(suffixPos+suffixLength)-1));
	        return _str
	    }else{
	        return undefined;
	    }
	}else{
	    return undefined;
	}
}

function string_remove_before(_str, subString) {
	///string_remove_before(_str,subString)
	
	// _str - source string
	// substring - the string to remove everything before
	
	// returns string or undefined
	
	var _string_copy = _str;
	var sPos    = string_pos(subString,_string_copy) - 1;
	if (sPos != -1){
	  _string_copy = string_delete(_string_copy,1,sPos);
	  return _string_copy;
	}else{
	  return undefined
	}
}

function string_remove(_str, subString) {
	///string_remove(_str,subString)
	
	// _str - source string
	// substring - the string to remove
	//
	// return: string or undefined
	
	var sPos    = string_pos(subString,_str);
	if (sPos != -1){
	  var sLength = string_length(subString)
	  _str = string_delete(_str,sPos,sLength);
	  return _str;
	}else{
	  return undefined
	}
}

function string_remove_after(_str, subString) {
	// returns string or undefined
	
	var stringCopy = _str;
	var sPos = string_pos(subString, stringCopy);
	if (sPos != -1) {
	  var sLength = string_length(subString)
	  stringCopy = string_delete(stringCopy,sPos+sLength,string_length(stringCopy));
	  return stringCopy;
	}else{
	return undefined
	}
}

function string_get_array(_str, prefix, suffix) {
	// similar to splitting a string into an array, but using prefixes and suffixes instead of seporators
	
	var _new_str = string_get(_str, prefix, suffix)
	var _arr = [];
	
	while (!is_undefined(_new_str)) {
		_str = string_remove_before(_str, _new_str);
		_str = string_remove(_str, _new_str);
		
		array_push(_arr, _new_str)
		
		_new_str = string_get(_str, prefix, suffix);
	}
	
	return _arr
}

function string_upper_fast(_str) {
	// A = 65
	// Z = 90
	// a = 97
	// z = 122
	var _new_str = _str;
	var _size = string_length(_new_str);
	var _byte;
	var _i=1; repeat(_size) {
		_byte = string_byte_at(_new_str, _i);
		if (_byte >= 97 && _byte <= 122) {
			_byte -= 32
			_new_str = string_set_byte_at(_new_str, _i, _byte);
		}
	_i+=1;}//end repeat loop
	
	return _new_str;
}


