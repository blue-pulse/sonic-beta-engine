// Variables
var pos_x, pos_y, angle, mask, prev_mask, prev_sprite, prev_image, test_collision;
pos_x = argument0;
pos_y = argument1;
angle = argument2;

// Store the actual values for setting it up later
prev_mask = mask_index;
prev_sprite = sprite_index;
prev_image = image_index;

mask_index = spr_mask_line;
sprite_index = spr_mask_line;
image_index = floor(angle);

// Test collision
test_collision = player_collision_platform(floor(pos_x + dcos(angle) * 8 + dsin(angle) * 11),
                                            floor(pos_y - dsin(angle) * 8 + dcos(angle) * 11),
                                            plane);

// Set to the old values
mask_index = prev_mask
sprite_index = prev_sprite
image_index = prev_image;

// Calculate the direction
return  test_collision;
