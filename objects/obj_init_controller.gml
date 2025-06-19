#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Init game
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Set caption
window_set_caption(TITLE);

// Change window size
window_center();
window_set_size(WIDTH * SCALE, HEIGHT * SCALE);
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Globals
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.fnt_hud = font_add_sprite(spr_hud_font, ord("0"), true, 0);
global.timer = 0;
global.lives = 3;
global.score = 0;
global.character = obj_tails;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Change room
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
room_goto(rm_test);
