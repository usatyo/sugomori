import 'package:flutter/material.dart';
import 'package:frontend/components/goban_painter.dart';
import 'package:frontend/components/single_stone.dart';
import 'package:frontend/model/joseki.dart';

class Goban extends StatefulWidget {
  const Goban({super.key});

  @override
  State<Goban> createState() => _GobanState();
}

class _GobanState extends State<Goban> {
  @override
  Widget build(BuildContext context) {
    Joseki joseki = Joseki([
      Stone(color: StoneColor.black, x: 3, y: 2),
      Stone(color: StoneColor.white, x: 3, y: 4),
      Stone(color: StoneColor.black, x: 2, y: 4),
      Stone(color: StoneColor.white, x: 2, y: 5),
      Stone(color: StoneColor.black, x: 2, y: 3),
      Stone(color: StoneColor.white, x: 3, y: 5),
      Stone(color: StoneColor.black, x: 5, y: 2),
      Stone(color: StoneColor.white, x: 3, y: 9),
    ]);

    return SizedBox(
      height: 300,
      width: 300,
      child: InteractiveViewer(
        panEnabled: false,
        child: Stack(
          children: [
            CustomPaint(size: Size(300, 300), painter: GobanPainter()),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 13 * 13,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (joseki.stoneMap.containsKey(index)) {
                  final stone = joseki.stoneMap[index]!;
                  return SingleStone(
                    num: joseki.stoneList.indexOf(stone) + 1,
                    color: stone.color,
                  );
                }
                return SingleStone(num: null, color: StoneColor.empty);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 13,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
