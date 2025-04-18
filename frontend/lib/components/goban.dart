import 'package:flutter/material.dart';
import 'package:frontend/components/goban_painter.dart';
import 'package:frontend/components/icon_text.dart';
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
  void reverseColor() {
    setState(() {
      nextColor =
          (nextColor == StoneColor.black) ? StoneColor.white : StoneColor.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: InteractiveViewer(
                panEnabled: false,
                child: Stack(
                  children: [
                    CustomPaint(size: Size.infinite, painter: GobanPainter()),
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
                                  reverseColor();
                                }),
                              },
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 13,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconText(
                  hintText: "1手戻る",
                  icon: Icons.keyboard_arrow_up,
                  onPressed: () {
                    setState(() {
                      joseki.popStone();
                      reverseColor();
                    });
                  },
                ),
                IconText(
                  hintText: "5手戻る",
                  icon: Icons.keyboard_double_arrow_up,
                  onPressed: () {
                    setState(() {
                      joseki.popStones(5);
                      reverseColor();
                    });
                  },
                ),
                IconText(
                  hintText: "手抜き",
                  icon: Icons.repeat,
                  onPressed: () {
                    setState(() {
                      reverseColor();
                    });
                  },
                ),
                IconText(
                  hintText: "クリア",
                  icon: Icons.delete,
                  onPressed: () {
                    setState(() {
                      joseki.clear();
                      nextColor = StoneColor.black;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
