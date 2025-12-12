import { getProcessedBoard } from "../utils/goGameRule";

export const boardSize = 19;
// export const screenBoardSize = 14;

export type StoneColor = "black" | "white" | "empty";

export const reversedColor = (color: StoneColor): StoneColor => {
  if (color == "black") {
    return "white";
  } else if (color == "white") {
    return "black";
  } else {
    return "empty";
  }
}

export class Stone {
  color: StoneColor;
  x: number;
  y: number;
  index: number;
  constructor(color: StoneColor, x: number, y: number, index: number) {
    if (!(0 <= x && x < boardSize && 0 <= y && y < boardSize)) {
      throw new Error("Stone position is out of board");
    }
    this.color = color;
    this.x = x;
    this.y = y;
    this.index = index;
  }

  // Map<String, dynamic> toJson() {
  //   return {'color': color == StoneColor.black ? 0 : 1, 'x': x, 'y': y};
  // }
}

export class Joseki {
  stoneList: Array<Stone> = [];

  constructor(stones: Array<Stone>) {
    this.stoneList = stones;
  }

  pushStone(color: StoneColor, x: number, y: number): boolean {
    const stone = new Stone(color, x, y, this.stoneList.length);
    this.stoneList.push(stone);
    if (getProcessedBoard(this.stoneList).length > 0) {
      return true;
    } else {
      this.stoneList.pop();
      return false;
    }
  }

  clear() {
    this.stoneList = [];
  }

  popStone() {
    if (this.stoneList.length > 0) {
      this.stoneList.pop();
    }
  }

  popStones(count: number) {
    for (let i = 0; i < count; i++) {
      this.popStone();
    }
  }
}

export class GobanState {
  joseki: Joseki = new Joseki([]);
  stoneMatrix: Array<Array<Stone>> = getProcessedBoard([]);

  constructor(newJoseki: Joseki) {
    this.joseki = newJoseki;
    this.stoneMatrix = getProcessedBoard(this.joseki.stoneList);
  }
}

export const generateEmptyMatrix = (): Array<Array<Stone>> => {
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