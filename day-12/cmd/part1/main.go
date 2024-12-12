package main

import (
	"day12"
	"fmt"
	"log"
	"os"
)

func main() {
	if len(os.Args) != 2 {
		log.Fatalln("Usage: `go run ./cmd/part1 test.txt`")
	}
	file, err := os.ReadFile(os.Args[1])
	if err != nil {
		log.Fatalln("File not found")
	}
	s := string(file)
	fmt.Println(day12.Part1(s))
}
