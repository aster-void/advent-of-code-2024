package day12

type Coord struct {
	x int
	y int
}
type Field[T any] struct {
	inner [][]T
}

func (f Field[T]) At(c Coord) (found *T) {
	if c.y < 0 || c.y >= len(f.inner) {
		return nil
	}
	if c.x < 0 || c.x >= len(f.inner[0]) {
		return nil
	}
	return &f.inner[c.y][c.x]
}
func (field Field[T]) Size() (w int, h int) {
	h, w = len(field.inner), len(field.inner[0])
	return
}
