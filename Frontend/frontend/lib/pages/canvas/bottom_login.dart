import 'package:flutter/material.dart';

class TopArcPainterBottomLogin extends CustomPainter {
  final Color color;
  TopArcPainterBottomLogin({this.color = const Color(0XFF0F1F41)});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height - 390)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 510,
        size.width,
        size.height - 390,
      )
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TopArcPainterBottomLogin oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TopArcPainterBottomLogin oldDelegate) => false;
}