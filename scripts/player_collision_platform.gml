// Variables
var pos_x, pos_y, plane;
pos_x = argument0;
pos_y = argument1;
plane = argument2;

// Check for normal solid
if (place_meeting(pos_x, pos_y, obj_solid)) {
    return true;
}

// Check for platform
if (place_meeting(pos_x, pos_y, obj_platform)) {
    return true;
}

// Check for back layer
if (plane == 0) {
    return place_meeting(pos_x, pos_y, obj_back_solid);
}

// Check for front layer
else {
    return place_meeting(pos_x, pos_y, obj_front_solid);
}
