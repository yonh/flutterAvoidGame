// import 'package:flutter/material.dart';
//
// import '../game/avoid_game.dart';
//
// class GameUI extends StatefulWidget {
//   final AvoidGame game;
//
//   GameUI(this.game);
//
//   @override
//   _GameUIState createState() => _GameUIState();
// }
//
// class _GameUIState extends State<GameUI> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         // ... existing code ...
//
//         // 添加一个 Slider 组件来修改 speed 属性
//         Slider(
//           value: widget.game.speed,
//           min: 0.1,
//           max: 10.0,
//           onChanged: (double value) {
//             setState(() {
//               widget.game.speed = value;
//             });
//           },
//         ),
//
//         // ... existing code ...
//       ],
//     );
//   }
// }
