import 'package:frontend/models/joseki.dart';

const int mod = (1 << 61) - 1;
const int baseRow = 37;
const int baseCol = 23;
final List<int> row = generateArray(baseRow);
final List<int> col = generateArray(baseCol);

List<int> generateArray(int base) {
  List<int> array = [1];
  for (int i = 1; i < boardSize; i++) {
    array.add(array.last * base % mod);
  }
  return array;
}

int gobanHash(StoneMatrix stoneMatrix) {
  int hash = 0;
  for (int i = 0; i < boardSize; i++) {
    for (int j = 0; j < boardSize; j++) {
      if (stoneMatrix[i][j].color == StoneColor.empty) continue;
      int val = row[i] * col[j] % mod;
      if (stoneMatrix[i][j].color == StoneColor.black) {
        hash += val;
      } else {
        hash -= val;
      }
    }
  }
  return hash;
}
