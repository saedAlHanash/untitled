import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -27.10819, size.height * -13.33738);
    path_0.lineTo(size.width * -27.99708, size.height * -13.33738);
    path_0.arcToPoint(Offset(size.width * -28.02632, size.height * -13.35265),
        radius: Radius.elliptical(size.width * 0.02927485, size.height * 0.01528547),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * -28.02632, size.height * -13.62475);
    path_0.arcToPoint(Offset(size.width * -27.97657, size.height * -13.63489),
        radius: Radius.elliptical(size.width * 0.07217836, size.height * 0.03768697),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.arcToPoint(Offset(size.width * -27.95594, size.height * -13.65934),
        radius: Radius.elliptical(size.width * 0.06391228, size.height * 0.03337094),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.cubicTo(
        size.width * -27.95594,
        size.height * -13.67841,
        size.width * -27.98751,
        size.height * -13.69393,
        size.width * -28.02631,
        size.height * -13.69393);
    path_0.lineTo(size.width * -28.02631, size.height * -14.29463);
    path_0.arcToPoint(Offset(size.width * -27.99707, size.height * -14.30990),
        radius: Radius.elliptical(size.width * 0.02927485, size.height * 0.01528547),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * -27.10818, size.height * -14.30990);
    path_0.arcToPoint(Offset(size.width * -27.07894, size.height * -14.29463),
        radius: Radius.elliptical(size.width * 0.02927193, size.height * 0.01528395),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * -27.07894, size.height * -13.69393);
    path_0.arcToPoint(Offset(size.width * -27.12868, size.height * -13.68379),
        radius: Radius.elliptical(size.width * 0.07216959, size.height * 0.03768239),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.arcToPoint(Offset(size.width * -27.14932, size.height * -13.65934),
        radius: Radius.elliptical(size.width * 0.06391520, size.height * 0.03337247),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.cubicTo(
        size.width * -27.14932,
        size.height * -13.64026,
        size.width * -27.11774,
        size.height * -13.62475,
        size.width * -27.07895,
        size.height * -13.62475);
    path_0.lineTo(size.width * -27.07895, size.height * -13.35265);
    path_0.arcToPoint(Offset(size.width * -27.10819, size.height * -13.33738),
        radius: Radius.elliptical(size.width * 0.02927193, size.height * 0.01528395),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

