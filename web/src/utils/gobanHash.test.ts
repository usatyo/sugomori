import { expect, test } from "vitest"
import { boardSize, Stone } from "../models/model"
import { gobanHash } from "./gobanHash"

test("same joseki", () => {
  for (let x = 0; x < boardSize; x++) {
    for (let y = 0; y < boardSize; y++) {
      expect(
        gobanHash([], new Stone("black", x, y, 0), 0) ===
          gobanHash([], new Stone("black", x, y, 0), 0)
      )
    }
  }
})

test("different joseki", () => {
  for (let x = 0; x < boardSize; x++) {
    for (let y = 0; y < boardSize; y++) {
      if (x == 3 && y == 3) continue
      expect(
        gobanHash([], new Stone("black", x, y, 0), 0) !==
          gobanHash([], new Stone("black", 3, 3, 0), 0)
      )
    }
  }
})
