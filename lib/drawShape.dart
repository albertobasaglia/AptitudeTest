import 'package:flutter/material.dart';

class DrawShape extends CustomPainter {
  Color back = Color(0xffC3ACCE);
  @override
  void paint(Canvas canvas, Size size) {
    Path shape = Path()
      ..moveTo(0, size.height * 0.5)
      ..lineTo(size.width, size.height * 0.20)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height * 0.5);
    canvas.drawPath(
        shape,
        Paint()
          ..style = PaintingStyle.fill
          ..color = back
          ..isAntiAlias = true
          ..strokeWidth = 1.0);
    canvas.drawPath(
        shape,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.black
          ..isAntiAlias = true
          ..strokeWidth = 4.0);
    double firstVerticalX = (size.width / 3);
    double secondVerticalX = firstVerticalX * 2;
    double firstVerticalY = 80;
    double secondVerticalY = 60;

    //disegna tratteggi
    drawDots(canvas, firstVerticalX, firstVerticalY, 190);
    drawDots(canvas, secondVerticalX, secondVerticalY, 195);
  }

  void drawDots(
      Canvas canvas, double x, double fromY, double toY) {
    var dashWidth = 10;
    var dashSpace = 2;
    double startY = fromY;
    while (startY <= toY) {
      canvas.drawLine(Offset(x, startY), Offset(x, startY + dashWidth),
          Paint()..strokeWidth = 2);
      final space = (dashSpace + dashWidth);
      startY += space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
