import 'package:flutter/material.dart';

class TopArcPainterTop extends CustomPainter {
  final Color color;
  TopArcPainterTop({this.color = const Color(0xFFEBEAEA)});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height - 100)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 220,
        size.width,
        size.height - 100,
      )
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TopArcPainterTop oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TopArcPainterTop oldDelegate) => false;
}