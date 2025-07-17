import 'package:frontend/util/go_rule.dart';

const int boardSize = 19;
const int screenBoardSize = 14;

enum StoneColor { black, white, empty }

StoneColor reversedColor(StoneColor color) {
  if (color == StoneColor.black) {
    return StoneColor.white;
  } else if (color == StoneColor.white) {
    return StoneColor.black;
  } else {
    return StoneColor.empty;
  }
}

// pass:
class Stone {
  Stone(this.color, this.x, this.y, this.index) {
    assert(-1 <= x && x < boardSize);
    assert(-1 <= y && y < boardSize);
  }
  final StoneColor color;
  final int x;
  final int y;
  final int index;

  bool isPassed() {
    return x == -1 && y == -1;
  }

  Map<String, dynamic> toJson() {
    return {'color': color == StoneColor.black ? 0 : 1, 'x': x, 'y': y};
  }
}

typedef StoneList = List<Stone>;
typedef StoneMatrix = List<StoneList>;

class Joseki {
  StoneList stoneList = [];

  Joseki(StoneList stones) {
    stoneList = stones;
  }

  bool pushStone({required StoneColor color, required int x, required int y}) {
    Stone stone = Stone(color, x, y, stoneList.length);
    stoneList.add(stone);
    if (getProcessedBoard(stoneList).isNotEmpty) {
      return true;
    } else {
      stoneList.removeLast();
      return false;
    }
  }

  void clear() {
    stoneList.clear();
  }

  void popStone() {
    if (stoneList.isNotEmpty) {
      stoneList.removeLast();
    }
  }

  void popStones(int count) {
    for (int i = 0; i < count; i++) {
      popStone();
    }
  }

  List<Stone> getPassedStones() {
    return stoneList.where((stone) => stone.isPassed()).toList();
  }
}

class GobanState {
  Joseki joseki = Joseki([]);
  StoneMatrix stoneMatrix = getProcessedBoard([]);

  GobanState(Joseki newJoseki) {
    joseki = newJoseki;
    stoneMatrix = getProcessedBoard(joseki.stoneList);
  }
}
