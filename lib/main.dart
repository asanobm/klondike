import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:klondike/widgets/foundation.dart';
import 'package:klondike/widgets/pile.dart';
import 'package:klondike/widgets/stock.dart';
import 'package:klondike/widgets/waste.dart';

void main() {
  final game = KlondikeGame();
  runApp(GameWidget(game: game));
}

class KlondikeGame extends FlameGame {
  static const double cardGap = 175.0;
  static const double cardWidth = 1000.0;
  static const double cardHeight = 1400.0;
  static const double cardRadius = 100.0;

  static final Vector2 cardSize = Vector2(cardWidth, cardHeight);

  @override
  Future<void> onLoad() async {
    // await Flame.images.load('klondike-sprites.png');

    final stock =
        Stock()
          ..size = cardSize
          ..position = Vector2(cardGap, cardGap);

    final waste =
        Waste()
          ..size = cardSize
          ..position = Vector2(cardGap * 2 + cardWidth, cardGap);

    final foundations = List.generate(
      4,
      (i) =>
          Foundation()
            ..size = cardSize
            ..position = Vector2(
              (i + 3) * (cardWidth + cardGap) + cardGap,
              cardGap,
            ),
    );

    final piles = List.generate(
      7,
      (i) =>
          Pile()
            ..size = cardSize
            ..position = Vector2(
              cardGap + i * (cardWidth + cardGap),
              cardHeight + 2 * cardGap,
            ),
    );

    world.add(stock);
    world.add(waste);
    world.addAll(foundations);
    world.addAll(piles);

    camera.viewfinder.visibleGameSize = Vector2(
      cardWidth * 7 + cardGap * 8,
      4 * cardHeight + 3 * cardGap,
    );
    camera.viewfinder.position = Vector2(cardWidth * 3.5 + cardGap * 4, 0);
    camera.viewfinder.anchor = Anchor.topCenter;
  }
}

Sprite klondikeSprite(double x, double y, double width, double height) {
  return Sprite(
    Flame.images.fromCache('klondike-sprites.png'),
    srcPosition: Vector2(x, y),
    srcSize: Vector2(width, height),
  );
}
