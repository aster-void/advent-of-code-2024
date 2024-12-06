package main

import (
	"fmt"
	"log"
	"os"

	"github.com/aster-void/advent-of-code-2024/day6"
)

func main() {
	if len(os.Args) != 2 {
		log.Fatalln("Use the cli like this: go run ./cmd/part1 inputs/test.txt")
	}
	file := os.Args[1]
	content, err := os.ReadFile(file)
	if err != nil {
		log.Fatalln(err)
	}

	var input, x, y = day6.Parse(string(content))
	result := day6.Part1(input, x, y)
	fmt.Println(result)
}
