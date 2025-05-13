import 'package:frontend/models/joseki.dart';
import 'package:frontend/util/board_union_find.dart';
import 'package:frontend/util/goban_hash.dart';

StoneMatrix getProcessedBoard(StoneList stoneList) {
  StoneMatrix stoneMatrix = List.generate(
    boardSize,
    (i) => List.generate(
      boardSize,
      (j) => Stone(StoneColor.empty, i, j, -1, false),
    ),
  );
  int hash = 0;
  Set<int> visited = {};
  StoneList selfCapturedStones, otherCapturedStones;

  for (int i = 0; i < stoneList.length; i++) {
    Stone stone = stoneList[i];
    if (stone.isPassed) {
      continue;
    }
    if (isOverlapStone(stone, stoneMatrix)) {
      return [];
    }
    (selfCapturedStones, otherCapturedStones) = getCapturedStones(
      stone,
      stoneMatrix,
    );
    hash = gobanHash(otherCapturedStones, stone, hash);
    if (otherCapturedStones.isNotEmpty) {
      if (visited.contains(hash)) {
        return [];
      }
    } else {
      if (selfCapturedStones.isNotEmpty) {
        return [];
      }
    }
    StoneMatrix newStoneMatrix = generateStoneMatrix(
      stone,
      stoneMatrix,
      otherCapturedStones,
    );
    stoneMatrix = newStoneMatrix;
    visited.add(hash);
  }

  return stoneMatrix;
}

bool isOverlapStone(Stone newStone, StoneMatrix stoneMatrix) {
  return stoneMatrix[newStone.x][newStone.y].color != StoneColor.empty;
}

(StoneList, StoneList) getCapturedStones(
  Stone newStone,
  StoneMatrix stoneMatrix,
) {
  StoneList selfCapturedStones = [];
  StoneList otherCapturedStones = [];
  BoardUnionFindind uf = BoardUnionFindind(boardSize);
  StoneMatrix tempMatrix = [];
  for (int i = 0; i < boardSize; i++) {
    tempMatrix.add([]);
    for (int j = 0; j < boardSize; j++) {
      if (i == newStone.x && j == newStone.y) {
        tempMatrix[i].add(newStone);
      } else {
        tempMatrix[i].add(stoneMatrix[i][j]);
      }
    }
  }

  for (int i = 0; i < boardSize; i++) {
    for (int j = 0; j < boardSize; j++) {
      Stone stone = tempMatrix[i][j];
      if (stone.color == StoneColor.empty) continue;
      for (
        int count = 0, dx = 1, dy = 0;
        count < 4;
        (dx, dy, count) = (dy, -dx, count + 1)
      ) {
        int nx = stone.x + dx, ny = stone.y + dy;
        if (nx < 0 || boardSize <= nx || ny < 0 || boardSize <= ny) continue;
        if (tempMatrix[nx][ny].color == StoneColor.empty) continue;
        if (stone.color == tempMatrix[nx][ny].color) {
          uf.unite(Pair(stone.x, stone.y), Pair(nx, ny));
        } else {
          uf.decrement(Pair(stone.x, stone.y));
        }
      }
    }
  }

  for (int i = 0; i < boardSize; i++) {
    for (int j = 0; j < boardSize; j++) {
      if (tempMatrix[i][j].color == StoneColor.empty) continue;
      if (uf.value(Pair(i, j)) == 0) {
        if (tempMatrix[i][j].color == newStone.color) {
          selfCapturedStones.add(tempMatrix[i][j]);
        } else {
          otherCapturedStones.add(tempMatrix[i][j]);
        }
      }
    }
  }

  return (selfCapturedStones, otherCapturedStones);
}

StoneMatrix generateStoneMatrix(
  Stone newStone,
  StoneMatrix stoneMatrix,
  StoneList capturedStones,
) {
  StoneMatrix newStoneMatrix = List.generate(
    boardSize,
    (i) => List.generate(
      boardSize,
      (j) =>
          Stone(stoneMatrix[i][j].color, i, j, stoneMatrix[i][j].index, false),
    ),
  );

  // remove captured stones
  for (int i = 0; i < capturedStones.length; i++) {
    Stone capturedStone = capturedStones[i];
    newStoneMatrix[capturedStone.x][capturedStone.y] = Stone(
      StoneColor.empty,
      capturedStone.x,
      capturedStone.y,
      -1,
      false,
    );
  }
  // add new stone
  newStoneMatrix[newStone.x][newStone.y] = Stone(
    newStone.color,
    newStone.x,
    newStone.y,
    newStone.index,
    false,
  );

  return newStoneMatrix;
}
