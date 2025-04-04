import 'dart:math' as math;
import 'package:flutter/material.dart';

class MyPainter extends StatefulWidget {
  const MyPainter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyPainterState createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> with TickerProviderStateMixin {
  var _sides = 3.0;

  Animation<double>? animation;
  AnimationController? controller;

  Animation<double>? animation2;
  AnimationController? controller2;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    Tween<double> radiusTween = Tween(begin: 0.0, end: 200);
    Tween<double> rotationTween = Tween(begin: -math.pi, end: math.pi);

    animation = rotationTween.animate(controller!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller?.reverse(); // Reverse the animation instead of repeating
        } else if (status == AnimationStatus.dismissed) {
          controller?.forward(); // Continue forward after reverse completes
        }
      });

    animation2 = radiusTween.animate(controller2!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2?.reverse(); // Reverse the animation instead of repeating
        } else if (status == AnimationStatus.dismissed) {
          controller2?.forward(); // Continue forward after reverse completes
        }
      });

    controller?.forward();
    controller2?.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    controller2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polygons'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: AnimatedBuilder(
                animation: animation!,
                builder: (context, snapshot) {
                  return CustomPaint(
                    painter: ShapePainter(
                        _sides, animation2!.value, animation!.value),
                    child: Container(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text('Sides, ${_sides.toInt()}'),
            ),
            Slider(
              value: _sides,
              min: 3.0,
              max: 25.0,
              label: _sides.toInt().toString(),
              divisions: 7,
              onChanged: (value) {
                setState(() {
                  _sides = value;
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
  final double radius;
  final double radians;
  ShapePainter(this.sides, this.radius, this.radians);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    var path = Path();

    var angle = (math.pi * 2) / sides;

    Offset center = Offset(size.width / 2, size.height / 2);
    Offset startPoint =
        Offset(radius * math.cos(radians), radius * math.sin(radians));

    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

    for (int i = 1; i <= sides; i++) {
      double x = radius * math.cos(radians + angle * i) + center.dx;
      double y = radius * math.sin(radians + angle * i) + center.dy;
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
