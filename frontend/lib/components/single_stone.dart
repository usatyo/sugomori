import 'package:flutter/material.dart';
import 'package:frontend/model/joseki.dart';

class SingleStone extends StatefulWidget {
  const SingleStone({super.key, this.num, this.color});
  final int? num;
  final StoneColor? color;

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
            onPressed: () {},
            child: null,
          ),
          IgnorePointer(
            ignoring: true,
            child: Center(
              child: Text(
                "${widget.num ?? ""}",
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
