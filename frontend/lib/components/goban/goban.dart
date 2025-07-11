import 'package:flutter/material.dart';
import 'package:frontend/components/goban/goban_painter.dart';
import 'package:frontend/components/goban/icon_text.dart';
import 'package:frontend/components/goban/single_stone.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/util/go_rule.dart';

class Goban extends StatefulWidget {
  const Goban({super.key, required this.joseki});
  final Joseki joseki;

  @override
  State<Goban> createState() => _GobanState();
}

class _GobanState extends State<Goban> {
  StoneMatrix stoneMatrix = getProcessedBoard([]);
  StoneColor nextColor = StoneColor.black;

  void refreshStoneMatrix() {
    setState(() {
      stoneMatrix = getProcessedBoard(widget.joseki.stoneList);
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
                      itemCount: screenBoardSize * screenBoardSize,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        int x = index ~/ screenBoardSize;
                        int y = index % screenBoardSize;
                        Stone stone = stoneMatrix[x][y];
                        return SingleStone(
                          index: stone.index,
                          color: stone.color,
                          onPressed:
                              () => {
                                setState(() {
                                  if (!widget.joseki.pushStone(
                                    color: nextColor,
                                    x: x,
                                    y: y,
                                  )) {
                                    return;
                                  }
                                  nextColor = reversedColor(nextColor);
                                  refreshStoneMatrix();
                                }),
                              },
                        );
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: screenBoardSize,
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
                  hintText: AppLocalizations.of(context)!.goban_back,
                  icon: Icons.keyboard_arrow_up,
                  onPressed: () {
                    setState(() {
                      widget.joseki.popStone();
                      nextColor = reversedColor(nextColor);
                      refreshStoneMatrix();
                    });
                  },
                ),
                IconText(
                  hintText: AppLocalizations.of(context)!.goban_back5,
                  icon: Icons.keyboard_double_arrow_up,
                  onPressed: () {
                    setState(() {
                      widget.joseki.popStones(5);
                      nextColor = reversedColor(nextColor);
                      refreshStoneMatrix();
                    });
                  },
                ),
                IconText(
                  hintText: AppLocalizations.of(context)!.goban_pass,
                  icon: Icons.repeat,
                  onPressed: () {
                    setState(() {
                      widget.joseki.pushStone(color: nextColor, x: -1, y: -1);
                      nextColor = reversedColor(nextColor);
                      refreshStoneMatrix();
                    });
                  },
                ),
                IconText(
                  hintText: AppLocalizations.of(context)!.goban_clear,
                  icon: Icons.delete,
                  onPressed: () {
                    setState(() {
                      widget.joseki.clear();
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
