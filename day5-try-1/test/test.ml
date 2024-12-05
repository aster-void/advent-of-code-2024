let read_file path = In_channel.input_all (open_in path)


let () = 
  read_file "inputs/test.txt" 
  |> Day5.Lib.step1
  |> Int.to_string
  |> print_endline
