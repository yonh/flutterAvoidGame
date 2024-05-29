import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game01/component/player.dart';

class Rocket extends PositionComponent with CollisionCallbacks {
  final double speed;
  final double angle;
  final double radius;
  final Paint paint;

  late CircleHitbox hitbox;

  Rocket({
    required Vector2 position,
    this.speed = 15,
    this.angle = 0,
    this.radius = 10,
    Paint? paint,
  })  : paint = paint ?? Paint()
          ..color = Colors.red,
        super(position: position, size: Vector2.all(radius * 2)) {
    // Adjust the CircleHitbox to match the Rocket's size and position

    this.hitbox = CircleHitbox(radius: radius)
      ..position = Vector2(0, 0) // Center the hitbox within the rocket
      ..debugMode = true;
    add(hitbox);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Vector2(radius, radius).toOffset(), radius, paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    //
    // position += Vector2(cos(angle), sin(angle)) * speed * dt;
    position.setValues(
        position.x + cos(angle) * speed, position.y + sin(angle) * speed);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    // 打印自身的positon和碰撞区域的position
    print('Rocket position: $position');
    print('Rocket hitbox position: ${hitbox.position}');

    // 碰撞到玩家，销毁自身
    if (other is Player) {
      removeFromParent();
    }
  }
}
