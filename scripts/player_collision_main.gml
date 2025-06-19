// Variables
var pos_x, pos_y, prev_mask, test_collision;
pos_x = argument0;
pos_y = argument1;

// Store the actual mask for setting it up later
prev_mask = mask_index;
mask_index = spr_mask_main;

// Test collision
test_collision = player_collision(floor(pos_x), floor(pos_y), plane);

// Set to the old mask
mask_index = prev_mask;

// Calculate the direction
return  test_collision;
