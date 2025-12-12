import { boardSize, type Stone } from "../models/model"

class Random {
  x: number
  y: number
  z: number
  w: number
  constructor(seed = 88675123) {
    this.x = 123456789
    this.y = 362436069
    this.z = 521288629
    this.w = seed
  }

  next(): number {
    let t = this.x ^ (this.x << 11)
    this.x = this.y
    this.y = this.z
    this.z = this.w
    return (this.w = this.w ^ (this.w >>> 19) ^ (t ^ (t >>> 8)))
  }

  nextInt(min: number, max: number): number {
    const r = Math.abs(this.next())
    return min + (r % (max + 1 - min))
  }
}

const generateTable = (): Array<Array<Array<number>>> => {
  const random = new Random()
  const table: Array<Array<Array<number>>> = []
  for (let i = 0; i < boardSize; i++) {
    const row: Array<Array<number>> = []
    for (let j = 0; j < boardSize; j++) {
      const col: Array<number> = []
      for (let k = 0; k < 2; k++) {
        col.push(
          (random.nextInt(0, 1 << 30) << 30) | random.nextInt(0, 1 << 30)
        )
      }
      row.push(col)
    }
    table.push(row)
  }
  return table
}

export const gobanHash = (
  captured: Array<Stone>,
  stone: Stone,
  originalHash: number
) => {
  const hashTable = generateTable()
  let hash = originalHash
  if (stone.color != "empty") {
    hash ^= hashTable[stone.x][stone.y][stone.color == "black" ? 0 : 1]
  }
  for (let i = 0; i < captured.length; i++) {
    const cap = captured[i]
    if (cap.color != "empty") {
      hash ^= hashTable[cap.x][cap.y][cap.color == "black" ? 0 : 1]
    }
  }
  return hash
}
