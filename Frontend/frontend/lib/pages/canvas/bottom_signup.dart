import 'package:flutter/material.dart';

class TopArcPainterBottomSignup extends CustomPainter {
  final Color color;
  TopArcPainterBottomSignup({this.color = const Color(0XFF0F1F41)});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height - 490)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 610,
        size.width,
        size.height - 490,
      )
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TopArcPainterBottomSignup oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TopArcPainterBottomSignup oldDelegate) => false;
}