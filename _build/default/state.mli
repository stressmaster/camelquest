(* abstract type representing current player location *)
type current

(* [init_state] assigns player to starting location in dungeon *)
val init_state : Dungeon.t -> current

(* [player_loc] returns cords of current player location *)
val player_loc : current -> int * int

(* [move] updates player location *)
val move : current -> Glut.special_key_t -> current
