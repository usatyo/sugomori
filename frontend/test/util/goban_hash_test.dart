import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/util/goban_hash.dart';

void main() {
  late StoneMatrix hoshi1;
  late StoneMatrix hoshi2;
  late StoneMatrix komoku;
  setUp(() {
    hoshi1 = List.generate(
      boardSize,
      (i) => List.generate(boardSize, (j) => Stone(StoneColor.empty, i, j, -1)),
    );
    hoshi1[3][3] = Stone(StoneColor.black, 3, 3, 0);
    hoshi2 = List.generate(
      boardSize,
      (i) => List.generate(boardSize, (j) => Stone(StoneColor.empty, i, j, -1)),
    );
    hoshi2[3][3] = Stone(StoneColor.black, 3, 3, 0);
    komoku = List.generate(
      boardSize,
      (i) => List.generate(boardSize, (j) => Stone(StoneColor.empty, i, j, -1)),
    );
    komoku[3][2] = Stone(StoneColor.black, 3, 2, 0);
  });

  test("same joseki", () {
    expect(
      gobanHash([], Stone(StoneColor.black, 3, 3, 0), 0) ==
          gobanHash([], Stone(StoneColor.black, 3, 3, 0), 0),
      equals(true),
    );
  });

  test("different joseki", () {
    expect(
      gobanHash([], Stone(StoneColor.black, 3, 3, 0), 0) !=
          gobanHash([], Stone(StoneColor.black, 3, 2, 0), 0),
      equals(true),
    );
  });
}
