import 'package:flame/sprite.dart';
import 'package:flutter/foundation.dart';
import 'package:klondike/klondike_game.dart';

/// 카드의 무늬를 나타내는 클래스 (하트 ♥, 다이아몬드 ♦, 클럽 ♣, 스페이드 ♠)
@immutable
class Suit {
  /// 0-3 사이의 정수값으로 Suit 인스턴스를 생성
  factory Suit.fromInt(int index) {
    assert(
      index >= 0 && index <= 3,
      'index is outside of the bounds of what a suit can be',
    );
    return _singletons[index];
  }

  /// 각 무늬별 이미지 스프라이트 좌표와 크기 정보로 인스턴스 생성
  Suit._(this.value, this.label, double x, double y, double w, double h)
    : sprite = klondikeSprite(x, y, w, h);

  /// 무늬의 숫자값 (0-3)
  final int value;

  /// 무늬 문자 (♥, ♦, ♣, ♠)
  final String label;

  /// 무늬 이미지 스프라이트
  final Sprite sprite;

  /// 메모리 효율을 위해 4개의 Suit 인스턴스를 미리 생성해두고 재사용
  static final List<Suit> _singletons = [
    Suit._(0, '♥', 1176, 17, 172, 183), // 하트
    Suit._(1, '♦', 973, 14, 177, 182), // 다이아몬드
    Suit._(2, '♣', 974, 226, 184, 172), // 클럽
    Suit._(3, '♠', 1178, 220, 176, 182), // 스페이드
  ];

  /// 하트(♥)와 다이아몬드(♦)는 빨간색, 클럽(♣)과 스페이드(♠)는 검은색
  bool get isRed => value <= 1;
  bool get isBlack => value >= 2;
}
