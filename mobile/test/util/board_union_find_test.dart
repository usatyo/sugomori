import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/util/board_union_find.dart';

void main() {
  late BoardUnionFindind uf;

  setUp(() {
    uf = BoardUnionFindind(3);
  });

  test("simple", () {
    expect(uf.isSame(Pair(0, 0), Pair(1, 0)), equals(false));
    expect(uf.unite(Pair(0, 0), Pair(1, 0)), equals(true));
    expect(uf.unite(Pair(1, 0), Pair(0, 0)), equals(false));
    expect(uf.isSame(Pair(0, 0), Pair(1, 0)), equals(true));
    expect(uf.value(Pair(0, 0)), equals(3));
  });

  test("dango", () {
    expect(uf.isSame(Pair(0, 0), Pair(1, 1)), equals(false));
    expect(uf.unite(Pair(0, 0), Pair(1, 0)), equals(true));
    expect(uf.unite(Pair(1, 0), Pair(0, 0)), equals(false));
    expect(uf.unite(Pair(1, 0), Pair(1, 1)), equals(true));
    expect(uf.unite(Pair(1, 1), Pair(1, 0)), equals(false));
    expect(uf.unite(Pair(1, 1), Pair(0, 1)), equals(true));
    expect(uf.unite(Pair(0, 1), Pair(1, 1)), equals(false));
    expect(uf.unite(Pair(0, 1), Pair(0, 0)), equals(false));
    expect(uf.unite(Pair(0, 0), Pair(0, 1)), equals(false));
    expect(uf.isSame(Pair(0, 0), Pair(1, 1)), equals(true));
    expect(uf.value(Pair(0, 0)), equals(4));
  });
}
