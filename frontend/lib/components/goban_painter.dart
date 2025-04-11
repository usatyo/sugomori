import 'package:flutter/material.dart';

class GobanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Color(0xffebd480),
    );

    final double gridSize = size.width / 13;

    canvas.drawCircle(
      Offset(gridSize / 2 + gridSize * 3, gridSize / 2 + gridSize * 3),
      2,
      Paint()..color = Colors.black,
    );
    canvas.drawCircle(
      Offset(gridSize / 2 + gridSize * 3, gridSize / 2 + gridSize * 9),
      2,
      Paint()..color = Colors.black,
    );
    canvas.drawCircle(
      Offset(gridSize / 2 + gridSize * 9, gridSize / 2 + gridSize * 3),
      2,
      Paint()..color = Colors.black,
    );
    canvas.drawCircle(
      Offset(gridSize / 2 + gridSize * 9, gridSize / 2 + gridSize * 9),
      2,
      Paint()..color = Colors.black,
    );

    for (int i = 0; i < 13; i++) {
      final double x = gridSize * i + gridSize / 2;
      final double y = gridSize * i + gridSize / 2;

      // Draw horizontal lines
      canvas.drawLine(
        Offset(gridSize / 2, y),
        Offset(size.width, y),
        Paint()..color = Colors.black,
      );
      // Draw vertical lines
      canvas.drawLine(
        Offset(x, gridSize / 2),
        Offset(x, size.height),
        Paint()..color = Colors.black,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
