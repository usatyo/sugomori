import 'package:flutter/material.dart';
import 'package:frontend/models/joseki.dart';

class SingleStone extends StatefulWidget {
  const SingleStone({
    super.key,
    required this.index,
    required this.color,
    required this.onPressed,
  });
  final int index;
  final StoneColor color;
  final void Function() onPressed;

  @override
  State<SingleStone> createState() => _SingleStoneState();
}

class _SingleStoneState extends State<SingleStone> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: Stack(
        children: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor:
                  widget.color == StoneColor.empty
                      ? Colors.transparent
                      : widget.color == StoneColor.black
                      ? Colors.black
                      : Colors.white,
            ),
            onPressed: () => widget.onPressed(),
            child: null,
          ),
          IgnorePointer(
            ignoring: true,
            child: Center(
              child: Text(
                "${widget.index == -1 ? "" : widget.index + 1}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      widget.color == StoneColor.black
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
