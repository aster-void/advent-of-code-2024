#include <fstream>
#include <iostream>
#include "./lib.cpp"

using namespace std;
int main(int argc, char **argv) {
  if (argc < 3) {
    cerr << "please provide step and path to the input e.g. `./a.out 1 inputs/test.txt`" << endl;
    return 1;
  }
  std::ifstream file(argv[2]);
  std::string line;
  std::string dst = "";
  while (std::getline(file, line)) {
    dst += line;
    dst += "\n";
  }
  int out;
  switch (argv[1][0]) {
    case '1':
      out = step1(dst);
      cerr << "result:" << endl;
      cout << out << endl;
      return 0;
    case '2':
      out = step2(dst);
      cerr << "result:" << endl;
      cout << out << endl;
      return 0;
    default:
      cerr << "unknown step, expected 1 or 2 but got " << argv[1];
      return 1;
  }
}
