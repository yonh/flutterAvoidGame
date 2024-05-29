import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:game01/component/player.dart';

class Bullet extends PositionComponent with CollisionCallbacks {
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
  }) : super(position: position, size: Vector2.all(radius * 2));

  @override
  FutureOr<void> onLoad() {
    // 添加矩形碰撞区
    RectangleHitbox rHitBox = RectangleHitbox();
    rHitBox
      ..position = position
      ..debugMode = true
      // ..renderShape = true
      ..debugColor = Colors.red;
    add(rHitBox);

    return super.onLoad();
  }

  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(position.toOffset(), radius, paint);

    // // 绘制子弹的碰撞检测区域
    // final collisionAreaPaint = Paint()
    //   ..color = Colors.red
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2;
    // canvas.drawCircle(position.toOffset(), radius, collisionAreaPaint);

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

  // // 碰撞检测
  // bool collidesWith(Player player) {
  //   // 获取子弹的中心点
  //   final pos = Vector2(this.position.x + radius, this.position.y + radius);
  //   // 获取player 的中心点
  //   final playerPos = Vector2(
  //       player.position.x + player.radius, player.position.y + player.radius);
  //
  //   // 计算子弹和玩家中心点之间的距离
  //   double distance = pos.distanceTo(playerPos);
  //   // 检查距离是否小于或等于子弹和玩家的半径之和
  //   return distance <= radius + player.radius;
  //
  //   // // 计算子弹和玩家中心点之间的距离
  //   // double distance = position.distanceTo(player.position) - player.radius;
  //   //
  //   // if (distance <= radius) {
  //   //   print('碰撞到 player.position: ${player.position}');
  //   //   print('碰撞到 player.radius: ${player.radius}');
  //   //   print('碰撞到 player.distance: $distance');
  //   // }
  //   // // 检查距离是否小于或等于子弹和玩家的半径之和
  //   // return distance <= radius;
  // }
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    // 碰撞到玩家，销毁自身
    if (other is Player) {
      removeFromParent();
    }
  }
}
