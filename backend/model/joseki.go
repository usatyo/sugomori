package model

const BoardSize = 19
const All = BoardSize * BoardSize

type Color int

const (
	Black Color = iota
	White
)

func InversedColor(c Color) Color {
	if c == Black {
		return White
	}
	return Black
}

type Stone struct {
	Color Color
	X     int
	Y     int
	Hash  int64
}

type Joseki struct {
	Stones []Stone
}

type Video struct {
	Id string
}
