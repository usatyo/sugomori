import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/util/go_rule.dart';

void main() {
  late StoneMatrix stoneMatrix;
  late StoneList selfCapturedStones;
  late StoneList otherCapturedStones;

  setUp(() {
    stoneMatrix = List.generate(
      boardSize,
      (i) => List.generate(
        boardSize,
        (j) => Stone(StoneColor.empty, i, j, -1, false),
      ),
    );
  });

  test("self captured (single stone)", () {
    stoneMatrix[0][1] = Stone(StoneColor.white, 0, 1, -1, false);
    stoneMatrix[1][0] = Stone(StoneColor.white, 1, 0, -1, false);
    stoneMatrix[1][2] = Stone(StoneColor.white, 1, 2, -1, false);
    stoneMatrix[2][1] = Stone(StoneColor.white, 2, 1, -1, false);
    (selfCapturedStones, otherCapturedStones) = getCapturedStones(
      Stone(StoneColor.black, 1, 1, -1, false),
      stoneMatrix,
    );
    expect(selfCapturedStones.length, equals(1));
    expect(otherCapturedStones.length, equals(0));
  });
  test("other captured (single stone)", () {
    stoneMatrix[0][1] = Stone(StoneColor.white, 0, 1, -1, false);
    stoneMatrix[1][0] = Stone(StoneColor.white, 1, 0, -1, false);
    stoneMatrix[1][2] = Stone(StoneColor.white, 1, 2, -1, false);
    stoneMatrix[1][1] = Stone(StoneColor.black, 1, 1, -1, false);
    (selfCapturedStones, otherCapturedStones) = getCapturedStones(
      Stone(StoneColor.white, 2, 1, -1, false),
      stoneMatrix,
    );
    expect(selfCapturedStones.length, equals(0));
    expect(otherCapturedStones.length, equals(1));
  });
  test("other captured (edge)", () {
    stoneMatrix[2][0] = Stone(StoneColor.white, 2, 0, -1, false);
    stoneMatrix[3][0] = Stone(StoneColor.black, 3, 0, -1, false);
    stoneMatrix[4][0] = Stone(StoneColor.white, 4, 0, -1, false);
    (selfCapturedStones, otherCapturedStones) = getCapturedStones(
      Stone(StoneColor.white, 3, 1, -1, false),
      stoneMatrix,
    );
    expect(selfCapturedStones.length, equals(0));
    expect(otherCapturedStones.length, equals(1));
  });
  test("other captured (corner)", () {
    stoneMatrix[0][1] = Stone(StoneColor.white, 0, 1, -1, false);
    stoneMatrix[0][0] = Stone(StoneColor.black, 0, 0, -1, false);
    (selfCapturedStones, otherCapturedStones) = getCapturedStones(
      Stone(StoneColor.white, 1, 0, -1, false),
      stoneMatrix,
    );
    expect(selfCapturedStones.length, equals(0));
    expect(otherCapturedStones.length, equals(1));
  });
  test("other captured (multi stone)", () {
    stoneMatrix[0][0] = Stone(StoneColor.white, 0, 0, -1, false);
    stoneMatrix[0][1] = Stone(StoneColor.white, 0, 1, -1, false);
    stoneMatrix[0][2] = Stone(StoneColor.black, 0, 2, -1, false);
    stoneMatrix[1][0] = Stone(StoneColor.white, 1, 0, -1, false);
    stoneMatrix[1][1] = Stone(StoneColor.white, 1, 1, -1, false);
    stoneMatrix[1][2] = Stone(StoneColor.black, 1, 2, -1, false);
    stoneMatrix[2][0] = Stone(StoneColor.black, 2, 0, -1, false);
    (selfCapturedStones, otherCapturedStones) = getCapturedStones(
      Stone(StoneColor.black, 2, 1, -1, false),
      stoneMatrix,
    );
    expect(selfCapturedStones.length, equals(0));
    expect(otherCapturedStones.length, equals(4));
  });
  test("ko", () {
    stoneMatrix[2][2] = Stone(StoneColor.white, 2, 2, -1, false);
    stoneMatrix[3][2] = Stone(StoneColor.black, 3, 2, -1, false);
    stoneMatrix[1][3] = Stone(StoneColor.white, 1, 3, -1, false);
    stoneMatrix[2][3] = Stone(StoneColor.black, 2, 3, -1, false);
    stoneMatrix[4][3] = Stone(StoneColor.black, 4, 3, -1, false);
    stoneMatrix[2][4] = Stone(StoneColor.white, 2, 4, -1, false);
    stoneMatrix[3][4] = Stone(StoneColor.black, 3, 4, -1, false);
    (selfCapturedStones, otherCapturedStones) = getCapturedStones(
      Stone(StoneColor.white, 3, 3, -1, false),
      stoneMatrix,
    );
    expect(selfCapturedStones.length, equals(1));
    expect(otherCapturedStones.length, equals(1));
  });
}
