import 'package:flutter/material.dart';

class DrawCircle extends StatefulWidget {
  const DrawCircle({super.key});

  @override
  State<DrawCircle> createState() => _DrawCircleState();
}

class _DrawCircleState extends State<DrawCircle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circles'),
      ),
      body: CustomPaint(
        painter: ShapePainter(),
        child: CustomPaint(
          painter: ShapePainter1(),
          child: CustomPaint(
            painter: ShapePainter2(),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.amber
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    var path = Path();

    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 150));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ShapePainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.amber
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    var path = Path();

    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 100));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ShapePainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.amber
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    var path = Path();

    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 50));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
