import 'package:flutter/material.dart';

class TopArcPainterBottom extends CustomPainter {
  final Color color;
  TopArcPainterBottom({this.color = const Color(0XFF0F1F41)});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height - 180)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 300,
        size.width,
        size.height - 180,
      )
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TopArcPainterBottom oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TopArcPainterBottom oldDelegate) => false;
}