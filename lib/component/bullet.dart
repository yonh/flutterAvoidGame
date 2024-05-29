import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

class Bullet extends PositionComponent {
  //final Vector2 position;
  final double speed;
  final double angle;
  final double radius;
  final bool showTrajectory;
  late Paint paint = Paint()..color = Colors.orangeAccent;
  late Path path = Path()
    ..addOval(Rect.fromLTWH(
        position.x - radius, position.y - radius, radius * 2, radius * 2));

  // 存储子弹的运行轨迹
  List<Vector2> trajectory = [];

  Bullet({
    required Vector2 position,
    this.speed = 5,
    this.angle = 0,
    this.radius = 10,
    this.showTrajectory = false,
  }) : super(position: position);

  void render(Canvas canvas) {
    canvas.drawCircle(position.toOffset(), radius, paint);

    // 绘制子弹的运行轨迹
    if (showTrajectory) {
      renderTrajectory(canvas);
    }
  }

  void renderTrajectory(Canvas canvas) {
    final paint = Paint()
      // ..color = Colors.orangeAccent.withOpacity(0.5)
      ..color = Colors.red.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var i = 0; i < trajectory.length - 1; i++) {
      canvas.drawLine(
          trajectory[i].toOffset(), trajectory[i + 1].toOffset(), paint);
    }
  }

  void update(double dt) {
    position.setValues(
        position.x - cos(angle) * speed, position.y - sin(angle) * speed);
    path.reset();
    path.addOval(Rect.fromLTWH(
        position.x - radius, position.y - radius, radius * 2, radius * 2));

    // 将新的位置添加到轨迹中
    trajectory.add(position.clone());
  }

  bool isOutOfBounds(Vector2 canvasSize) {
    return position.x < -radius ||
        position.x > canvasSize.x + radius ||
        position.y < -radius ||
        position.y > canvasSize.y + radius;
  }
}
