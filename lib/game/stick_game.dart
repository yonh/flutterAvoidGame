import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../component/player.dart';

class StickGame extends FlameGame {
  final Paint paint = Paint()..color = const Color.fromARGB(255, 35, 36, 38);
  // final Paint paint = Paint()..color = Colors.blueGrey;
  final Path canvasPath = Path();
  late PlayerComponent player;

  @override
  Future<void>? onLoad() async {
    canvasPath.addRect(Rect.fromLTWH(0, 0, canvasSize.x, canvasSize.y));

    player =
        PlayerComponent(position: Vector2(canvasSize.x / 2, canvasSize.y / 2));

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawPath(canvasPath, paint);
    player.render(canvas);
  }
}
