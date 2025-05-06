package model

const BoardSize = 19
const All = 19 * 19
type Color int

const (
	Black Color = iota
	White
	Empty
)

type Stone struct {
	Color Color
	X int
	Y int
}

type Joseki struct {
	Id int64
	Stone Stone
	Parent int64
}
