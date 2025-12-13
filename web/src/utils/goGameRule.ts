import { boardSize, generateEmptyMatrix, Stone } from "../models/joseki"
import { BoardUnionFind } from "./boardUnionFind"
import { gobanHash } from "./gobanHash"

export const getProcessedBoard = (
  stoneList: Array<Stone>
): Array<Array<Stone>> => {
  let stoneMatrix: Array<Array<Stone>> = generateEmptyMatrix()
  let hash = 0
  const visited: Set<number> = new Set()
  let selfCapturedStones: Array<Stone>, otherCapturedStones: Array<Stone>

  for (let i = 0; i < stoneList.length; i++) {
    let stone = stoneList[i]
    if (isOverlapStone(stone, stoneMatrix)) {
      return []
    }
    ;[selfCapturedStones, otherCapturedStones] = getCapturedStones(
      stone,
      stoneMatrix
    )
    hash = gobanHash(otherCapturedStones, stone, hash)
    if (otherCapturedStones.length > 0) {
      if (visited.has(hash)) {
        return []
      }
    } else {
      if (selfCapturedStones.length > 0) {
        return []
      }
    }
    const newStoneMatrix: Array<Array<Stone>> = generateArray(
      stone,
      stoneMatrix,
      otherCapturedStones
    )
    stoneMatrix = newStoneMatrix
    visited.add(hash)
  }

  return stoneMatrix
}

const isOverlapStone = (
  newStone: Stone,
  stoneMatrix: Array<Array<Stone>>
): boolean => {
  return stoneMatrix[newStone.x][newStone.y].color != "empty"
}

export const getCapturedStones = (
  newStone: Stone,
  stoneMatrix: Array<Array<Stone>>
): [Array<Stone>, Array<Stone>] => {
  const selfCapturedStones: Array<Stone> = []
  const otherCapturedStones: Array<Stone> = []
  const boardUnionFind = new BoardUnionFind(boardSize)
  const tempMatrix: Array<Array<Stone>> = []
  for (let i = 0; i < boardSize; i++) {
    tempMatrix.push([])
    for (let j = 0; j < boardSize; j++) {
      if (i == newStone.x && j == newStone.y) {
        tempMatrix[i].push(newStone)
      } else {
        tempMatrix[i].push(stoneMatrix[i][j])
      }
    }
  }

  for (let i = 0; i < boardSize; i++) {
    for (let j = 0; j < boardSize; j++) {
      const stone = tempMatrix[i][j]
      if (stone.color == "empty") continue
      for (
        let count = 0, dx = 1, dy = 0;
        count < 4;
        [dx, dy, count] = [dy, -dx, count + 1]
      ) {
        let nx = stone.x + dx,
          ny = stone.y + dy
        if (nx < 0 || boardSize <= nx || ny < 0 || boardSize <= ny) continue
        if (tempMatrix[nx][ny].color == "empty") continue
        if (stone.color == tempMatrix[nx][ny].color) {
          boardUnionFind.unite({ x: stone.x, y: stone.y }, { x: nx, y: ny })
        } else {
          boardUnionFind.decrement({ x: stone.x, y: stone.y })
        }
      }
    }
  }

  for (let i = 0; i < boardSize; i++) {
    for (let j = 0; j < boardSize; j++) {
      if (tempMatrix[i][j].color == "empty") continue
      if (boardUnionFind.getValue({ x: i, y: j }) == 0) {
        if (tempMatrix[i][j].color == newStone.color) {
          selfCapturedStones.push(tempMatrix[i][j])
        } else {
          otherCapturedStones.push(tempMatrix[i][j])
        }
      }
    }
  }

  return [selfCapturedStones, otherCapturedStones]
}

const generateArray = (
  newStone: Stone,
  stoneMatrix: Array<Array<Stone>>,
  capturedStones: Array<Stone>
) => {
  const newStoneMatrix: Array<Array<Stone>> = stoneMatrix.map(
    (stoneList, i) => {
      return stoneList.map((stone, j) => {
        return new Stone(stone.color, i, j, stone.index)
      })
    }
  )

  // remove captured stones
  for (let i = 0; i < capturedStones.length; i++) {
    const capturedStone = capturedStones[i]
    newStoneMatrix[capturedStone.x][capturedStone.y] = new Stone(
      "empty",
      capturedStone.x,
      capturedStone.y,
      -1
    )
  }
  // add new stone
  newStoneMatrix[newStone.x][newStone.y] = new Stone(
    newStone.color,
    newStone.x,
    newStone.y,
    newStone.index
  )

  return newStoneMatrix
}
