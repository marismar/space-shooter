import 'dart:math';

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
    add(EnemyManager());
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }
}

class EnemyManager extends TimerComponent with HasGameRef<SpaceShooterGame> {
  static final _random = Random();

  EnemyManager() : super(period: 1, repeat: true);

  @override
  void onTick() {
    super.onTick();

    _spawnEnemy();
  }

  void _spawnEnemy() {
    final enemy = Enemy(
      initialPosition: Vector2(_random.nextDouble() * gameRef.size.x, 0),
    );

    gameRef.add(enemy);
  }
}

class Enemy extends SpriteComponent with HasGameRef<SpaceShooterGame> {
  static const _speed = 250;
  final Vector2 initialPosition;

  Enemy({required this.initialPosition});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('enemy.png');
    position = initialPosition;
    width = 50;
    height = 50;
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += _speed * dt;

    if (position.y > gameRef.size.y) {
      gameRef.remove(this);
    }
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
    anchor = Anchor.center;
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
