package day6_test

import (
	"log"
	"os"
	"testing"

	"github.com/aster-void/advent-of-code-2024/day6"
)

func TestPart1(t *testing.T) {
	f, err := os.ReadFile("./inputs/test.txt")
	if err != nil {
		log.Fatalln(err)
	}
	field, x, y := day6.Parse(string(f))
	var got = day6.Part1(field, x, y)
	if got != 41 {
		t.Error("Part1: Expected 41, but got", got)
	}
}
func TestPart2(t *testing.T) {
	f, err := os.ReadFile("./inputs/test.txt")
	if err != nil {
		log.Fatalln(err)
	}
	field, x, y := day6.Parse(string(f))
	var got = day6.Part2(field, x, y)
	if got != 6 {
		t.Error("Part2: Expected 6, but got", got)
	}
}
