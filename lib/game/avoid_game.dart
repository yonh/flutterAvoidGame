import 'dart:async';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../component/bullet.dart';
import '../component/player.dart';

class AvoidGame extends FlameGame with HasCollisionDetection {
  final Paint paint = Paint()..color = const Color.fromARGB(255, 35, 36, 38);
  // final Paint paint = Paint()..color = Colors.blueGrey;
  final Path canvasPath = Path();
  late Player player;
  final random = Random();
  late Timer timer;
  // final SpeedController speedController;

  AvoidGame();

  List<Bullet> bullets = [];

  @override
  Future<void>? onLoad() async {
    canvasPath.addRect(Rect.fromLTWH(0, 0, canvasSize.x, canvasSize.y));

    player = Player(
      radius: 20,
      color: Colors.blue,
    );
    player.debugMode = true;
    add(player);

    // 每隔 1 秒创建一个子弹
    timer = Timer.periodic(const Duration(milliseconds: 10000), (timer) {
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
    // for (var bullet in bullets) {
    //   bullet.render(canvas);
    // }
  }

  // @override
  void update(double dt) {
    super.update(dt);

    // // 更新所有的子弹
    // for (var bullet in bullets) {
    //   bullet.update(dt);
    //
    //   // // 进行碰撞检测
    //   // if (collisionCheck(bullet)) {
    //   //   print('碰撞到 player');
    //   //
    //   //   // player受伤
    //   //   final originalColor = Colors.blue;
    //   //   print('originalColor: $originalColor');
    //   //   player.color = Colors.red;
    //   //
    //   //   // Change color back to original after 3 seconds
    //   //   Future.delayed(const Duration(seconds: 1), () {
    //   //     player.color = originalColor;
    //   //     print("player.color: ${player.color}");
    //   //   });
    //   // }
    // }
    //
    // bullets.removeWhere((bullet) => bullet.isOutOfBounds(canvasSize));

    // print('bullets.length: ${bullets.length}');
  }

  bool collisionCheck(Bullet bullet) {
    // 计算子弹和玩家之间的距离
    double distance = bullet.position.distanceTo(player.position);

    // 检查距离是否小于或等于子弹和玩家的半径之和
    return distance <= bullet.radius + player.radius;
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
    // var angle = atan2(y - player.position.y, x - player.position.x);

    /// 计算角度 偏移点为player绘制的中心点
    var angle = atan2(y - player.position.y - player.radius,
        x - player.position.x - player.radius);

    final speedController =
        Provider.of<SpeedController>(buildContext!, listen: false);

    final bullet = Bullet(
      position: position,
      angle: angle,
      radius: radius.toDouble(),
      speed: speedController.speed,
      showTrajectory: true,
    );
    // bullet.debugMode = true;
    add(bullet);
    // bullets.add(bullet);
  }

  @override
  void onRemove() {
    super.onRemove();
    // 取消定时器
    timer.cancel();
  }
}

class SpeedController extends ChangeNotifier {
  double _speed = 1.0;

  double get speed => _speed;

  set speed(double value) {
    _speed = value;
    notifyListeners();
  }
}
