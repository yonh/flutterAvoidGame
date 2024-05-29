import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent
    with DragCallbacks, HasGameRef, CollisionCallbacks {
  final double radius;
  final Paint _paint;

  Player({
    required this.radius,
    required Color color,
  })  : _paint = Paint()..color = color,
        super(size: Vector2.all(radius * 2));

  bool _isDragged = false;

  @override
  FutureOr<void> onLoad() {
    // 设置圆形的初始位置为游戏界面的中心
    position = gameRef.size / 2 - Vector2(radius, radius);

    // 添加矩形碰撞区
    RectangleHitbox rHitBox = RectangleHitbox();
    rHitBox
      ..debugMode = true
      ..debugColor = Colors.orange;
    add(rHitBox);

    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    _isDragged = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final newPosition = position + event.localDelta;

    if (newPosition.x < 0 ||
        newPosition.x > gameRef.size.x - radius * 2 ||
        newPosition.y < 0 ||
        newPosition.y > gameRef.size.y - radius * 2) {
      return;
    }
    position += event.localDelta;

    // final newPosition = position + event.delta;
    // final halfSize = size / 2;

    // // 边界检查，确保圆形不会拖出屏幕边缘
    // final clampedX = newPosition.x.clamp(0.0, gameRef.size.x - size.x);
    // final clampedY = newPosition.y.clamp(0.0, gameRef.size.y - size.y);
    //
    // position.setValues(clampedX, clampedY);
    // 边界检查，确保圆形不会拖出屏幕边缘

    // if (newPosition.x >= 0 &&
    //     newPosition.y >= 0 &&
    //     newPosition.x <= gameRef.size.x - size.x &&
    //     newPosition.y <= gameRef.size.y - size.y) {
    //   position.setValues(newPosition.x, newPosition.y);
    // }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _isDragged = false;
  }

  @override
  void render(Canvas canvas) {
    _paint.color = _isDragged ? Colors.yellow : Colors.red;
    canvas.drawCircle(Offset(radius, radius), radius, _paint);
  }

  // @override
  // void render(Canvas canvas) {
  //   // 检查圆形的位置是否在游戏界面内
  //   final clampedX = position.x.clamp(0.0, gameRef.size.x - size.x);
  //   final clampedY = position.y.clamp(0.0, gameRef.size.y - size.y);
  //
  //   // 如果圆形的位置超出了游戏界面，那么将圆形的位置调整到游戏边界内
  //   position.setValues(clampedX, clampedY);
  //
  //   _paint.color = _isDragged ? Colors.red : _paint.color;
  //   canvas.drawCircle(Offset(radius, radius), radius, _paint);
  // }

  @override
  bool containsLocalPoint(Vector2 point) {
    final center = size / 2;
    return (point - center).length < radius;
  }
}
