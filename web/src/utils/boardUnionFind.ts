export type Pair  = {
  x: number
  y: number
}

export class BoardUnionFind {
  private n: number
  private parent: Array<number>
  private rank: Array<number>
  private size: Array<number>
  private value: Array<number>
  constructor(n: number) {
    this.n = n
    this.parent = new Array(n * n).fill(-1)
    this.rank = new Array(n * n).fill(0)
    this.size = new Array(n * n).fill(1)
    this.value = new Array(n * n).fill(4)
    for (let i = 0; i < n; i++) {
      for (let j = 0; j < n; j++) {
        let idx = i * n + j;
        if (i === 0 || i === n - 1) {
          this.value[idx]--;
        }
        if (j === 0 || j === n - 1) {
          this.value[idx]--;
        }
      }
    }
  }

  root(x: number): number {
    if (this.parent[x] == -1) return x;
    this.parent[x] = this.root(this.parent[x]);
    return this.parent[x];
  }

  assertPair(p: Pair) {
    if (p.x !== Math.floor(p.x) || p.y !== Math.floor(p.y)) {
      throw new Error("Value is not integer");
    }
    if (p.x < 0 || p.x >= this.n) {
      throw new Error("Pair x is out of bounds");
    }
    if (p.y < 0 || p.y >= this.n) {
      throw new Error("Pair y is out of bounds");
    }
  }

  isSame(p1: Pair, p2: Pair): boolean {
    this.assertPair(p1);
    this.assertPair(p2);
    let idx1 = p1.x * this.n + p1.y;
    let idx2 = p2.x * this.n + p2.y;
    return this.root(idx1) === this.root(idx2);
  }

  unite(p1: Pair, p2: Pair): boolean {
    this.assertPair(p1);
    this.assertPair(p2);
    this.decrement(p1);
    let idx1 = p1.x * this.n + p1.y;
    let idx2 = p2.x * this.n + p2.y;
    let r1 = this.root(idx1);
    let r2 = this.root(idx2);
    if (r1 === r2) return false;
    if (this.rank[r1] < this.rank[r2]) {
      [r1, r2] = [r2, r1];
    }
    this.parent[r2] = r1;
    if (this.rank[r1] === this.rank[r2]) {
      this.rank[r1]++;
    }
    this.size[r1] += this.size[r2];
    this.value[r1] += this.value[r2];
    return true;
  }

  getSize(p: Pair): number {
    this.assertPair(p);
    let idx = p.x * this.n + p.y;
    return this.size[this.root(idx)];
  }

  group(p: Pair): Array<Pair> {
    let sameGroup: Array<Pair> = [];
    for (let i = 0; i < this.n; i++) {
      for (let j = 0; j < this.n; j++) {
        if (this.isSame(p, {x: i, y: j})) {
          sameGroup.push({x: i, y: j});
        }
      }
    }
    return sameGroup;
  }

  getValue(p: Pair): number {
    this.assertPair(p);
    let idx = p.x * this.n + p.y;
    return this.value[this.root(idx)];
  }

  decrement(p: Pair) {
    this.assertPair(p);
    let idx = p.x * this.n + p.y;
    this.value[this.root(idx)]--;
  }
}
