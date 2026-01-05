import 'package:flutter/widgets.dart';

class GeminiIcon extends StatelessWidget {
  const GeminiIcon({
    required this.color,
    super.key,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.square(28),
      painter: _Painter(color: color),
    );
  }
}

class _Painter extends CustomPainter {
  const _Painter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(13.667, 25.333)
      ..arcToPoint(
        const Offset(13.346, 25.217),
        radius: const Radius.elliptical(0.5, 0.5),
      )
      ..arcToPoint(
        const Offset(13.142, 24.924999999999997),
        radius: const Radius.elliptical(0.6, 0.6),
      )
      ..arcToPoint(
        const Offset(11.654, 21.249999999999996),
        radius: const Radius.elliptical(14.4, 14.4),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(9.234, 18.099999999999998),
        radius: const Radius.elliptical(15, 15),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(6.084, 15.679999999999998),
        radius: const Radius.elliptical(15, 15),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(2.4079999999999995, 14.191999999999998),
        radius: const Radius.elliptical(14.4, 14.4),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(2.1169999999999995, 13.987999999999998),
        radius: const Radius.elliptical(0.6, 0.6),
      )
      ..arcToPoint(
        const Offset(2.1169999999999995, 13.345999999999998),
        radius: const Radius.elliptical(0.5, 0.5),
      )
      ..arcToPoint(
        const Offset(2.4079999999999995, 13.141999999999998),
        radius: const Radius.elliptical(0.6, 0.6),
      )
      ..arcToPoint(
        const Offset(6.082999999999999, 11.653999999999998),
        radius: const Radius.elliptical(14.4, 14.4),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(9.232999999999999, 9.233999999999998),
        radius: const Radius.elliptical(15, 15),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(11.653999999999998, 6.083999999999998),
        radius: const Radius.elliptical(15, 15),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(13.141999999999998, 2.4079999999999977),
        radius: const Radius.elliptical(14.4, 14.4),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(13.345999999999998, 2.1169999999999978),
        radius: const Radius.elliptical(0.6, 0.6),
      )
      ..arcToPoint(
        const Offset(13.665999999999999, 1.9999999999999978),
        radius: const Radius.elliptical(0.5, 0.5),
      )
      ..quadraticBezierTo(
        13.841999999999999,
        1.9999999999999978,
        13.972999999999999,
        2.1169999999999978,
      )
      ..quadraticBezierTo(
        14.103,
        2.232999999999998,
        14.162999999999998,
        2.4079999999999977,
      )
      ..quadraticBezierTo(
        14.687999999999999,
        4.362999999999998,
        15.678999999999998,
        6.0829999999999975,
      )
      ..arcToPoint(
        const Offset(18.099999999999998, 9.232999999999997),
        radius: const Radius.elliptical(15, 15),
        clockwise: false,
      )
      ..quadraticBezierTo(
        19.529999999999998,
        10.662999999999997,
        21.249999999999996,
        11.653999999999996,
      )
      ..arcToPoint(
        const Offset(24.924999999999997, 13.141999999999996),
        radius: const Radius.elliptical(14.4, 14.4),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(25.217, 13.345999999999997),
        radius: const Radius.elliptical(0.6, 0.6),
      )
      ..arcToPoint(
        const Offset(25.217, 13.987999999999996),
        radius: const Radius.elliptical(0.5, 0.5),
      )
      ..arcToPoint(
        const Offset(24.924999999999997, 14.191999999999997),
        radius: const Radius.elliptical(0.6, 0.6),
      )
      ..arcToPoint(
        const Offset(21.249999999999996, 15.678999999999997),
        radius: const Radius.elliptical(14.4, 14.4),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(18.1, 18.1),
        radius: const Radius.elliptical(15, 15),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(15.680000000000001, 21.25),
        radius: const Radius.elliptical(15, 15),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(14.192000000000002, 24.925),
        radius: const Radius.elliptical(14.4, 14.4),
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(13.988000000000001, 25.217000000000002),
        radius: const Radius.elliptical(0.6, 0.6),
      )
      ..arcToPoint(
        const Offset(13.667000000000002, 25.333000000000002),
        radius: const Radius.elliptical(0.5, 0.5),
      );

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.fill
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) {
    return oldDelegate.color != color;
  }
}
