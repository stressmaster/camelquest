(*mutable spiraled : bool; mutable action : action; mutable attacking :
  bool; mutable monster : Dungeon.monster; mutable monster_string :
  string; mutable input_string : string;*)

(*({ spiraled; action; attacking : bool; monster : Dungeon.monster;
  monster_string : string; input_string : string; } : State.fight)*)

let render_menu (fight : State.fight) =
  if not (fight.monster_health = 0) then begin
    Render.render_square
      (Render.new_square
         (1. /. float_of_int 3 *. 2.)
         (1.25 /. float_of_int 3 *. 2.)
         (Magic_numbers.width *. 4.)
         (Magic_numbers.height *. 4.)
         fight.monster.sprite);
    if fight.attacking then
      Font.render_font
        (Font.new_font fight.monster_string 0. 0.3 Magic_numbers.width
           Magic_numbers.height);
    Font.render_font
      (Font.new_font fight.input_string 0. 0.1 Magic_numbers.width
         Magic_numbers.height);
    Font.render_font
      (Font.new_font
         ("hp " ^ string_of_int fight.monster_health)
         0.8 1.6 Magic_numbers.width Magic_numbers.height);
    Font.render_font
      (Font.new_font
         ("hp " ^ string_of_int fight.player_health)
         0.1 0.6 Magic_numbers.width Magic_numbers.height);
    if not fight.attacking then (
      Font.render_font
        (Font.new_font "fight" 0.1 0.2 Magic_numbers.width
           Magic_numbers.height);
      Font.render_font
        (Font.new_font "heal" 0.88 0.2 Magic_numbers.width
           Magic_numbers.height);
      Font.render_font
        (Font.new_font "run" 1.6 0.2 Magic_numbers.width
           Magic_numbers.height);
      match fight.action with
      | Attack ->
          Font.render_font
            (Font.new_font ">" 0. 0.2 Magic_numbers.width
               Magic_numbers.height)
      | Recover ->
          Font.render_font
            (Font.new_font ">" 0.78 0.2 Magic_numbers.width
               Magic_numbers.height)
      | Run ->
          Font.render_font
            (Font.new_font ">" 1.5 0.2 Magic_numbers.width
               Magic_numbers.height))
  end
  else
    Font.render_font
      (Font.new_font "you win" 0.6 1. Magic_numbers.width
         Magic_numbers.height)
