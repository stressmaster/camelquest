type square = {
  mutable square_x : float;
  mutable square_y : float;
  mutable width : float;
  mutable height : float;
  mutable texture : string;
}

let current_flashes = ref 0

let max_flashes = ref 0

let new_square x y w h t =
  { square_x = x; square_y = y; width = w; height = h; texture = t }

let renderAt ~x ~y ~width ~height ~texture =
  GlMat.load_identity ();
  GlMat.translate3 (x, y, 0.);
  Texturemap.set_texture texture;
  GlDraw.begins `quads;
  GlTex.coord2 (0.0, 0.0);
  GlDraw.vertex2 (0., 0.);
  GlTex.coord2 (0.0, 1.0);
  GlDraw.vertex2 (0., height -. 1.);
  GlTex.coord2 (1.0, 1.0);
  GlDraw.vertex2 (width -. 1., height -. 1.);
  GlTex.coord2 (1.0, 0.0);
  GlDraw.vertex2 (width -. 1., 0.);
  Texturemap.end_texture ();
  GlDraw.ends ()

let render_square ~square =
  renderAt ~x:square.square_x ~y:square.square_y ~width:square.width
    ~height:square.height ~texture:square.texture

(* let rec flash t1 t sq1 sq2 f = if t > f then Render_stack.stack_pop
   () else if t1 = t then () else if t / 2 mod 2 = 0 then (
   render_square sq1; flash (t1 + 1) t sq1 sq2 f) else ( render_square
   sq2; flash (t1 + 1) t sq1 sq2 f) *)

let rec flash t1 t sq1 sq2 =
  if current_flashes > max_flashes then (
    current_flashes := 0;
    Render_stack.stack_pop ())
  else if t1 = t then (
    current_flashes := !current_flashes + 1;
    ())
  else if t / 2 mod 2 = 0 then (
    render_square sq1;
    flash (t1 + 1) t sq1 sq2)
  else (
    render_square sq2;
    flash (t1 + 1) t sq1 sq2)

let render_square_flashes square1 square2 flashes =
  max_flashes := flashes;
  let time = Timer.current_time () in
  flash 0 time square1 square2
