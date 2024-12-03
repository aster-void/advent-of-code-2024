let step1 s = s 
  |> String.to_seq
  |> Seq.filter ((=) 'o')
  |> Seq.length
