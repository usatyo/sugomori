class Pair {
  Pair(this.x, this.y);
  int x;
  int y;
}

class BoardUnionFindind {
  late int _n;
  late List<int> _parent, _rank, _size, _value;
  BoardUnionFindind(int n) {
    _n = n;
    _parent = List.filled(n * n, -1);
    _rank = List.filled(n * n, 0);
    _size = List.filled(n * n, 1);
    _value = List.filled(n * n, 4);
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        int idx = i * n + j;
        if (i == 0 || i == n - 1) {
          _value[idx]--;
        }
        if (j == 0 || j == n - 1) {
          _value[idx]--;
        }
      }
    }
  }

  int _root(int x) {
    if (_parent[x] == -1) return x;
    _parent[x] = _root(_parent[x]);
    return _parent[x];
  }

  void _assertPair(Pair p) {
    assert(p.x >= 0 && p.x < _n);
    assert(p.y >= 0 && p.y < _n);
  }

  bool isSame(Pair p1, Pair p2) {
    _assertPair(p1);
    _assertPair(p2);
    int idx1 = p1.x * _n + p1.y;
    int idx2 = p2.x * _n + p2.y;
    return _root(idx1) == _root(idx2);
  }

  bool unite(Pair p1, Pair p2) {
    _assertPair(p1);
    _assertPair(p2);
    decrement(p1);
    int idx1 = p1.x * _n + p1.y;
    int idx2 = p2.x * _n + p2.y;
    int r1 = _root(idx1);
    int r2 = _root(idx2);
    if (r1 == r2) return false;
    if (_rank[r1] < _rank[r2]) {
      (r1, r2) = (r2, r1);
    }
    _parent[r2] = r1;
    if (_rank[r1] == _rank[r2]) {
      _rank[r1]++;
    }
    _size[r1] += _size[r2];
    _value[r1] += _value[r2];
    return true;
  }

  int size(Pair p) {
    _assertPair(p);
    int idx = p.x * _n + p.y;
    return _size[_root(idx)];
  }

  List<Pair> group(Pair p) {
    List<Pair> sameGroup = [];
    for (int i = 0; i < _n; i++) {
      for (int j = 0; j < _n; j++) {
        if (isSame(p, Pair(i, j))) {
          sameGroup.add(Pair(i, j));
        }
      }
    }
    return sameGroup;
  }

  int value(Pair p) {
    _assertPair(p);
    int idx = p.x * _n + p.y;
    return _value[_root(idx)];
  }

  void decrement(Pair p) {
    _assertPair(p);
    int idx = p.x * _n + p.y;
    _value[_root(idx)]--;
  }
}
