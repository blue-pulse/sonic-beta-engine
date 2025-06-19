// Variables
var pos_x, pos_y, angle, prev_mask, pos_x_1, pos_y_1, pos_x_2, pos_y_2;
pos_x = argument0;
pos_y = argument1;
angle = argument2;
prev_mask = mask_index;

// Set new mask index
mask_index = spr_mask_dot;

// Limit the angle we're using from 360 directions to 36 for preventing thikering
angle = round(angle / 10) * 10;

// Set the starting position of the left sensors
pos_x_1 = pos_x - dcos(angle) * 7;
pos_y_1 = pos_y + dsin(angle) * 7;

// Set the starting position of the right sensors
pos_x_2 = pos_x + dcos(angle) * 7;
pos_y_2 = pos_y - dsin(angle) * 7;

// Now, perform the checking. Push down the two points in order to know the angle
repeat(25) {
    if (player_collision(floor(pos_x_1), floor(pos_y_1), plane) == false) {
        pos_x_1 += dsin(angle);
        pos_y_1 += dcos(angle);
    }
    
    if (player_collision(floor(pos_x_2), floor(pos_y_2), plane) == false) {
        pos_x_2 += dsin(angle);
        pos_y_2 += dcos(angle);
    }
}

// Return to the old mask
mask_index = prev_mask;

// Calculate the direction
return floor(point_direction(pos_x_1, pos_y_1, pos_x_2, pos_y_2));
