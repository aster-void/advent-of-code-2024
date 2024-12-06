#include <string.h>

int cmp_int (const void * elem1, const void * elem2) {
    int f = *((int*)elem1);
    int s = *((int*)elem2);
    if (f > s) return  1;
    if (f < s) return -1;
    return 0;
}

int str_eq(char* str1, char* str2) {
  return !strcmp(str1, str2);
}
