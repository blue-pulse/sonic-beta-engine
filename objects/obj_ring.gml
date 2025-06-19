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
pos_x = x;
pos_y = y;
value = 1;
image_speed = 0.5;
#define Collision_obj_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Increase amount
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Increase amount
Player.rings += value;

// VFX
effect_create_below(ef_spark, pos_x, pos_y, 0.025, c_yellow);

// SFX
audio_play(snd_ring);

// Destroy object
instance_destroy();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Adjust parameters
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
x = pos_x;
y = pos_y;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Draw self
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=500
invert=0
*/
