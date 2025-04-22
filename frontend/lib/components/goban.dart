import 'package:flutter/material.dart';
import 'package:frontend/components/goban_painter.dart';
import 'package:frontend/components/icon_text.dart';
import 'package:frontend/components/single_stone.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/util/go_rule.dart';

class Goban extends StatefulWidget {
  const Goban({super.key});

  @override
  State<Goban> createState() => _GobanState();
}

class _GobanState extends State<Goban> {
  Joseki joseki = Joseki([]);
  StoneMatrix stoneMatrix = getProcessedBoard([]);
  StoneColor nextColor = StoneColor.black;

  void refreshStoneMatrix() {
    setState(() {
      stoneMatrix = getProcessedBoard(joseki.stoneList);
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
                        int x = index ~/ 13;
                        int y = index % 13;
                        Stone stone = stoneMatrix[x][y];
                        return SingleStone(
                          index: stone.index,
                          color: stone.color,
                          onPressed:
                              () => {
                                setState(() {
                                  if (!joseki.pushStone(
                                    color: nextColor,
                                    x: x,
                                    y: y,
                                    isPassed: false,
                                  )) {
                                    return;
                                  }
                                  nextColor = reversedColor(nextColor);
                                  refreshStoneMatrix();
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
                      nextColor = reversedColor(nextColor);
                      refreshStoneMatrix();
                    });
                  },
                ),
                IconText(
                  hintText: "5手戻る",
                  icon: Icons.keyboard_double_arrow_up,
                  onPressed: () {
                    setState(() {
                      joseki.popStones(5);
                      nextColor = reversedColor(nextColor);
                      refreshStoneMatrix();
                    });
                  },
                ),
                IconText(
                  hintText: "手抜き",
                  icon: Icons.repeat,
                  onPressed: () {
                    setState(() {
                      if (!joseki.pushStone(
                        color: nextColor,
                        x: -1,
                        y: -1,
                        isPassed: true,
                      )) {
                        return;
                      }
                      nextColor = reversedColor(nextColor);
                      refreshStoneMatrix();
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
                      refreshStoneMatrix();
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
