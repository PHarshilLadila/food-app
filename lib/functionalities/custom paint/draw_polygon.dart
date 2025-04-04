import 'dart:math' as math;

import 'package:flutter/material.dart';

class DrawPolygon extends StatefulWidget {
  const DrawPolygon({super.key});

  @override
  State<DrawPolygon> createState() => _DrawPolygonState();
}

class _DrawPolygonState extends State<DrawPolygon> {
  var sides = 3.0;
  int radius = 5;
  var radians = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polygons'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomPaint(
                painter: ShapePainter(sides, radius, radians),
                child: Container(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text("Sides"),
            ),
            Slider(
              value: sides,
              min: 3.0,
              max: 10.0,
              divisions: 7,
              label: sides.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  sides = value;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text("Size"),
            ),
            Slider(
              value: radius.toDouble(),
              min: 5,
              max: MediaQuery.of(context).size.width / 2,
              divisions: 7,
              label: sides.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  radius = value.toInt();
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Rotation'),
            ),
            Slider(
              value: radians,
              min: 0.0,
              max: math.pi,
              onChanged: (value) {
                setState(() {
                  radians = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final double sides;
  final int radius;
  final double radians;

  const ShapePainter(
    this.sides,
    this.radius,
    this.radians,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var path = Path();
    var angle = (math.pi * 2) / sides;

    Offset center = Offset(size.width / 2, size.height / 2);
    Offset startPoint =
        Offset(radius * math.cos(radians), radius * math.sin(radians));

    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

    for (int i = 1; i <= sides; i++) {
      double x = radius * math.cos(radians + angle * i) * center.dx;
      double y = radius * math.sin(radians + angle * i) * center.dy;
      path.lineTo(x, y);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
