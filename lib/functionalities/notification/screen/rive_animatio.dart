import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MyRiveAnimation extends StatefulWidget {
  const MyRiveAnimation({super.key});

  @override
  State<MyRiveAnimation> createState() => _MyRiveAnimationState();
}

class _MyRiveAnimationState extends State<MyRiveAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rive Animation"),
      ),
      body: const Center(
        child: RiveAnimation.asset(
          "assets/rive/foodriv.riv",
        ),
      ),
    );
  }
}
