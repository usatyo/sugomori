package util

import (
	"github.com/usatyo/sugomori/model"
)

const mod = (1 << 61) - 1
const mask30 = (1 << 30) - 1
const mask31 = (1 << 31) -1
const base = 1000000007

func mul(a int64, b int64) int64 {
  var au int64 = a >> 31
  var ad int64 = a & mask31
  var bu int64 = b >> 31
  var bd int64 = b & mask31
  var mid int64 = ad * bu + au * bd
  var midu int64 = mid >> 30
  var midd int64 = mid & mask30
  return calcMod(au * bu * 2 + midu + (midd << 31) + ad * bd)
}

func calcMod(x int64) int64 {
  var xu int64 = x >> 61
  var xd int64 = x & mod
  var res int64 = xu + xd
  if res >= mod {res -= mod}
  return res
}

func JosekiHash(stone []model.Stone) []int64 {
	ret := make([]int64, len(stone) + 1)
	ret = append(ret, 0)
	var val int64 = 0
	var pow int64 = 1
	for _, s := range stone {
		if s.Color == model.Black {
			val += mul(pow, int64(s.X * model.BoardSize + s.Y + 1))
		} else if s.Color == model.White {
			val += mul(pow, int64(s.X * model.BoardSize + s.Y + model.All + 1))
		} else {
			val += mul(pow, int64(model.All * 2 + 1))
		}
		val = calcMod(val)
		ret = append(ret, val)
		pow = mul(pow, base)
	}
	return ret
}
