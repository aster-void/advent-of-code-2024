#include <sstream>
#include <string>
#include <algorithm>
#include <vector>

using namespace std;

vector<string> parse(string s) {
  vector<string> chars = vector<string>();
  std::istringstream src(s);
  std::string dest;
  while (std::getline(src, dest)) {
    chars.push_back(dest);
  }
  return chars;
}

int step2(string s) {
  int width = s.find("\n");
  int height = std::count(s.begin(), s.end(), '\n');
  vector<string> chars = parse(s);
  int ret = 0;
  for (int x = 1; x < width - 1; x++) {
    for (int y = 1; y < height - 1; y++) {
      if (chars.at(y).at(x) != 'A') continue;
      bool ok = false;
      if (chars.at(y - 1).at(x - 1) == 'M' && chars.at(y + 1).at(x + 1) == 'S') ok = true;
      if (chars.at(y - 1).at(x - 1) == 'S' && chars.at(y + 1).at(x + 1) == 'M') ok = true;
      if (!ok) continue;

      ok = false;
      if (chars.at(y + 1).at(x - 1) == 'M' && chars.at(y - 1).at(x + 1) == 'S') ok = true;
      if (chars.at(y + 1).at(x - 1) == 'S' && chars.at(y - 1).at(x + 1) == 'M') ok = true;
      if (!ok) continue;

      ret++;
    }
  }
  return ret;
}

int step1(string s) {
  int width = s.find("\n");
  int height = std::count(s.begin(), s.end(), '\n');
  vector<string> chars = parse(s);

  int ret = 0;
  const vector<char> match_str = {'X', 'M', 'A', 'S'};
  // vertical
  for (int x = 0; x < width; x++) for (int y = 0; y < height - 3; y++) {
    int straight = 1;
    int rev = 1;
    for (int d = 0; d < 4; d++) {
      if (chars.at(y + d).at(x) != match_str.at(d)) straight = false;
      if (chars.at(y + d).at(x) != match_str.at(3 - d)) rev = false;
    }
    if (straight) ret++;
    if (rev) ret++;
  }
  // horizonal
  for (int x = 0; x < width - 3; x++) for (int y = 0; y < height; y++) {
    int straight = 1;
    int rev = 1;
    for (int d = 0; d < 4; d++) {
      if (chars.at(y).at(x + d) != match_str.at(d)) straight = 0;
      if (chars.at(y).at(x + d) != match_str.at(3 - d)) rev = 0;
    }
    if (straight) ret++;
    if (rev) ret++;
  }
  // diag: right -> down
  for (int x = 0; x < width - 3; x++) for (int y = 0; y < height - 3; y++) {
    int straight = 1;
    int rev = 1;
    for (int d = 0; d < 4; d++) {
      if (chars.at(y + d).at(x + d) != match_str.at(d)) straight = 0;
      if (chars.at(y + d).at(x + d) != match_str.at(3 - d)) rev = 0;
    }
    if (straight) ret++;
    if (rev) ret++;
  }
  // diag: right -> up
  for (int x = 0; x < width - 3; x++) for (int y = 3; y < height; y++) {
    int straight = 1;
    int rev = 1;
    for (int d = 0; d < 4; d++) {
      if (chars.at(y - d).at(x + d) != match_str.at(d)) straight = 0;
      if (chars.at(y - d).at(x + d) != match_str.at(3 - d)) rev = 0;
    }
    if (straight) ret++;
    if (rev) ret++;
  }
  return ret;
}
