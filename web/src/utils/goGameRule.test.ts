import { expect, test } from "vitest"
import { generateEmptyMatrix, Stone } from "../models/joseki"
import { getCapturedStones } from "./goGameRule"

test("self captured (single stone)", () => {
  const stoneMatrix: Array<Array<Stone>> = generateEmptyMatrix()
  stoneMatrix[0][1] = new Stone("white", 0, 1, -1)
  stoneMatrix[1][0] = new Stone("white", 1, 0, -1)
  stoneMatrix[1][2] = new Stone("white", 1, 2, -1)
  stoneMatrix[2][1] = new Stone("white", 2, 1, -1)
  const [selfCapturedStones, otherCapturedStones] = getCapturedStones(
    new Stone("black", 1, 1, -1),
    stoneMatrix
  )
  expect(selfCapturedStones.length == 1)
  expect(otherCapturedStones.length == 0)
})

test("other captured (single stone)", () => {
  const stoneMatrix: Array<Array<Stone>> = generateEmptyMatrix()
  stoneMatrix[0][1] = new Stone("white", 0, 1, -1)
  stoneMatrix[1][0] = new Stone("white", 1, 0, -1)
  stoneMatrix[1][2] = new Stone("white", 1, 2, -1)
  stoneMatrix[1][1] = new Stone("black", 1, 1, -1)
  const [selfCapturedStones, otherCapturedStones] = getCapturedStones(
    new Stone("white", 2, 1, -1),
    stoneMatrix
  )
  expect(selfCapturedStones.length == 0)
  expect(otherCapturedStones.length == 1)
})

test("other captured (edge)", () => {
  const stoneMatrix: Array<Array<Stone>> = generateEmptyMatrix()
  stoneMatrix[2][0] = new Stone("white", 2, 0, -1)
  stoneMatrix[3][0] = new Stone("black", 3, 0, -1)
  stoneMatrix[4][0] = new Stone("white", 4, 0, -1)
  const [selfCapturedStones, otherCapturedStones] = getCapturedStones(
    new Stone("white", 3, 1, -1),
    stoneMatrix
  )
  expect(selfCapturedStones.length == 0)
  expect(otherCapturedStones.length == 1)
})

test("other captured (corner)", () => {
  const stoneMatrix: Array<Array<Stone>> = generateEmptyMatrix()
  stoneMatrix[0][1] = new Stone("white", 0, 1, -1)
  stoneMatrix[0][0] = new Stone("black", 0, 0, -1)
  const [selfCapturedStones, otherCapturedStones] = getCapturedStones(
    new Stone("white", 1, 0, -1),
    stoneMatrix
  )
  expect(selfCapturedStones.length == 0)
  expect(otherCapturedStones.length == 1)
})

test("other captured (multi stone)", () => {
  const stoneMatrix: Array<Array<Stone>> = generateEmptyMatrix()
  stoneMatrix[0][0] = new Stone("white", 0, 0, -1)
  stoneMatrix[0][1] = new Stone("white", 0, 1, -1)
  stoneMatrix[0][2] = new Stone("black", 0, 2, -1)
  stoneMatrix[1][0] = new Stone("white", 1, 0, -1)
  stoneMatrix[1][1] = new Stone("white", 1, 1, -1)
  stoneMatrix[1][2] = new Stone("black", 1, 2, -1)
  stoneMatrix[2][0] = new Stone("black", 2, 0, -1)
  const [selfCapturedStones, otherCapturedStones] = getCapturedStones(
    new Stone("black", 2, 1, -1),
    stoneMatrix
  )
  expect(selfCapturedStones.length == 0)
  expect(otherCapturedStones.length == 4)
})

test("ko", () => {
  const stoneMatrix: Array<Array<Stone>> = generateEmptyMatrix()
  stoneMatrix[2][2] = new Stone("white", 2, 2, -1)
  stoneMatrix[3][2] = new Stone("black", 3, 2, -1)
  stoneMatrix[1][3] = new Stone("white", 1, 3, -1)
  stoneMatrix[2][3] = new Stone("black", 2, 3, -1)
  stoneMatrix[4][3] = new Stone("black", 4, 3, -1)
  stoneMatrix[2][4] = new Stone("white", 2, 4, -1)
  stoneMatrix[3][4] = new Stone("black", 3, 4, -1)
  const [selfCapturedStones, otherCapturedStones] = getCapturedStones(
    new Stone("white", 3, 3, -1),
    stoneMatrix
  )
  expect(selfCapturedStones.length == 1)
  expect(otherCapturedStones.length == 1)
})
