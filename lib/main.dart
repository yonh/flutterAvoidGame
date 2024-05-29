import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game/avoid_game.dart';

void main() {
  // runApp(GameWidget(game: CollisionDetectionGame()));

  runApp(
    ChangeNotifierProvider(
      create: (context) => SpeedController(),
      child: MyApp(),
    ),
  );
}

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => SpeedController(),
//       child: MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(
              game: AvoidGame(),
            ),
            Positioned(
              top: 0,
              left: 20,
              right: 20,
              child: SpeedSlider(),
            ),
          ],
        ),
      ),
    );
  }
}

class SpeedSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final speedController = Provider.of<SpeedController>(context);

    return Column(
      children: [
        Text(
          'Bullet Speed: ${speedController.speed.toStringAsFixed(1)}',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        Slider(
          value: speedController.speed,
          min: 0.1,
          max: 10.0,
          onChanged: (value) {
            speedController.speed = value;
          },
        ),
      ],
    );
  }
}
