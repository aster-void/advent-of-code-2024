#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "./utils.c"

// consumes f.
int part1(FILE *f) {
  // todo: how should i determine the size at runtime?
  int first[1000];
  int second[1000];

  char* line = malloc(100);
  int linec = 0;

  while (fgets(line, 100, f)) {
    int a, b;
    sscanf(line, "%d %d", &a, &b);
    first[linec] = a;
    second[linec] = b;
    linec++;
    if (linec > 1000) {
      printf("File too large");
      exit(1);
    }
  }
  fclose(f);

  qsort(first, linec, sizeof(int), cmp_int);
  qsort(second, linec, sizeof(int), cmp_int);

  int ret = 0;
  for (int i = 0; i < linec; i++) {
    int diff = first[i] - second[i];
    ret += diff >= 0 ? diff : -diff;
  }
  return ret;
}

// consumes f
int part2(FILE *f) {
  // todo: how should i determine the size at runtime?
  int first[1000];
  int second[1000];

  char* line = malloc(100);
  int linec = 0;

  while (fgets(line, 100, f)) {
    int a, b;
    sscanf(line, "%d %d", &a, &b);
    first[linec] = a;
    second[linec] = b;
    linec++;
    if (linec > 1000) {
      printf("File too large");
      exit(1);
    }
  }
  fclose(f);

  int ret = 0;
  // it's possible to reduce this to O(n log n), but I'm not doing it in C
  for (int i = 0; i < linec; i++) {
    for (int j = 0; j < linec; j++) {
      if (first[i] == second[j]) {
        ret += first[i];
      }
    }
  }
  return ret;
}

int main(int argc, char **argv) {
  if (argc != 3) {
    fprintf(stderr, "Expected 2 arguments. example: `./a.out part1 inputs/test.txt`");
    return 1;
  }
  int result;
  FILE *fptr = fopen(argv[2], "r");
  if (fptr == NULL) {
    fprintf(stderr, "File not found");
    return 1;
  }
  if (str_eq(argv[1], "part1") || str_eq(argv[1], "1")) {
    fprintf(stderr, "Running part 1\n");
    result = part1(fptr);
  } else if (str_eq(argv[1], "part2") || str_eq(argv[1], "2")) {
    fprintf(stderr, "Running part 2\n");
    result = part2(fptr);
  }
  printf("%d", result);
  return 0;
}

