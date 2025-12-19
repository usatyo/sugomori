import 'package:flutter/material.dart';
import 'package:frontend/models/joseki.dart';

class GobanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Color(0xffebd480),
    );

    final double gridSize = size.width / screenBoardSize;

    for (int x = 3; x < 19; x += 6) {
      for (int y = 3; y < 19; y += 6) {
        canvas.drawCircle(
          Offset(gridSize / 2 + gridSize * x, gridSize / 2 + gridSize * y),
          2,
          Paint()..color = Colors.black,
        );
      }
    }

    for (int i = 0; i < screenBoardSize; i++) {
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
