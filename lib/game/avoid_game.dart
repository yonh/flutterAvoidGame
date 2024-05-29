import 'dart:async';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../component/bullet.dart';
import '../component/player.dart';

class AvoidGame extends FlameGame {
  final Paint paint = Paint()..color = const Color.fromARGB(255, 35, 36, 38);
  // final Paint paint = Paint()..color = Colors.blueGrey;
  final Path canvasPath = Path();
  late Player player;
  final random = Random();
  late Timer timer;
  List<Bullet> bullets = [];

  @override
  Future<void>? onLoad() async {
    canvasPath.addRect(Rect.fromLTWH(0, 0, canvasSize.x, canvasSize.y));

    player = Player(
      radius: 20,
      color: Colors.blue,
    );
    add(player);

    // 每隔 1 秒创建一个子弹
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      createBullet();
    });

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // 绘制fps
    // final fps = fps().toStringAsFixed(2);
    // final textSpan = TextSpan(
    //   text: 'fps: $fps',
    //   style: TextStyle(color: Colors.white, fontSize: 20),
    // );

    // 绘制虚线（屏幕中间的横线和竖线）
    canvas.drawLine(Offset(0, canvasSize.y / 2),
        Offset(canvasSize.x, canvasSize.y / 2), paint);
    canvas.drawLine(Offset(canvasSize.x / 2, 0),
        Offset(canvasSize.x / 2, canvasSize.y), paint);

    super.render(canvas);

    // canvas.drawPath(canvasPath, paint);
    // player.render(canvas);
    //
    // 渲染所有的子弹
    for (var bullet in bullets) {
      bullet.render(canvas);
    }
  }

  // @override
  void update(double dt) {
    super.update(dt);

    // 更新所有的子弹
    for (var bullet in bullets) {
      bullet.update(dt);
    }

    print('bullets.length: ${bullets.length}');
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   canvas.drawPath(canvasPath, paint);
  //   player.render(canvas);
  // }

  void createBullet() {
    /// 随机半径
    var radius = random.nextInt(10) + 5;

    /// 计算位置
    /// 是否在水平方向上，即画布的顶部和底部
    bool isHorizontal = random.nextBool();
    int x = isHorizontal
        ? random.nextInt(canvasSize.x.toInt())
        : random.nextBool()
            ? radius
            : canvasSize.x.toInt() - radius;
    int y = isHorizontal
        ? random.nextBool()
            ? radius
            : canvasSize.y.toInt() - radius
        : random.nextInt(canvasSize.y.toInt());
    var position = Vector2(x.toDouble(), y.toDouble());

    /// 计算角度
    var angle = atan2(y - player.position.y, x - player.position.x);

    int seconds = random.nextInt(10);

    /// 计算速度
    var speed = seconds / 10 + 5;
    bullets.add(Bullet(
        position: position,
        angle: angle,
        radius: radius.toDouble(),
        speed: speed));
  }
}
