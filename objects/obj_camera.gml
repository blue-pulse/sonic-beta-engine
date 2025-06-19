#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Variables
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
target = noone;
lerp_value = 0.3;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Views
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
view_enabled = true;
view_visible[0] = true;
view_wview[0] = WIDTH;
view_hview[0] = HEIGHT;
view_wport[0] = WIDTH * SCALE;
view_hport[0] = HEIGHT * SCALE;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Follow player
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Early exit
if (!instance_exists(target)) {
    return false;
}

// Get target position
var target_x, target_y;
target_x = target.x - view_wview[0] / 2;
target_y = target.y - view_hview[0] / 2;

// Smoothly move the camera to the target position
view_xview[0] = lerp(view_xview[0], target_x, lerp_value);
view_yview[0] = lerp(view_yview[0], target_y, lerp_value);
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Clamp to room bounds
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Clamp
view_xview[0] = clamp(view_xview[0], 0, room_width - view_wview[0]);
view_yview[0] = clamp(view_yview[0], 0, room_height - view_hview[0]);
