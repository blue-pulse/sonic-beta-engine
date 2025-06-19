var int, amount_zeros, int_as_string, zeros_left;
int = argument0;
amount_zeros = argument1;
int_as_string = string(int);
zeros_left = amount_zeros - string_length(int_as_string);

return string_repeat("0", zeros_left) + int_as_string;
