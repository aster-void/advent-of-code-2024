package day12

import (
	// "fmt"
	"log"
	"strings"
)

func Part1(input string) int {
	return solve(input, 1)
}
func Part2(input string) int {
	return solve(input, 2)
}

func solve(input string, part int) int {
	if part != 1 && part != 2 {
		log.Fatalln("Unknown part: expected 1 or 2, got", part)
	}
	field := parse(input)
	w, h := field.Size()

	var checked [][]bool
	for range h {
		checked = append(checked, make([]bool, w))
	}

	found, c := findUnchecked(checked)
	var regions [][]Coord
	for found {
		var region = []Coord{c}
		var char = *field.At(c)
		checked[c.y][c.x] = true
		for i := 0; i < len(region); i++ {
			point := region[i]

			for _, delta := range perim_deltas {
				check := Coord{
					x: point.x + delta.x,
					y: point.y + delta.y,
				}
				if field.At(check) != nil && *field.At(check) == char {
					var first_occur = true
					for _, pt := range region {
						if pt.x == check.x && pt.y == check.y {
							first_occur = false
							break
						}
					}
					if first_occur {
						region = append(region, check)
						checked[check.y][check.x] = true
					}
				}
			}
		}

		regions = append(regions, region)
		found, c = findUnchecked(checked)
	}

	var total = 0
	for _, region := range regions {
		var total_perim = 0
		var corners = 0
		char := *field.At(region[0])
		for _, coord := range region {
			var perim = 0
			// part1 check
			for _, delta := range perim_deltas {
				check := Coord{
					x: coord.x + delta.x,
					y: coord.y + delta.y,
				}
				if field.At(check) == nil || *field.At(check) != char {
					perim += 1
				}
			}
			total_perim += perim
			// part2 check
			// 90 degree Corner, pointing outwards (2 if perim = 3)
			for i, delta := range perim_deltas {
				var next_delta = perim_deltas[(i+1)%4]
				check := Coord{
					x: coord.x + delta.x,
					y: coord.y + delta.y,
				}
				next := Coord{
					x: coord.x + next_delta.x,
					y: coord.y + next_delta.y,
				}
				if (field.At(check) == nil || *field.At(check) != char) &&
					(field.At(next) == nil || *field.At(next) != char) {
					// aab
					// aAb
					// bbb
					corners += 1
				}
			}
			// 270 degree Corner, pointing inwards (2 if perim = 3)
			for _, delta := range corner_deltas {
				check := Coord{
					x: coord.x + delta.x,
					y: coord.y + delta.y,
				}
				if field.At(check) == nil {
					continue
				}
				if *field.At(check) != char {
					if *field.At(Coord{
						x: coord.x + delta.x,
						y: coord.y,
					}) != char {
						// normal perim e.g.
						// aaa
						// a*a
						// bbB
						continue
					}
					if *field.At(Coord{
						x: coord.x,
						y: coord.y + delta.y,
					}) != char {
						// normal perim
						// aab
						// a*b
						// aaB
						continue
					}
					// aaa
					// a*a
					// aaB
					corners += 1
				}
			}
		}
		var area = len(region)
		if part == 1 {
			total += total_perim * area
		} else if part == 2 {
			total += corners * area
		}
	}

	return total
}

var perim_deltas = []Coord{
	{x: 1, y: 0},
	{x: 0, y: 1},
	{x: -1, y: 0},
	{x: 0, y: -1},
}
var corner_deltas = []Coord{
	{x: 1, y: 1},
	{x: -1, y: 1},
	{x: 1, y: -1},
	{x: -1, y: -1},
}

func findUnchecked(checked [][]bool) (found bool, c Coord) {
	for y, row := range checked {
		for x, checked := range row {
			if !checked {
				return true, Coord{x, y}
			}
		}
	}
	return false, Coord{}
}
func parse(input string) Field[rune] {
	var ret [][]rune
	for _, line := range strings.Split(input, "\n") {
		line = strings.TrimSpace(line)
		if line == "" {
			continue
		}
		var ln []rune
		for _, ch := range line {
			ln = append(ln, ch)
		}
		ret = append(ret, ln)
	}
	return Field[rune]{
		inner: ret,
	}
}
