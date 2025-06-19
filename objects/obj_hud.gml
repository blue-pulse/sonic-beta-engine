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
spr_life = Player.spr_life;
fnt_hud = global.fnt_hud;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Verify if player exists
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Destroy HUD
if (!instance_exists(Player)) {
    instance_destroy();
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Draw icons
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Draw HUD counters
draw_sprite(spr_hud, 0, view_xview[0], view_yview[0]);
draw_sprite(spr_life, 0, view_xview[0] + 15, view_yview[0] + 211);
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Draw text
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Prepare font
draw_set_color(c_white);
draw_set_font(fnt_hud);

// Timer
draw_set_halign(fa_left);
draw_text(view_xview[0] + 107, view_yview[0] + 26, int_to_text((global.timer div 10) mod 100, 2));
draw_text(view_xview[0] + 84, view_yview[0] + 26, int_to_text((global.timer div 1000) mod 60, 2));
draw_text(view_xview[0] + 60, view_yview[0] + 26, int_to_text((global.timer div 60000) mod 60, 2));
draw_set_halign(fa_right);

// Score
draw_text(view_xview[0] + 122, view_yview[0] + 10, int_to_text(global.score, 6));

// Rings
draw_text(view_xview[0] + 122, view_yview[0] + 42, int_to_text(Player.rings, 3));

// Lives
draw_text(view_xview[0] + 55, view_yview[0] + 204, int_to_text(global.lives, 2));
