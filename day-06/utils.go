package day6

import "strings"

func Parse(input string) (ret [][]rune, initX int, initY int) {
	for y, line := range strings.Split(input, "\n") {
		var outl []rune
		for x, char := range line {
			outl = append(outl, char)
			if char == '^' {
				initX = x
				initY = y
			}
		}
		if len(outl) != 0 {
			ret = append(ret, outl)
		}
	}
	return
}
