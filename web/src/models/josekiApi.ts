import type { Stone } from "./joseki"

export class JosekiVideoRequest {
  stones: Array<Stone>
  videoId: string

  constructor(stones: Array<Stone>, videoId: string) {
    this.stones = stones
    this.videoId = videoId
  }

  toJson() {
    return {
      joseki: {
        stones: this.stones.map((stone) => stone.toJson()),
      },
      video: {
        id: this.videoId,
      },
    }
  }
}

export class StonesRequest {
  stones: Array<Stone>

  constructor(stones: Array<Stone>) {
    this.stones = stones
  }

  toJson() {
    return {
      stones: this.stones.map((stone) => stone.toJson()),
    }
  }
}
