import 'package:frontend/util/go_rule.dart';

const int boardSize = 19;
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
  Stone(this.color, this.x, this.y, this.index, this.isPassed) {
    assert(-1 <= x && x < boardSize);
    assert(-1 <= y && y < boardSize);
  }
  final StoneColor color;
  final int x;
  final int y;
  final int index;
  final bool isPassed;

  Map<String, dynamic> toJson() {
    return {
      'color': color == StoneColor.black ? 0 : 1,
      'x': x,
      'y': y,
    };
  }
}

typedef StoneList = List<Stone>;
typedef StoneMatrix = List<StoneList>;

class Joseki {
  StoneList stoneList = [];

  Joseki(StoneList stones);

  bool pushStone({
    required StoneColor color,
    required int x,
    required int y,
    required bool isPassed,
  }) {
    stoneList.add(Stone(color, x, y, stoneList.length, isPassed));
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
    return stoneList.where((stone) => stone.isPassed).toList();
  }
}
