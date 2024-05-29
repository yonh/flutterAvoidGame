import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class PlayerComponent {
  final Vector2 position;
  final double radius;
  late Paint paint = Paint()..color = Colors.greenAccent;

  PlayerComponent({required this.position, this.radius = 20});

  void render(Canvas canvas) {
    canvas.drawCircle(position.toOffset(), radius, paint);
  }
}
