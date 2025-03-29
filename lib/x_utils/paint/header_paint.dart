import 'package:flutter/material.dart';

class HeaderCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(0,0);
    path_0.lineTo(size.width,0);
    path_0.lineTo(size.width,size.height-50);
    path_0.cubicTo(size.width,size.height*0.8863655,size.width*0.9426000,size.height,size.width*0.8717949,size.height);
    path_0.lineTo(size.width*0.1282051,size.height);
    path_0.cubicTo(size.width*0.05739949,size.height,0,size.height*0.8863655,0,size.height-50);
    path_0.lineTo(0,0);
    path_0.close();
    //
    // Path path_0 = Path();
    // path_0.moveTo(0,0);
    // path_0.lineTo(390,0);
    // path_0.lineTo(390,147);
    // path_0.cubicTo(390,174.614,367.614,197,340,197);
    // path_0.lineTo(50,197);
    // path_0.cubicTo(22.3858,197,0,174.614,0,147);
    // path_0.lineTo(0,0);
    // path_0.close();
    Paint paint0Fill = Paint()..style=PaintingStyle.fill;
    paint0Fill.color = const Color(0xff2A5E95).withOpacity(1.0);
    canvas.drawPath(path_0,paint0Fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}