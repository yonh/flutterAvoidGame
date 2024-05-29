import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game01/component/player.dart';

class MyCollidable extends PositionComponent with CollisionCallbacks {
  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is ScreenHitbox) {
      print('碰到了屏幕边界');
    } else if (other is Player) {
      print('碰到了玩家');
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is ScreenHitbox) {
      print('离开了屏幕边界');
    } else if (other is Player) {
      print('离开了玩家');
    }
  }
}
