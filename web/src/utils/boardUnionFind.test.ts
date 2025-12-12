import { expect, test } from "vitest"
import { BoardUnionFind } from "./boardUnionFind"

test("simple", () => {
  const uf = new BoardUnionFind(3)
  expect(uf.isSame({ x: 0, y: 0 }, { x: 1, y: 0 })).toBe(false)
  expect(uf.unite({ x: 0, y: 0 }, { x: 1, y: 0 })).toBe(true)
  expect(uf.unite({ x: 1, y: 0 }, { x: 0, y: 0 })).toBe(false)
  expect(uf.isSame({ x: 0, y: 0 }, { x: 1, y: 0 })).toBe(true)
  expect(uf.getValue({ x: 0, y: 0 })).toBe(3)
})

test("dango", () => {
  const uf = new BoardUnionFind(3)
  expect(uf.isSame({ x: 0, y: 0 }, { x: 1, y: 1 })).toBe(false)
  expect(uf.unite({ x: 0, y: 0 }, { x: 1, y: 0 })).toBe(true)
  expect(uf.unite({ x: 1, y: 0 }, { x: 0, y: 0 })).toBe(false)
  expect(uf.unite({ x: 1, y: 0 }, { x: 1, y: 1 })).toBe(true)
  expect(uf.unite({ x: 1, y: 1 }, { x: 1, y: 0 })).toBe(false)
  expect(uf.unite({ x: 1, y: 1 }, { x: 0, y: 1 })).toBe(true)
  expect(uf.unite({ x: 0, y: 1 }, { x: 1, y: 1 })).toBe(false)
  expect(uf.unite({ x: 0, y: 1 }, { x: 0, y: 0 })).toBe(false)
  expect(uf.unite({ x: 0, y: 0 }, { x: 0, y: 1 })).toBe(false)
  expect(uf.isSame({ x: 0, y: 0 }, { x: 1, y: 1 })).toBe(true)
  expect(uf.getValue({ x: 0, y: 0 })).toBe(4)
})
