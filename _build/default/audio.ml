type t = Sdlmixer.music

let _ =
  Sdl.init [ `AUDIO ];
  at_exit Sdl.quit;
  Sdlmixer.open_audio ();
  at_exit Sdlmixer.close_audio

let music = ref (Sdlmixer.load_music "./camlished.wav")

let set_music file = music := Sdlmixer.load_music file

let play_music () = Sdlmixer.play_music !music

let halt_music () =
  Sdlmixer.free_music !music;
  Sdlmixer.halt_music ()