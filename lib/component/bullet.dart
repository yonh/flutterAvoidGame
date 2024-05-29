import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Bullet {
  final Vector2 position;
  final double speed;
  final double angle;
  final double radius;
  late Paint paint = Paint()..color = Colors.orangeAccent;
  late Path path = Path()
    ..addOval(Rect.fromLTWH(
        position.x - radius, position.y - radius, radius * 2, radius * 2));

  Bullet(
      {required this.position,
      this.speed = 5,
      this.angle = 0,
      this.radius = 10});

  void render(Canvas canvas) {
    canvas.drawCircle(position.toOffset(), radius, paint);
  }

  void update(double dt) {
    position.setValues(
        position.x - cos(angle) * speed, position.y - sin(angle) * speed);
    path.reset();
    path.addOval(Rect.fromLTWH(
        position.x - radius, position.y - radius, radius * 2, radius * 2));
  }
}
