import 'package:flutter/cupertino.dart';
import 'package:klondike/klondike_game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

/// 카드의 숫자/문자를 나타내는 클래스 (A, 2-10, J, Q, K)
@immutable
class Rank {
  /// 1-13 사이의 정수값으로 Rank 인스턴스를 생성
  factory Rank.fromInt(int value) {
    assert(
      value >= 1 && value <= 13,
      'Rank value must be between 1 and 13, inclusive.',
    );
    return _singletons[value - 1];
  }

  /// 각 랭크별 이미지 스프라이트 좌표와 크기 정보로 인스턴스 생성
  Rank._(
    this.value,
    this.label,
    double x1,
    double y1,
    double x2,
    double y2,
    double w,
    double h,
  ) : redSprite = klondikeSprite(x1, y1, w, h),
      blackSprite = klondikeSprite(x2, y2, w, h);

  /// 카드의 숫자값 (1-13)
  final int value;

  /// 카드에 표시될 문자 ('A', '2'-'10', 'J', 'Q', 'K')
  final String label;

  /// 빨간색(하트/다이아몬드) 카드용 스프라이트
  final Sprite redSprite;

  /// 검은색(스페이드/클럽) 카드용 스프라이트
  final Sprite blackSprite;

  /// 메모리 효율을 위해 13개의 Rank 인스턴스를 미리 생성해두고 재사용
  static final List<Rank> _singletons = [
    Rank._(1, 'A', 335, 164, 789, 161, 120, 129),
    Rank._(2, '2', 20, 19, 15, 322, 83, 125),
    Rank._(3, '3', 122, 19, 117, 322, 80, 127),
    Rank._(4, '4', 213, 12, 208, 315, 93, 132),
    Rank._(5, '5', 314, 21, 309, 324, 85, 125),
    Rank._(6, '6', 419, 17, 414, 320, 84, 129),
    Rank._(7, '7', 509, 21, 505, 324, 92, 128),
    Rank._(8, '8', 612, 19, 607, 322, 78, 127),
    Rank._(9, '9', 709, 19, 704, 322, 84, 130),
    Rank._(10, '10', 810, 20, 805, 322, 137, 127),
    Rank._(11, 'J', 15, 170, 469, 167, 56, 126),
    Rank._(12, 'Q', 92, 168, 547, 165, 132, 128),
    Rank._(13, 'K', 243, 170, 696, 167, 92, 123),
  ];
}
