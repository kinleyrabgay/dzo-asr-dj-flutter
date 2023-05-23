import 'package:flutter/material.dart';

class TopArcPainterCenter extends CustomPainter {
  final Color color;
  TopArcPainterCenter({this.color = const Color(0xFFD9D8D8)});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height - 110)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 230,
        size.width,
        size.height - 110,
      )
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TopArcPainterCenter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TopArcPainterCenter oldDelegate) => false;
}