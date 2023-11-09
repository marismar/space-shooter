import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class SpaceShooterGame extends FlameGame with PanDetector {
  late Player player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    player = Player();
    add(player);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }
}

class Player extends SpriteComponent with HasGameRef<SpaceShooterGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('space_shooter_player.png');
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    width = 50;
    height = 50;
    anchor = Anchor.bottomCenter;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}

void main() {
  runApp(GameWidget(
    game: SpaceShooterGame(),
  ));
}
