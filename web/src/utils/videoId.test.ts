import { expect, test } from "vitest"
import { checkVideoId, pickUpVideoId } from "./videoId"

test("check true id", () => {
  expect(checkVideoId("abcdefghijk")).toBe(true)
  expect(checkVideoId("ABCDEFGHIJK")).toBe(true)
  expect(checkVideoId("123456789-_")).toBe(true)
})

test("check false id", () => {
  expect(checkVideoId("abcdefghij")).toBe(false)
  expect(checkVideoId("abcdefghijkl")).toBe(false)
  expect(checkVideoId("abcd$fghijk")).toBe(false)
})

test("type of 'v=...'", () => {
  expect(pickUpVideoId("https://www.youtube.com/watch?v=abcdefghijk")).toBe(
    "abcdefghijk"
  )
  expect(pickUpVideoId("https://www.youtube.com/shorts?v=abcdefghijk")).toBe(
    "abcdefghijk"
  )
  expect(pickUpVideoId("https://youtu.be/watch?v=abcdefghijk")).toBe(
    "abcdefghijk"
  )
  expect(
    pickUpVideoId(
      "https://www.youtube.com/watch?v=abcdefghijk&list=aaa&start_ratio=1"
    )
  ).toBe("abcdefghijk")
  expect(
    pickUpVideoId(
      "https://www.youtube.com/shorts?v=abcdefghijk&list=aaa&start_ratio=1"
    )
  ).toBe("abcdefghijk")
  expect(
    pickUpVideoId(
      "https://youtu.be/watch?v=abcdefghijk&list=aaa&start_ratio=1"
    )
  ).toBe("abcdefghijk")
})

test("type of '/...'", () => {
  expect(pickUpVideoId("https://www.youtube.com/watch/abcdefghijk")).toBe(
    "abcdefghijk"
  )
  expect(pickUpVideoId("https://www.youtube.com/shorts/abcdefghijk")).toBe(
    "abcdefghijk"
  )
  expect(pickUpVideoId("https://youtu.be/abcdefghijk")).toBe("abcdefghijk")
  expect(
    pickUpVideoId(
      "https://www.youtube.com/watch/abcdefghijk?list=aaa&start_ratio=1"
    )
  ).toBe("abcdefghijk")
  expect(
    pickUpVideoId(
      "https://www.youtube.com/shorts/abcdefghijk?list=aaa&start_ratio=1"
    )
  ).toBe("abcdefghijk")
  expect(
    pickUpVideoId("https://youtu.be/abcdefghijk?list=aaa&start_ratio=1")
  ).toBe("abcdefghijk")
})

test("invalid url", () => {
  expect(
    pickUpVideoId("https://www.example.com/watch?v=abcdefghijk")
  ).toBeNull()
  expect(pickUpVideoId("https://www.youtube.com/playlist?list=aaa")).toBeNull()
  expect(pickUpVideoId("https://youtu.be/")).toBeNull()
  expect(pickUpVideoId("not a url")).toBeNull()
})
