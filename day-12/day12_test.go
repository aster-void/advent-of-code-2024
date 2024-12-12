package day12_test

import (
	"day12"
	"log"
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test_part1_Small(t *testing.T) {
	input := `
		AAAA
		BBCD
		BBCC
		EEEC`
	assert.Equal(t, 140, day12.Part1(input))
}

func Test_part1_SampleFile(t *testing.T) {
	f, err := os.ReadFile("./test.txt")
	if err != nil {
		log.Fatalln("Failed to open file: ./test.txt with reason:", err)
	}
	input := string(f)
	assert.Equal(t, 1930, day12.Part1(input))
}
func Test_part2_Small_ABCDE(t *testing.T) {
	input := `
		AAAA
		BBCD
		BBCC
		EEEC`
	assert.Equal(t, 80, day12.Part2(input))
}
func Test_part2_Small_XO(t *testing.T) {
	input := `
		OOOOO
		OXOXO
		OOOOO
		OXOXO
		OOOOO`
	assert.Equal(t, 436, day12.Part2(input))
}
func Test_part2_Small_Es(t *testing.T) {
	input := `
		EEEEE
		EXXXX
		EEEEE
		EXXXX
		EEEEE`
	assert.Equal(t, 236, day12.Part2(input))
}
func Test_part2_Small_AB(t *testing.T) {
	input := `
		AAAAAA
		AAABBA
		AAABBA
		ABBAAA
		ABBAAA
		AAAAAA`
	assert.Equal(t, 368, day12.Part2(input))
}
func Test_part2_SampleFile(t *testing.T) {
	f, err := os.ReadFile("./test.txt")
	if err != nil {
		log.Fatalln("Failed to open file: ./test.txt with reason:", err)
	}
	input := string(f)
	assert.Equal(t, 1206, day12.Part2(input))
}
