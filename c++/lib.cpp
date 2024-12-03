#include <string>

using namespace std;

int transform(string s) {
  int ret = 0;
  for (char ch : s) {
    if (ch == 'o') ret++;
  }
  return ret;
}
