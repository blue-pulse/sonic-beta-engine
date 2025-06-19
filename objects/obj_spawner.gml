#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Spawn player
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Variables
var player, camera;

// Create player
player = instance_create(x, y, global.character);

// Create camera
camera = instance_create(x, y, obj_camera);
camera.target = player;

// Create controller
instance_create(0, 0, obj_stage_controller);

// Create HUD
instance_create(0, 0, obj_hud);
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=Destroy spawner
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=203
applies_to=self
invert=0
*/
