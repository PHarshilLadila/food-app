// ignore_for_file: library_private_types_in_public_api

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShaderPainter extends CustomPainter {
  final ui.FragmentShader shader;
  final double time;

  ShaderPainter(this.shader, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..shader = shader;
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant ShaderPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}

class ShaderWidgetOne extends StatefulWidget {
  const ShaderWidgetOne({super.key});

  @override
  _ShaderWidgetOneState createState() => _ShaderWidgetOneState();
}

class _ShaderWidgetOneState extends State<ShaderWidgetOne>
    with SingleTickerProviderStateMixin {
  ui.FragmentShader? _shader;
  late AnimationController _controller;
  final O3DController o3dController = O3DController();
  String avatarUrl = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 50),
    )..repeat();
    getStored3DImage();
    _loadShader();
    setState(() {});
  }

  Future<void> getStored3DImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (mounted) {
      setState(() {
        avatarUrl = preferences.getString("finalThreeDImagePath") ?? '';
        debugPrint(
            'THIS IS THE 3D IMAGE URL from AVATAR URL :: :: :: $avatarUrl');
      });
    }
  }

  Future<void> _loadShader() async {
    final program = await ui.FragmentProgram.fromAsset('shaders/shadone.frag');
    if (mounted) {
      setState(() {
        _shader = program.fragmentShader();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _shader == null
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            height: MediaQuery.of(context).size.height / 1,
            width: double.infinity,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: ShaderPainter(_shader!, _controller.value * 2),
                  child: Center(
                    child: O3D(
                      src: avatarUrl,
                      controller: o3dController,
                      autoRotate: true,
                      ar: true,
                      arPlacement: ArPlacement.floor,
                      cameraControls: true,
                      loading: Loading.eager,
                    ),
                  ),
                );
              },
            ),
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
