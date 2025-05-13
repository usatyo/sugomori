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
      (i) => List.generate(
        boardSize,
        (j) => Stone(StoneColor.empty, i, j, -1, false),
      ),
    );
    hoshi1[3][3] = Stone(StoneColor.black, 3, 3, 0, false);
    hoshi2 = List.generate(
      boardSize,
      (i) => List.generate(
        boardSize,
        (j) => Stone(StoneColor.empty, i, j, -1, false),
      ),
    );
    hoshi2[3][3] = Stone(StoneColor.black, 3, 3, 0, false);
    komoku = List.generate(
      boardSize,
      (i) => List.generate(
        boardSize,
        (j) => Stone(StoneColor.empty, i, j, -1, false),
      ),
    );
    komoku[3][2] = Stone(StoneColor.black, 3, 2, 0, false);
  });

  test("same joseki", () {
    expect(
      gobanHash([], Stone(StoneColor.black, 3, 3, 0, false), 0) ==
          gobanHash([], Stone(StoneColor.black, 3, 3, 0, false), 0),
      equals(true),
    );
  });

  test("different joseki", () {
    expect(
      gobanHash([], Stone(StoneColor.black, 3, 3, 0, false), 0) !=
          gobanHash([], Stone(StoneColor.black, 3, 2, 0, false), 0),
      equals(true),
    );
  });
}
