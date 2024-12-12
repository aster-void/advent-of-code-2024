package day12_test

import (
	"day12"
	"log"
	"os"
	"testing"
)

func Test_part1_Small(t *testing.T) {
	input := `
		AAAA
		BBCD
		BBCC
		EEEC`
	if got := day12.Part1(input); got != 140 {
		t.Error("Expected 140, but got ", got)
	}
}

func Test_part1_SampleFile(t *testing.T) {
	f, err := os.ReadFile("./test.txt")
	if err != nil {
		log.Fatalln("Failed to open file: ./test.txt with reason:", err)
	}
	input := string(f)
	if got := day12.Part1(input); got != 1930 {
		t.Error("Expected 1930, but got ", got)
	}
}
func Test_part2_Small_ABCDE(t *testing.T) {
	input := `
		AAAA
		BBCD
		BBCC
		EEEC`
	if got := day12.Part2(input); got != 80 {
		t.Error("Expected 80, but got ", got)
	}
}
func Test_part2_Small_XO(t *testing.T) {
	input := `
	OOOOO
	OXOXO
	OOOOO
	OXOXO
	OOOOO
`
	if got := day12.Part2(input); got != 436 {
		t.Error("Expected 436, but got ", got)
	}
}
func Test_part2_Small_Es(t *testing.T) {
	input := `
	EEEEE
	EXXXX
	EEEEE
	EXXXX
	EEEEE
`
	if got := day12.Part2(input); got != 236 {
		t.Error("Expected 236, but got ", got)
	}
}
func Test_part2_Small_AB(t *testing.T) {
	input := `
	AAAAAA
	AAABBA
	AAABBA
	ABBAAA
	ABBAAA
	AAAAAA
	`
	if got := day12.Part2(input); got != 368 {
		t.Error("Expected 368, but got ", got)
	}
}
func Test_part2_SampleFile(t *testing.T) {
	f, err := os.ReadFile("./test.txt")
	if err != nil {
		log.Fatalln("Failed to open file: ./test.txt with reason:", err)
	}
	input := string(f)
	if got := day12.Part2(input); got != 1206 {
		t.Error("Expected 1206, but got ", got)
	}
}
