import 'dart:math';

import 'package:frontend/models/joseki.dart';

// const int mod = (1 << 61) - 1;
// const int mask30 = (1 << 30) - 1;
// const int mask31 = (1 << 31) - 1;
// const int baseRow = 37;
// const int baseCol = 23;
// final List<int> row = generateArray(baseRow);
// final List<int> col = generateArray(baseCol);

// int mul(int a, int b) {
//   int au = a >> 31;
//   int ad = a & mask31;
//   int bu = b >> 31;
//   int bd = b & mask31;
//   int mid = ad * bu + au * bd;
//   int midu = mid >> 30;
//   int midd = mid & mask30;
//   return calcMod(au * bu * 2 + midu + (midd << 31) + ad * bd);
// }

// int calcMod(int x) {
//   int xu = x >> 61;
//   int xd = x & mod;
//   int res = xu + xd;
//   if (res >= mod) res -= mod;
//   return res;
// }

// List<int> generateArray(int base) {
//   List<int> array = [1];
//   for (int i = 1; i < boardSize; i++) {
//     array.add(mul(array.last, base));
//   }
//   return array;
// }

// // rolling hash
// int gobanHash(StoneMatrix stoneMatrix) {
//   int hash = 0;
//   for (int i = 0; i < boardSize; i++) {
//     for (int j = 0; j < boardSize; j++) {
//       if (stoneMatrix[i][j].color == StoneColor.empty) continue;
//       int val = mul(row[i], col[j]);
//       if (stoneMatrix[i][j].color == StoneColor.black) {
//         hash += val;
//       } else {
//         hash -= val;
//       }
//       hash = calcMod(hash);
//     }
//   }
//   return hash;
// }

final List<List<List<int>>> hashTable = generateTable();

List<List<List<int>>> generateTable() {
  Random random = Random(0);
  List<List<List<int>>> table = [];
  for (int i = 0; i < boardSize; i++) {
    List<List<int>> row = [];
    for (int j = 0; j < boardSize; j++) {
      List<int> col = [];
      for (int k = 0; k < 2; k++) {
        col.add(random.nextInt(1 << 30) << 30 | random.nextInt(1 << 30));
      }
      row.add(col);
    }
    table.add(row);
  }
  return table;
}

int gobanHash(StoneList captured, Stone stone, int originalHash) {
  int hash = originalHash;
  if (stone.color != StoneColor.empty) {
    hash ^= hashTable[stone.x][stone.y][stone.color.index];
  }
  for (int i = 0; i < captured.length; i++) {
    Stone cap = captured[i];
    if (cap.color != StoneColor.empty) {
      hash ^= hashTable[cap.x][cap.y][cap.color.index];
    }
  }
  return hash;
}
