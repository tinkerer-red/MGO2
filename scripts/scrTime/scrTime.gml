/// @param {real} seconds
/// @returns {real} Number of steps in given seconds
function get_frames_from_seconds(_seconds) {
	return (_seconds * GAME_FPS);
}

/// @returns {int} Unix timestamp in seconds
function unix_timestamp() {
	return floor(unix_timestamp_ms()/1000);
}

/// @returns {int} Unix timestamp in milliseconds
function unix_timestamp_ms() {
	var _old_tz = date_get_timezone();
	date_set_timezone(timezone_utc);
	var _timestamp = floor((date_current_datetime() - 25569) * 86400000);
	date_set_timezone(_old_tz);
	return floor(_timestamp);
}


function unix_to_gamemaker_timestamp(_arg) {
	return _arg / 86400000 + 25569;
}

