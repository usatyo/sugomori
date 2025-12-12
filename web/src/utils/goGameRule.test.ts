import { expect, test } from "vitest"
import { boardSize, type Stone } from "../models/model"
import { getCapturedStones } from "./goGameRule"

const initializeBoard = (): Array<Array<Stone>> => {
  const board: Array<Array<Stone>> = []
  for (let i = 0; i < boardSize; i++) {
    const row: Array<Stone> = []
    for (let j = 0; j < boardSize; j++) {
      row.push({ color: "empty", x: i, y: j, index: -1 })
    }
    board.push(row)
  }
  return board
}

test("self captured (single stone)", () => {
  const stoneMatrix: Array<Array<Stone>> = initializeBoard()
  stoneMatrix[0][1] = { color: "white", x: 0, y: 1, index: -1 }
  stoneMatrix[1][0] = { color: "white", x: 1, y: 0, index: -1 }
  stoneMatrix[1][2] = { color: "white", x: 1, y: 2, index: -1 }
  stoneMatrix[2][1] = { color: "white", x: 2, y: 1, index: -1 }
  const [selfCapturedStones, otherCapturedStones] = getCapturedStones(
    { color: "black", x: 1, y: 1, index: -1 },
    stoneMatrix
  )
  expect(selfCapturedStones.length == 1)
  expect(otherCapturedStones.length == 0)
})

test("other captured (single stone)", () => {
  const stoneMatrix: Array<Array<Stone>> = initializeBoard()
  stoneMatrix[0][1] = { color: "white", x: 0, y: 1, index: -1 }
  stoneMatrix[1][0] = { color: "white", x: 1, y: 0, index: -1 }
  stoneMatrix[1][2] = { color: "white", x: 1, y: 2, index: -1 }
  stoneMatrix[1][1] = { color: "black", x: 1, y: 1, index: -1 }
  const [selfCapturedStones, otherCapturedStones] = getCapturedStones(
    { color: "white", x: 2, y: 1, index: -1 },
    stoneMatrix
  )
  expect(selfCapturedStones.length == 0)
  expect(otherCapturedStones.length == 1)
})

test("other captured (edge)", () => {
  const stoneMatrix: Array<Array<Stone>> = initializeBoard()
  stoneMatrix[2][0] = { color: "white", x: 2, y: 0, index: -1 }
  stoneMatrix[3][0] = { color: "black", x: 3, y: 0, index: -1 }
  stoneMatrix[4][0] = { color: "white", x: 4, y: 0, index: -1 }
  const [selfCapturedStones, otherCapturedStones] = getCapturedStones(
    { color: "white", x: 3, y: 1, index: -1 },
    stoneMatrix
  )
  expect(selfCapturedStones.length == 0)
  expect(otherCapturedStones.length == 1)
})

test("other captured (corner)", () => {
  const stoneMatrix: Array<Array<Stone>> = initializeBoard()
  stoneMatrix[0][1] = { color: "white", x: 0, y: 1, index: -1 }
  stoneMatrix[0][0] = { color: "black", x: 0, y: 0, index: -1 }
  const [selfCapturedStones, otherCapturedStones] = getCapturedStones(
    { color: "white", x: 1, y: 0, index: -1 },
    stoneMatrix
  )
  expect(selfCapturedStones.length == 0)
  expect(otherCapturedStones.length == 1)
})

test("other captured (multi stone)", () => {
  const stoneMatrix: Array<Array<Stone>> = initializeBoard()
  stoneMatrix[0][0] = { color: "white", x: 0, y: 0, index: -1 }
  stoneMatrix[0][1] = { color: "white", x: 0, y: 1, index: -1 }
  stoneMatrix[0][2] = { color: "black", x: 0, y: 2, index: -1 }
  stoneMatrix[1][0] = { color: "white", x: 1, y: 0, index: -1 }
  stoneMatrix[1][1] = { color: "white", x: 1, y: 1, index: -1 }
  stoneMatrix[1][2] = { color: "black", x: 1, y: 2, index: -1 }
  stoneMatrix[2][0] = { color: "black", x: 2, y: 0, index: -1 }
  const [selfCapturedStones, otherCapturedStones] = getCapturedStones(
    { color: "black", x: 2, y: 1, index: -1 },
    stoneMatrix
  )
  expect(selfCapturedStones.length == 0)
  expect(otherCapturedStones.length == 4)
})

test("ko", () => {
  const stoneMatrix: Array<Array<Stone>> = initializeBoard()
  stoneMatrix[2][2] = { color: "white", x: 2, y: 2, index: -1 }
  stoneMatrix[3][2] = { color: "black", x: 3, y: 2, index: -1 }
  stoneMatrix[1][3] = { color: "white", x: 1, y: 3, index: -1 }
  stoneMatrix[2][3] = { color: "black", x: 2, y: 3, index: -1 }
  stoneMatrix[4][3] = { color: "black", x: 4, y: 3, index: -1 }
  stoneMatrix[2][4] = { color: "white", x: 2, y: 4, index: -1 }
  stoneMatrix[3][4] = { color: "black", x: 3, y: 4, index: -1 }
  const [selfCapturedStones, otherCapturedStones] = getCapturedStones(
    { color: "white", x: 3, y: 3, index: -1 },
    stoneMatrix
  )
  expect(selfCapturedStones.length == 1)
  expect(otherCapturedStones.length == 1)
})
