(* an abstract type representing a dungeon*)
type t

(* [instantiate_dungeon x y] is a dungeon with [x] columns [y] rows *)
val instantiate_dungeon : int -> int -> t

(* [is_wall dungeon (x, y)] returns true iff the cell at coordinate [(x, y)] is a wall in [dungeon] *)
val is_wall : t -> (int*int) -> bool

(* [get_start dungeon] is the coordinates of the starting tile in [dungeon]*)
val get_start : t -> (int*int)

(* [get_exit dungeon] is the coordinates of the exit tile in [dungeon]*)
val get_exit : t -> (int*int)