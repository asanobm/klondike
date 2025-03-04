/// @flame 게임 엔진을 사용하여 카드 게임의 카드를 표현하는 컴포넌트입니다.
/// 각 카드는 숫자(rank)와 무늬(suit)를 가지며 앞면/뒷면을 표시할 수 있습니다.
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:klondike/data/rank.dart';
import 'package:klondike/data/suit.dart';
import 'package:klondike/klondike_game.dart';

class Card extends PositionComponent {
  /// 카드 생성자 - 숫자와 무늬를 정수로 받아 초기화합니다
  Card(int intRank, int intSuit)
    : rank = Rank.fromInt(intRank),
      suit = Suit.fromInt(intSuit),
      _faceUp = false,
      super(size: KlondikeGame.cardSize);

  final Rank rank; // 카드의 숫자 (A,2,3,...,J,Q,K)
  final Suit suit; // 카드의 무늬 (스페이드, 하트, 다이아몬드, 클럽)
  bool _faceUp; // 카드가 앞면인지 여부

  bool get isFaceUp => _faceUp;

  /// 카드를 뒤집는 메서드
  void flip() => _faceUp = !_faceUp;

  @override
  String toString() => rank.label + suit.label; // 예: "Q♠" 또는 "10♦"

  @override
  /// @flame Canvas에 카드를 그리는 메서드
  /// 앞면/뒷면 상태에 따라 다른 렌더링을 수행합니다
  void render(Canvas canvas) {
    if (_faceUp) {
      _renderFront(canvas);
    } else {
      _renderBack(canvas);
    }
  }

  /// 카드 뒷면 디자인을 위한 Paint 객체들
  static final Paint backBackgroundPaint =
      Paint()..color = const Color(0xff380c02);
  static final Paint backBorderPaint1 =
      Paint()
        ..color = const Color(0xffdbaf58)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10;
  static final Paint backBorderPaint2 =
      Paint()
        ..color = const Color(0x5CEF971B)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 35;

  /// 카드의 모서리가 둥근 사각형 모양 정의
  static final RRect cardRRect = RRect.fromRectAndRadius(
    KlondikeGame.cardSize.toRect(),
    const Radius.circular(KlondikeGame.cardRadius),
  );
  static final RRect backRRectInner = cardRRect.deflate(40);
  static final Sprite flameSprite = klondikeSprite(1367, 6, 357, 501);

  /// @flame 카드 뒷면을 그리는 메서드
  /// 배경색, 테두리, Flame 로고를 그립니다
  void _renderBack(Canvas canvas) {
    canvas.drawRRect(cardRRect, backBackgroundPaint);
    canvas.drawRRect(cardRRect, backBorderPaint1);
    canvas.drawRRect(backRRectInner, backBorderPaint2);
    flameSprite.render(canvas, position: size / 2, anchor: Anchor.center);
  }

