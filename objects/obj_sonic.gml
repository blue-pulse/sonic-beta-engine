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
// Basic variables
rings = 0;

// Position variables
pos_x = x;
pos_y = y;
angle = 0;
opacity = 1;

// Physics variables
accel = 0.095;
decel = 0.225;
frict = 0.046875;
grv = 0.31875;
hor_speed = 0;
ver_speed = 0;
jump_height = -7.5;
min_jump_height = -4.25;
max_hor_speed = 8;
max_ver_speed = 16;
max_abs_speed = 17;
roll_decel = 0.03;
roll_frict = 0.026875;
spindash_charge = 0;

// Control variables
dir = RIGHT;
plane = 0;
state = 0;

// Flags
is_grounded = false;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=States
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
st_normal = 0;
st_jump = 1;
st_duck = 2;
st_hurt = 3;
st_roll = 4;
st_skid = 5;
st_fall = 6;
st_spindash = 7;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Assets
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spr_life = spr_sonic_icon;
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Physics
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Limit speed
hor_speed = clamp(hor_speed, -max_abs_speed, max_abs_speed);
ver_speed = clamp(ver_speed, -max_abs_speed, max_abs_speed);

// Horizontal movement
pos_x += dcos(angle) * hor_speed;
pos_y -= dsin(angle) * hor_speed;

// Move the player outside in case he has got stuck into the wall
while (hor_speed > 0 and player_collision_right(pos_x, pos_y, angle, spr_mask_mid)) {
    pos_x -= dcos(angle);
    pos_y += dsin(angle);
}

while (hor_speed < 0 and player_collision_left(pos_x, pos_y, angle, spr_mask_mid)) {
    pos_x += dcos(angle);
    pos_y -= dsin(angle);
}

// Vertical movement
if (!is_grounded) {
    // Change vertical position
    pos_y += ver_speed;

    // Move the player outside in case he has got stuck into the floor or the ceiling
    while (ver_speed < 0 and player_collision_top(pos_x, pos_y, 0, spr_mask_mid)) {
        pos_y += 1;
    }

    while (ver_speed > 0 and player_collision_bottom(pos_x, pos_y, 0, spr_mask_mid)) {
        pos_y -= 1;
    }

    // Check for landing
    if (ver_speed >= 0 and player_collision_bottom(pos_x, pos_y, 0, spr_mask_big)) {
        // Angle check
        if (player_collision_left_edge(pos_x, pos_y, 0) and player_collision_right_edge(pos_x, pos_y, 0)) {
            angle = player_get_angle(pos_x, pos_y, 0);
        } else {
            angle = 0;
        }

        // Position
        hor_speed -= dsin(angle) * ver_speed;
        ver_speed = 0;
        is_grounded = true;
    }

    // Wall collision
    while (player_collision_right(pos_x, pos_y, angle, spr_mask_mid)) {
        pos_x -= dcos(angle);
        pos_y += dsin(angle);
    }

    while (player_collision_left(pos_x, pos_y, angle, spr_mask_mid)) {
        pos_x += dcos(angle);
        pos_y -= dsin(angle);
    }
}

// Stop being on ground
else if (!player_collision_bottom(pos_x, pos_y, angle, spr_mask_big)) {
    is_grounded = false;
}

// Slope
else {
    if (player_collision_main(pos_x, pos_y)) {
        while (player_collision_main(pos_x, pos_y)) {
            pos_x -= dsin(angle);
            pos_y -= dcos(angle);
        }
    }

    if (player_collision_slope(pos_x, pos_y, angle, spr_mask_mid) and !player_collision_main(pos_x, pos_y)) {
        while (player_collision_main(pos_x, pos_y)) {
            pos_x += dsin(angle);
            pos_y += dcos(angle);
        }
    }
}

// Fall from surface if there isn't enough speed
if (is_grounded and angle > 80 and angle < 280 and abs(hor_speed) < 3) {
    ver_speed = -dsin(angle) * hor_speed;
    hor_speed = dcos(angle) * hor_speed;
    is_grounded = false;
}

