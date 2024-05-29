import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

class Bullet extends PositionComponent {
  //final Vector2 position;
  final double speed;
  final double angle;
  final double radius;
  late Paint paint = Paint()..color = Colors.orangeAccent;
  late Path path = Path()
    ..addOval(Rect.fromLTWH(
        position.x - radius, position.y - radius, radius * 2, radius * 2));

  Bullet({
    required Vector2 position,
    this.speed = 5,
    this.angle = 0,
    this.radius = 10,
  }) : super(position: position);

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

  bool isOutOfBounds(Vector2 canvasSize) {
    return position.x < -radius ||
        position.x > canvasSize.x + radius ||
        position.y < -radius ||
        position.y > canvasSize.y + radius;
  }
}
