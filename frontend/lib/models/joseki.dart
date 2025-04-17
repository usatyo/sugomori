enum StoneColor { black, white, empty }

class Stone {
  Stone({required this.color, required this.x, required this.y});
  final StoneColor color;
  final int x;
  final int y;
}

class Joseki {
  List<Stone> stoneList = [];
  Map<int, Stone> stoneMap = {};

  Joseki(List<Stone> stones) {
    for (var stone in stones) {
      pushStone(stone);
    }
  }

  void pushStone(Stone stone) {
    int index = stone.x * 13 + stone.y;
    stoneList.add(stone);
    stoneMap[index] = stone;
  }

  void clear() {
    stoneList.clear();
    stoneMap.clear();
  }

  void popStone() {
    if (stoneList.isNotEmpty) {
      Stone stone = stoneList.removeLast();
      int index = stone.x * 13 + stone.y;
      stoneMap.remove(index);
    }
  }

  void popStones(int count) {
    for (int i = 0; i < count; i++) {
      popStone();
    }
  }
}
