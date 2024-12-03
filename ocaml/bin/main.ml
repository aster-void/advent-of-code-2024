let content path = In_channel.input_all (open_in path)

let () = 
  Sys.argv.(1)
  |> content
  |> Ocaml.Lib.step1
  |> Int.to_string
  |> print_endline
