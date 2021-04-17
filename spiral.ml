type direction =
  | Up
  | Down
  | Right
  | Left

let rec turner cur_x cur_y dir end_x end_y table =
  Render.render_square
    (Render.new_square
       (float_of_int (cur_x / Magic_numbers.x_length * 2))
       (float_of_int (cur_y / Magic_numbers.y_length * 2))
       Magic_numbers.width Magic_numbers.height "./path.png");
  Hashtbl.add table (cur_x, cur_y) true;
  if cur_x = end_x && cur_y = end_y then ()
  else
    (* pause for a little while*)
    match dir with
    | Right ->
        if Hashtbl.find table (cur_x, cur_y - 1) = false then
          turner cur_x (cur_y - 1) Down end_x end_y table
        else turner (cur_x + 1) cur_y Right end_x end_y table
    | Down ->
        if Hashtbl.find table (cur_x - 1, cur_y) = false then
          turner (cur_x - 1) cur_y Left end_x end_y table
        else turner cur_x (cur_y - 1) Down end_x end_y table
    | Left ->
        if Hashtbl.find table (cur_x, cur_y + 1) = false then
          turner cur_x (cur_y + 1) Up end_x end_y table
        else turner (cur_x - 1) cur_y Left end_x end_y table
    | Up ->
        if Hashtbl.find table (cur_x + 1, cur_y) = false then
          turner (cur_x + 1) cur_y Right end_x end_y table
        else turner cur_x (cur_y + 1) Up end_x end_y table

let render_spiral =
  let middle_x = (Magic_numbers.x_length - 1) / 2 in
  let middle_y = (Magic_numbers.y_length - 1) / 2 in
  let spiral_table =
    Hashtbl.create (Magic_numbers.x_length * Magic_numbers.y_length)
  in
  turner middle_x middle_y Right
    (Magic_numbers.x_length - 1)
    (Magic_numbers.y_length - 1)
    spiral_table