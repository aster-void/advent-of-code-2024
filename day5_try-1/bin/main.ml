let read_file path = In_channel.input_all (open_in path)

let () = 
  let func = match Sys.argv.(1) with
  | "1" -> Day5.Lib.step1
  | "2" -> Day5.Lib.step2
  | _ -> raise (Invalid_argument "invalid argument") in

  Sys.argv.(2)
  |> read_file
  |> func
  |> Int.to_string
  |> print_endline
