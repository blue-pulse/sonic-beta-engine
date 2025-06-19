// Variables
var pos_x, pos_y, angle, mask, prev_mask, test_collision;
pos_x = argument0;
pos_y = argument1;
angle = argument2;
mask = argument3;

// Store the actual mask for setting it up later
prev_mask = mask_index;
mask_index = mask;

// Test collision
test_collision = player_collision(floor(pos_x + dsin(angle) * 11), floor(pos_y + dcos(angle) * 11), plane);

// Check for collision within platform
if (!test_collision and !is_grounded and ver_speed >= 0) {
    test_collision = place_meeting(floor(pos_x + dsin(angle) * 11), floor(pos_y + dcos(angle) * 11), obj_platform)
                        and
                        !place_meeting(floor(pos_x), floor(pos_y), obj_platform);
}

// Set to the old mask
mask_index = prev_mask;

// Calculate the direction
return  test_collision;
