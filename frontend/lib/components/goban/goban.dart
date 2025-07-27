import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/components/goban/goban_painter.dart';
import 'package:frontend/components/goban/icon_text.dart';
import 'package:frontend/components/goban/single_stone.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/providers/goban_state_provider.dart';
import 'package:frontend/util/go_rule.dart';

class Goban extends ConsumerStatefulWidget {
  const Goban({super.key, this.isEditable = true, required this.provider});
  final bool isEditable;
  final StateNotifierProvider<GobanStateNotifier, GobanState> provider;

  @override
  ConsumerState<Goban> createState() => _GobanState();
}

class _GobanState extends ConsumerState<Goban> {
  StoneColor nextColor = StoneColor.black;
  Joseki joseki = Joseki([]);
  StoneMatrix stoneMatrix = getProcessedBoard([]);

  bool isOverMaxStones() {
    if (joseki.stoneList.length >= 99) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.error_max_stone)),
      );
      return true;
    }
    return false;
  }

  void onPressedCross(int x, int y) {
    if (!widget.isEditable) return;
    if (isOverMaxStones()) return;
    setState(() {
      if (!joseki.pushStone(color: nextColor, x: x, y: y)) {
        return;
      }
      nextColor = reversedColor(nextColor);
      ref.read(widget.provider.notifier).updateGoban(joseki);
    });
  }

  void onPressedBack() {
    setState(() {
      joseki.popStone();
      nextColor = reversedColor(nextColor);
      ref.read(widget.provider.notifier).updateGoban(joseki);
    });
  }

  void onPressedBack5() {
    setState(() {
      joseki.popStones(5);
      nextColor = reversedColor(nextColor);
      ref.read(widget.provider.notifier).updateGoban(joseki);
    });
  }

  void onPressedPass() {
    setState(() {
      nextColor = reversedColor(nextColor);
    });
  }

  void onPressedClear() {
    setState(() {
      joseki.clear();
      nextColor = StoneColor.black;
      ref.read(widget.provider.notifier).updateGoban(joseki);
    });
  }

  @override
  Widget build(BuildContext context) {
    final GobanState gobanState = ref.watch(widget.provider);
    final double sideBarWidth = MediaQuery.of(context).size.width * 0.15;
    setState(() {
      joseki = gobanState.joseki;
      stoneMatrix = gobanState.stoneMatrix;
    });
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
                          onPressed: () => onPressedCross(x, y),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: screenBoardSize,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: sideBarWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconText(
                  hintText: AppLocalizations.of(context)!.goban_back,
                  icon: Icons.keyboard_arrow_up,
                  onPressed: widget.isEditable ? onPressedBack : null,
                ),
                IconText(
                  hintText: AppLocalizations.of(context)!.goban_back5,
                  icon: Icons.keyboard_double_arrow_up,
                  onPressed: widget.isEditable ? onPressedBack5 : null,
                ),
                IconText(
                  hintText: AppLocalizations.of(context)!.goban_pass,
                  icon: Icons.repeat,
                  onPressed: widget.isEditable ? onPressedPass : null,
                ),
                IconText(
                  hintText: AppLocalizations.of(context)!.goban_clear,
                  icon: Icons.delete,
                  onPressed: widget.isEditable ? onPressedClear : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
