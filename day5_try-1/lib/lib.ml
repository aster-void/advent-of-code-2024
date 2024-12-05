let inspect v =
    let () = print_endline ("\"" ^ v ^ "\"") in
    v
let inspect_it fn v =
  let print = fn v in
  let _ = inspect print in
  v

let separate s =
  let lines = s 
  |> String.split_on_char '\n' in
  let split_index = lines |> List.find_index (fun x -> String.equal x "") in
  match split_index with 
  | None -> raise (Invalid_argument "Empty line not found")
  | Some index -> 
    let first_part = lines |> List.to_seq |> Seq.take index |> List.of_seq in
    let second_part = lines |> List.to_seq |> Seq.drop (index + 1) |> List.of_seq in
    (first_part, second_part)

module M = Map.Make (Int)
let parse_first s = 
  s
  |> List.to_seq
  |> Seq.filter (fun line -> line != "")
  |> Seq.map (fun line -> match line |> String.split_on_char '|' with
    | [before; after] -> (int_of_string after, int_of_string before) (* after -> before *)
    | _ -> raise (Invalid_argument "unmatched count")
  )
  |> M.of_seq (* after -> before *)
let parse_second list = 
  list
  |> List.filter ((<>) "")
  |> List.map (String.split_on_char ',')
  |> List.map (List.map int_of_string)

let line_ok rules line =
  let rec line_ok_rec = function
    | [] -> true
    | top :: rest -> 
      match rules |> M.find_opt top with
      | Some requirement -> rest |> List.exists ((=) requirement)
      | None -> true
      && (line_ok_rec rest)
  in
  List.rev line
  |> line_ok_rec

let step1 s = 
  let (first, second) = separate s in 
  let rules = parse_first first in
  let second = parse_second second in
  second
  |> List.filter (line_ok rules)
  |> List.map (inspect_it (fun x -> x |> List.map string_of_int |> String.concat ","))
  |> Fun.const 0
let step2 s = s |> String.length
