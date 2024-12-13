using System.Runtime.CompilerServices;

await part1("./inputs/test.txt");

async Task part1(string path)
{
  string input = await File.ReadAllTextAsync(path);
  var parsed = Parse(input);
  Console.WriteLine(parsed.Length.ToString());
}

Entry[] Parse(string input)
{
  string[] entries = input.Split("\n\n");
  var parsed = (
    from entry in entries
    select Entry.Parse(entry)
  ).ToArray();
  return parsed;
}

struct Entry
{
  int A_X;
  int A_Y;
  int B_X;
  int B_Y;
  int PrizeX;
  int PrizeY;
  public static Entry Parse(string lines)
  {
    char[] trimChars = "ButtonABPrize :+XY=".ToCharArray();
    string[] lines_ = lines.Split("\n");
    string[] lineA = lines_[0].Split(",");
    string[] lineB = lines_[1].Split(",");
    string[] linePrize = lines_[2].Split(",");
    var e = new Entry();
    e.A_X = Int32.Parse(lineA[0].Trim(trimChars));
    e.A_Y = Int32.Parse(lineA[1].Trim(trimChars));
    e.B_X = Int32.Parse(lineB[0].Trim(trimChars));
    e.B_Y = Int32.Parse(lineB[1].Trim(trimChars));
    e.PrizeX = Int32.Parse(linePrize[0].Trim(trimChars));
    e.PrizeY = Int32.Parse(linePrize[1].Trim(trimChars));
    return e;
  }
}
