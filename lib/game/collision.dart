import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Image;

import '../component/player.dart';

class CollisionDetectionGame extends FlameGame with HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    final emberPlayer = Player(
      radius: 20,
      color: Colors.blue,
    );
    add(emberPlayer);
    add(RectangleCollidable(canvasSize / 2));
  }
}

class RectangleCollidable extends PositionComponent with CollisionCallbacks {
  final _collisionStartColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  late ShapeHitbox hitbox;

  RectangleCollidable(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(200),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    // this.debugMode = true;
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);

    final a = RectangleHitbox.relative(
      Vector2(1.5, 0.5),
      position: Vector2(1, 0),
      // anchor: const Anchor(-1, 0),
      parentSize: size,
    )
      ..paint = debugPaint
      // ..debugMode = true
      ..renderShape = true;
    add(a);

    // 添加一个圆形碰撞区域
    var cHitBox = CircleHitbox();
    print(cHitBox);
    cHitBox
      ..position = Vector2(-111, -50)
      //   ..radius = 0.1
      ..size = Vector2(0.1, 0.1)
      // ..scale = Vector2(0.5, 0.5)
      ..renderShape = true
      ..debugColor = Colors.orange;
    add(cHitBox);
    print(cHitBox);

    // addAll(createHitBoxes());
  }

  List<RectangleHitbox> createHitBoxes() {
    return [
      RectangleHitbox.relative(
        Vector2(0.45, 0.35),
        position: Vector2(1, 0),
        anchor: const Anchor(-1, 0),
        parentSize: size,
      )
        ..paint = debugPaint
        ..debugMode = true
        ..renderShape = true
        ..debugColor = Colors.red,
      RectangleHitbox.relative(
        Vector2(0.66, 0.45),
        position: Vector2(4, 32),
        parentSize: size,
      ),
      RectangleHitbox.relative(
        Vector2(0.3, 0.15),
        position: Vector2(24, height - 16),
        parentSize: size,
      )
    ];
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    hitbox.paint.color = _collisionStartColor;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (!isColliding) {
      hitbox.paint.color = _defaultColor;
    }
  }
}
