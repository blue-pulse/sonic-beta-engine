// Variables
var snd_index;
snd_index = argument0;

// Stop audio before playing it
if (sound_isplaying(snd_index)) {
    sound_stop(snd_index);
}
return sound_play(snd_index);
