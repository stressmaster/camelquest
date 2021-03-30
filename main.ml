type square = {
  mutable x : float;
  mutable y : float;
  mutable width : float;
  mutable height : float;
}

type tile_sprite = string

type color =
  | Green
  | Gray

type material =
  | Color of color
  | Sprite of tile_sprite

let w = 500

and h = 500

let square_height ~height = float_of_int h /. height

let renderAt ~x ~y ~width ~height ~rgb =
  GlMat.load_identity ();
  GlMat.translate3 (x, y, 0.);
  let r, g, b = rgb in
  GlDraw.color (r, g, b);
  GlDraw.begins `quads;
  List.iter GlDraw.vertex2
    [
      (0., 0.);
      (0., height -. 1.);
      (width -. 1., height -. 1.);
      (width -. 1., 0.);
    ];
  GlDraw.ends ()

let render_square ~square =
  renderAt ~x:square.x ~y:square.y ~width:square.width
    ~height:square.height

<<<<<<< HEAD
let determine_color tile =
  let material = tile |> Dungeon.tile_material in
  match material with
  | Sprite s -> if s = "wall.jpg" then (0., 1., 0.) else (1., 1., 1.)
  | Color c -> if c = Green then (0., 1., 0.) else (0.5, 0.5, 0.5)

let render_dungeon (dungeon : Dungeon.t) (player : int * int) =
  let dungeon_cells = dungeon |> Dungeon.get_cells in
=======
let render_dungeon (dungeon : Dungeon.t) =
>>>>>>> c6c9349ab729684cf22b71524eebafc48476d8f1
  let x_length = dungeon |> Dungeon.get_dimensions |> fst in
  let y_length = dungeon |> Dungeon.get_dimensions |> snd in
  let width = float_of_int w /. float_of_int x_length in
  let height = float_of_int h /. float_of_int y_length in
  Hashtbl.iter
    (fun (x, y) cell ->
<<<<<<< HEAD
      if (x, y) = player then
        render_square
          {
            x = float_of_int x /. float_of_int x_length *. 2.;
            y = float_of_int y /. float_of_int y_length *. 2.;
            width;
            height;
          }
          (0., 0., 1.)
      else
        render_square
          {
            x = float_of_int x /. float_of_int x_length *. 2.;
            y = float_of_int y /. float_of_int y_length *. 2.;
            width;
            height;
          }
          determine_color (Hashtbl.find dungeon_cells (x, y)).tile)
    dungeon_cells
=======
      render_square
        {
          x = float_of_int x /. float_of_int x_length *. 2.;
          y = float_of_int y /. float_of_int y_length *. 2.;
          width;
          height;
        }
        ( if Dungeon.is_wall dungeon (x, y) then (0., 1., 0.)
        else (1., 1., 1.) ))
    (dungeon |> Dungeon.get_cells)
>>>>>>> c6c9349ab729684cf22b71524eebafc48476d8f1

(*let render_dungeon (dungeon : Dungeon.t) = for i = 0 to dungeon |>
  Dungeon.get_dimensions |> fst do for j = 0 to dungeon |>
  Dungeon.get_dimensions |> snd do render_square { x = 1. /.
  float_of_int (dungeon |> Dungeon.get_dimensions |> fst) *.
  float_of_int i *. 2.; y = 1. /. float_of_int (dungeon |>
  Dungeon.get_dimensions |> snd) *. float_of_int j *. 2.; } (if
  Dungeon.is_wall dungeon (i, j) then (0., 1., 0.) else (1., 1., 1.))
  done done*)

let main () =
  ignore (Glut.init Sys.argv);
  Glut.initDisplayMode ~alpha:true ~depth:true ();
  Glut.initWindowSize ~w ~h;
  ignore (Glut.createWindow ~title:"fuck");
  Glut.displayFunc ~cb:(fun () ->
      GlClear.color (0.0, 0.0, 0.0);
      GlClear.clear [ `color ];
      GluMat.ortho2d ~x:(0.0, float_of_int w) ~y:(0.0, float_of_int h);
      GlMat.mode `projection;
      render_dungeon (Dungeon.instantiate_dungeon 10 10) (1, 1);
      Gl.flush ());
  Glut.keyboardFunc ~cb:(fun ~key ~x ~y -> if key = 27 then exit 0);
  (* Glut.idleFunc ~cb:(Some Glut.postRedisplay); *)
  Glut.mainLoop ()

let _ = main ()
