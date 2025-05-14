package model

const BoardSize = 19
const All = BoardSize * BoardSize
type Color int

const (
	Black Color = iota
	White
)

type Stone struct {
	Color Color `json:"color"`
	X int `json:"x"`
	Y int `json:"y"`
	Hash int64 `json:"hash"`
}

type Joseki struct {
	Stones []Stone `json:"stones"`
}

type Video struct {
	Id string `json:"id"`
}