// Fall off the ground if the edges aren't colliding
if (is_grounded and angle != 0 and (!player_collision_left_edge(pos_x, pos_y, angle) or !player_collision_right_edge(pos_x, pos_y, angle))) {
    ver_speed = -dsin(angle) * hor_speed;
    hor_speed = dcos(angle) * hor_speed;
    is_grounded = false;
}

// Get new angle
if (is_grounded and player_collision_left_edge(pos_x, pos_y, angle) and player_collision_right_edge(pos_x, pos_y, angle)) {
    // Store the new angle
    var new_angle;
    new_angle = player_get_angle(pos_x, pos_y, angle);

    if (abs(angle - new_angle) < 45) {
        angle = angle + (new_angle - angle) * 0.5;
    } else {
        angle = new_angle;
    }
} else {
    angle = 0;
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Movement
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Variables
var do_skid, spindash_speed;
do_skid = false;
spindash_speed = 0;

// Horizontal movement
if (state == st_normal or state == st_jump or state == st_fall) {
    // Left
    if (keyboard_check(BTN_LEFT)) {
        // Decelerate
        if (hor_speed > 0) {
            do_skid = true;
            hor_speed -= decel;

            if (hor_speed <= 0) {
                hor_speed = -0.5;
            }
        }

        // Accelerate
        else {
            // Speed cap
            if (hor_speed > -max_hor_speed) {
                hor_speed = max(hor_speed - accel, -max_hor_speed);
            }

            // Change direction
            if (dir != LEFT) {
                dir = LEFT;
                if (is_grounded) {
                    state = st_normal;
                }
            }

            // Stop skidding
            if (state == st_skid) {
                state = st_normal;
            }
        }
    }

    // Right
    else if (keyboard_check(BTN_RIGHT)) {
        // Decelerate
        if (hor_speed < 0) {
            do_skid = true;
            hor_speed += decel;

            if (hor_speed >= 0) {
                hor_speed = 0.5;
            }
        }

        // Accelerate
        else {
            // Speed cap
            if (hor_speed < max_hor_speed) {
                hor_speed = min(hor_speed + accel, max_hor_speed);
            }

            // Change direction
            if (dir != RIGHT) {
                dir = RIGHT;
                if (is_grounded) {
                    state = st_normal;
                }
            }

            // Stop skidding
            if (state == st_skid) {
                state = st_normal;
            }
        }
    }
}

// Deceleration on slopes
if (is_grounded and angle > 35 and angle < 325) {
    if (state == st_roll) {
        hor_speed -= dsin(angle) * roll_decel;
    } else {
        hor_speed -= dsin(angle) * decel;
    }
}

// Apply friction
if (state == st_normal) {
    if (abs(hor_speed) > max_hor_speed or !keyboard_check(BTN_LEFT) and !keyboard_check(BTN_RIGHT)) {
        if (hor_speed > 0) {
            hor_speed = max(hor_speed - frict, 0);
        } else if (hor_speed < 0) {
            hor_speed = min(hor_speed + frict, 0);
        }
    }
} else if (state == st_roll) {
    if (hor_speed > 0) {
        hor_speed = max(hor_speed - roll_frict, 0);
    } else if (hor_speed < 0) {
        hor_speed = min(hor_speed + roll_frict, 0);
    }
}

// Stop when we're colliding a wall
if ((hor_speed > 0 and player_collision_right(pos_x, pos_y, angle, spr_mask_big))
    or (hor_speed < 0 and player_collision_left(pos_x, pos_y, angle, spr_mask_big))) {
    hor_speed = 0;
}

// Collide with ceiling
if (ver_speed < 0 and player_collision_top(pos_x, pos_y, angle, spr_mask_big)) {
    ver_speed = 0;
}

// Check if the player is landing
if (is_grounded) {
    ver_speed = 0;
    
    // Return to idle if jumping
    if (state == st_jump or state == st_fall) {
        state = st_normal;
    } else if (state == st_hurt) {
        hor_speed = 0;
        state = st_normal;
    }
} else if (state == st_normal) {
    state = st_fall;
}

// Jump
if (keyboard_check(BTN_JUMP) and is_grounded and (state == st_normal or state == st_roll)) {
    state = st_jump;
    is_grounded = false;
    ver_speed = dcos(angle) * jump_height - dsin(angle) * hor_speed;
    hor_speed = dcos(angle) * hor_speed + dsin(angle) * jump_height;
    angle = 0;
    audio_play(snd_player_jump);
}

// Jump the minimum height
if (keyboard_check_released(BTN_JUMP) and (ver_speed < min_jump_height) and (state == st_jump)) {
    ver_speed = min_jump_height;
}

// Duck
if (is_grounded and keyboard_check_pressed(BTN_DOWN) and (state == st_normal or state == st_jump)) {
    if (hor_speed == 0) {
        state = st_duck;
    } else {
        state = st_roll;
        audio_play(snd_player_roll);
    }
} 

if (state == st_duck) {
    // Start spindash
    if (keyboard_check(BTN_JUMP)) {
        hor_speed = 0;
        spindash_charge = 0;
        state = st_spindash;
    } 
    
    // Stop ducking
    else if (keyboard_check_released(BTN_DOWN)) {
        state = st_normal;
    }
}

// Spindash
if (state == st_spindash) {
    if (keyboard_check(BTN_DOWN)) {
        if (keyboard_check_pressed(BTN_JUMP)) {
            spindash_charge = min(spindash_charge + 2, 8);
            audio_play(snd_player_spindash_charge);
            effect_create_below(ef_smoke, pos_x - (17 * dir), pos_y + 6, 0.025, c_gray);
        } else {
            spindash_charge -= floor(spindash_charge / 0.125) / 256;
        }
    } else {
        state = st_roll;
        sound_stop(snd_player_spindash_charge);
        sound_play(snd_player_spindash_release);
        spindash_speed = (6 + round(spindash_charge) / 2) * dir;
        hor_speed = spindash_speed * dcos(angle);
        ver_speed = spindash_speed * -dsin(angle);
    }
}

// Stop rolling
if (is_grounded and state == st_roll and abs(hor_speed) < 0.5) {
    state = st_normal;
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Position
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Remember last position
prev_pos_x = pos_x;
prev_pos_y = pos_y;

// Increase vertical speed while airborne
if (!is_grounded) {
    ver_speed += grv;
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Animations
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Variables
var moving_speed;

// State machine
switch (state) {
    case st_normal:
        moving_speed = abs(hor_speed);
        if (moving_speed > 0) {
            sprite_index = spr_sonic_walk;
            image_speed = moving_speed / 20;
        } else {
            sprite_index = spr_sonic_idle;
            image_speed = 0.2;
        }
        break;
    case st_jump:
        sprite_index = spr_sonic_spinball;
        image_speed = 0.3;
        break;
    case st_duck:
        sprite_index = spr_sonic_duck;
        image_speed = 0;
        break;
    case st_roll:
        sprite_index = spr_sonic_spinball;
        moving_speed = abs(hor_speed);
        if (moving_speed > 3) {
            image_speed = moving_speed / 20;
        } else {
            image_speed = 0.2;
        }
        break;
    case st_hurt:
        sprite_index = spr_sonic_hurt;
        image_speed = 0;
        break;
    case st_fall:
        sprite_index = spr_sonic_fall;
        image_speed = 0;
        break;
    case st_spindash:
        sprite_index = spr_sonic_spindash;
        image_speed = 0.5;
        break;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Prepare parameters
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Prepare parameters
x = floor(pos_x);
y = floor(pos_y);
image_angle = angle;
image_alpha = opacity;
image_xscale = dir;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Draw object
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=500
invert=0
*/
