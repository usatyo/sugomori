import 'package:flutter/material.dart';
import 'package:frontend/components/goban_painter.dart';
import 'package:frontend/components/single_stone.dart';
import 'package:frontend/models/joseki.dart';

class Goban extends StatefulWidget {
  const Goban({super.key});

  @override
  State<Goban> createState() => _GobanState();
}

class _GobanState extends State<Goban> {
  Joseki joseki = Joseki([]);
  StoneColor nextColor = StoneColor.black;

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
                  );
                }
                return SingleStone(
                  num: null,
                  color: StoneColor.empty,
                  onPressed:
                      () => {
                        setState(() {
                          joseki.pushStone(
                            Stone(
                              color: nextColor,
                              x: index ~/ 13,
                              y: index % 13,
                            ),
                          );
                          nextColor =
                              (nextColor == StoneColor.black)
                                  ? StoneColor.white
                                  : StoneColor.black;
                        }),
                      },
                );
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