  /// 카드 앞면 디자인을 위한 Paint 객체들
  static final Paint frontBackgroundPaint =
      Paint()..color = const Color(0xff000000);
  static final Paint redBorderPaint =
      Paint()
        ..color = const Color(0xffece8a3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10;
  static final Paint blackBorderPaint =
      Paint()
        ..color = const Color(0xff7ab2e8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10;
  static final blueFilter =
      Paint()
        ..colorFilter = const ColorFilter.mode(
          Color(0x880d8bff),
          BlendMode.srcATop,
        );

  /// J,Q,K 카드를 위한 이미지 스프라이트 정의
  static final Sprite redJack = klondikeSprite(81, 565, 562, 488);
  static final Sprite redQueen = klondikeSprite(717, 541, 486, 515);
  static final Sprite redKing = klondikeSprite(1305, 532, 407, 549);
  static final Sprite blackJack = klondikeSprite(81, 565, 562, 488)
    ..paint = blueFilter;
  static final Sprite blackQueen = klondikeSprite(717, 541, 486, 515)
    ..paint = blueFilter;
  static final Sprite blackKing = klondikeSprite(1305, 532, 407, 549)
    ..paint = blueFilter;

  /// @flame 카드 앞면을 그리는 메서드
  /// 숫자와 무늬에 따라 적절한 디자인을 그립니다
  void _renderFront(Canvas canvas) {
    canvas.drawRRect(cardRRect, frontBackgroundPaint);
    canvas.drawRRect(cardRRect, suit.isRed ? redBorderPaint : blackBorderPaint);

    final rankSprite = suit.isBlack ? rank.blackSprite : rank.redSprite;
    final suitSprite = suit.sprite;
    _drawSprite(canvas, rankSprite, 0.1, 0.08);
    _drawSprite(canvas, suitSprite, 0.1, 0.18, scale: 0.5);
    _drawSprite(canvas, rankSprite, 0.1, 0.08, rotate: true);
    _drawSprite(canvas, suitSprite, 0.1, 0.18, scale: 0.5, rotate: true);

    // 카드 숫자에 따라 무늬 배치를 다르게 합니다
    switch (rank.value) {
      case 1: // Ace
        _drawSprite(canvas, suitSprite, 0.5, 0.5, scale: 2.5);
      case 2:
        _drawSprite(canvas, suitSprite, 0.5, 0.25);
        _drawSprite(canvas, suitSprite, 0.5, 0.25, rotate: true);
      case 3:
        _drawSprite(canvas, suitSprite, 0.5, 0.2);
        _drawSprite(canvas, suitSprite, 0.5, 0.5);
        _drawSprite(canvas, suitSprite, 0.5, 0.2, rotate: true);
      case 4:
        _drawSprite(canvas, suitSprite, 0.3, 0.25);
        _drawSprite(canvas, suitSprite, 0.7, 0.25);
        _drawSprite(canvas, suitSprite, 0.3, 0.25, rotate: true);
        _drawSprite(canvas, suitSprite, 0.7, 0.25, rotate: true);
      case 5:
        _drawSprite(canvas, suitSprite, 0.3, 0.25);
        _drawSprite(canvas, suitSprite, 0.7, 0.25);
        _drawSprite(canvas, suitSprite, 0.3, 0.25, rotate: true);
        _drawSprite(canvas, suitSprite, 0.7, 0.25, rotate: true);
        _drawSprite(canvas, suitSprite, 0.5, 0.5);
      case 6:
        _drawSprite(canvas, suitSprite, 0.3, 0.25);
        _drawSprite(canvas, suitSprite, 0.7, 0.25);
        _drawSprite(canvas, suitSprite, 0.3, 0.5);
        _drawSprite(canvas, suitSprite, 0.7, 0.5);
        _drawSprite(canvas, suitSprite, 0.3, 0.25, rotate: true);
        _drawSprite(canvas, suitSprite, 0.7, 0.25, rotate: true);
      case 7:
        _drawSprite(canvas, suitSprite, 0.3, 0.2);
        _drawSprite(canvas, suitSprite, 0.7, 0.2);
        _drawSprite(canvas, suitSprite, 0.5, 0.35);
        _drawSprite(canvas, suitSprite, 0.3, 0.5);
        _drawSprite(canvas, suitSprite, 0.7, 0.5);
        _drawSprite(canvas, suitSprite, 0.3, 0.2, rotate: true);
        _drawSprite(canvas, suitSprite, 0.7, 0.2, rotate: true);
      case 8:
        _drawSprite(canvas, suitSprite, 0.3, 0.2);
        _drawSprite(canvas, suitSprite, 0.7, 0.2);
        _drawSprite(canvas, suitSprite, 0.5, 0.35);
        _drawSprite(canvas, suitSprite, 0.3, 0.5);
        _drawSprite(canvas, suitSprite, 0.7, 0.5);
        _drawSprite(canvas, suitSprite, 0.3, 0.2, rotate: true);
        _drawSprite(canvas, suitSprite, 0.7, 0.2, rotate: true);
        _drawSprite(canvas, suitSprite, 0.5, 0.35, rotate: true);
      case 9:
        _drawSprite(canvas, suitSprite, 0.3, 0.2);
        _drawSprite(canvas, suitSprite, 0.7, 0.2);
        _drawSprite(canvas, suitSprite, 0.5, 0.3);
        _drawSprite(canvas, suitSprite, 0.3, 0.4);
        _drawSprite(canvas, suitSprite, 0.7, 0.4);
        _drawSprite(canvas, suitSprite, 0.3, 0.2, rotate: true);
        _drawSprite(canvas, suitSprite, 0.7, 0.2, rotate: true);
        _drawSprite(canvas, suitSprite, 0.3, 0.4, rotate: true);
        _drawSprite(canvas, suitSprite, 0.7, 0.4, rotate: true);
      case 10:
        _drawSprite(canvas, suitSprite, 0.3, 0.2);
        _drawSprite(canvas, suitSprite, 0.7, 0.2);
        _drawSprite(canvas, suitSprite, 0.5, 0.3);
        _drawSprite(canvas, suitSprite, 0.3, 0.4);
        _drawSprite(canvas, suitSprite, 0.7, 0.4);
        _drawSprite(canvas, suitSprite, 0.3, 0.2, rotate: true);
        _drawSprite(canvas, suitSprite, 0.7, 0.2, rotate: true);
        _drawSprite(canvas, suitSprite, 0.5, 0.3, rotate: true);
        _drawSprite(canvas, suitSprite, 0.3, 0.4, rotate: true);
        _drawSprite(canvas, suitSprite, 0.7, 0.4, rotate: true);
      case 11: // Jack
        _drawSprite(canvas, suit.isRed ? redJack : blackJack, 0.5, 0.5);
      case 12: // Queen
        _drawSprite(canvas, suit.isRed ? redQueen : blackQueen, 0.5, 0.5);
      case 13: // King
        _drawSprite(canvas, suit.isRed ? redKing : blackKing, 0.5, 0.5);
    }
  }

  /// @flame 스프라이트를 카드의 특정 위치에 그리는 헬퍼 메서드
  /// relativeX, relativeY: 카드 크기에 대한 상대적 위치 (0~1)
  /// scale: 스프라이트 크기 배율
  /// rotate: 180도 회전 여부
  void _drawSprite(
    Canvas canvas,
    Sprite sprite,
    double relativeX,
    double relativeY, {
    double scale = 1,
    bool rotate = false,
  }) {
    if (rotate) {
      canvas.save();
      canvas.translate(size.x / 2, size.y / 2);
      canvas.rotate(pi);
      canvas.translate(-size.x / 2, -size.y / 2);
    }
    sprite.render(
      canvas,
      position: Vector2(relativeX * size.x, relativeY * size.y),
      anchor: Anchor.center,
      size: sprite.srcSize.scaled(scale),
    );
    if (rotate) {
      canvas.restore();
    }
  }
}
