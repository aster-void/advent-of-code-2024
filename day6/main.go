package day6

import (
	"fmt"
)

func printRunes(field [][]rune) {
	for _, line := range field {
		var print string
		for _, char := range line {
			print += string(char)
		}
		fmt.Println(print)
	}
}

func Part1(field [][]rune, x int, y int) int {
	height, width := len(field), len(field[0])
	facingX, facingY := 0, -1
	for {
		field[y][x] = 'X'
		nextX := x + facingX
		nextY := y + facingY
		if nextX < 0 || nextX >= width {
			break
		}
		if nextY < 0 || nextY >= height {
			break
		}
		if field[nextY][nextX] == '#' {
			facingX, facingY = -facingY, facingX
		} else {
			x = nextX
			y = nextY
		}
	}

	var ret int
	for _, line := range field {
		for _, char := range line {
			if char == 'X' {
				ret++
			}
		}
	}
	printRunes(field)
	return ret
}

func Part2(field [][]rune, x, y int) int {
	height, width := len(field), len(field[0])
	var limit = height * width * 4
	var total int
	for placeY := range height {
		for placeX := range width {
			prev := field[placeY][placeX]
			field[placeY][placeX] = '#'
			if !GuardTerminatesWithin(field, x, y, limit) {
				total++
			}
			field[placeY][placeX] = prev
		}
	}
	return total
}

func GuardTerminatesWithin(field [][]rune, initX int, initY int, limit int) bool {
	x, y := initX, initY
	height, width := len(field), len(field[0])
	facingX, facingY := 0, -1
	steps := 0
	for {
		steps++
		if steps > limit {
			return false
		}
		nextX := x + facingX
		nextY := y + facingY
		if nextX < 0 || nextX >= width {
			return true
		}
		if nextY < 0 || nextY >= height {
			return true
		}
		if field[nextY][nextX] == '#' {
			facingX, facingY = -facingY, facingX
		} else {
			x = nextX
			y = nextY
		}
	}
}
