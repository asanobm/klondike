// Flame 게임 엔진 관련 패키지 임포트
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
// 커스텀 위젯 임포트
import 'package:klondike/widgets/foundation.dart';
import 'package:klondike/widgets/pile.dart';
import 'package:klondike/widgets/stock.dart';
import 'package:klondike/widgets/waste.dart';

// 메인 함수: 게임 실행의 시작점
void main() {
  final game = KlondikeGame();
  runApp(GameWidget(game: game)); // Flame의 GameWidget을 사용하여 게임 실행
}

// 클론다이크 게임의 메인 게임 클래스
// FlameGame을 상속받아 게임의 기본 구조를 구현
class KlondikeGame extends FlameGame {
  // 카드 레이아웃 관련 상수 정의
  static const double cardGap = 175.0; // 카드 사이의 간격
  static const double cardWidth = 1000.0; // 카드의 너비
  static const double cardHeight = 1400.0; // 카드의 높이
  static const double cardRadius = 100.0; // 카드 모서리의 둥근 정도

  // 카드 크기를 Vector2 객체로 저장 (Flame에서 사용하는 벡터 형식)
  static final Vector2 cardSize = Vector2(cardWidth, cardHeight);

  @override
  Future<void> onLoad() async {
    // 게임 초기화 시 실행되는 메서드
    await Flame.images.load('klondike-sprites.png');

    // 덱을 놓는 영역(Stock) 생성 및 위치 설정
    final stock =
        Stock()
          ..size = cardSize
          ..position = Vector2(cardGap, cardGap);

    // 버린 카드 영역(Waste) 생성 및 위치 설정
    final waste =
        Waste()
          ..size = cardSize
          ..position = Vector2(cardGap * 2 + cardWidth, cardGap);

    // 파운데이션 영역 생성 (4개의 에이스 위치)
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

    // 테이블에 놓이는 카드 더미(Pile) 영역 생성 (7개)
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

    // 생성된 모든 게임 요소들을 world에 추가
    world.add(stock);
    world.add(waste);
    world.addAll(foundations);
    world.addAll(piles);

    // 카메라 설정: 게임 화면의 크기와 위치 조정
    camera.viewfinder.visibleGameSize = Vector2(
      cardWidth * 7 + cardGap * 8,
      4 * cardHeight + 3 * cardGap,
    );
    camera.viewfinder.position = Vector2(cardWidth * 3.5 + cardGap * 4, 0);
    camera.viewfinder.anchor = Anchor.topCenter; // 카메라 앵커를 상단 중앙으로 설정
  }
}

// 스프라이트 이미지에서 특정 영역을 잘라내어 반환하는 유틸리티 함수
Sprite klondikeSprite(double x, double y, double width, double height) {
  return Sprite(
    Flame.images.fromCache('klondike-sprites.png'),
    srcPosition: Vector2(x, y), // 스프라이트 시트에서의 시작 위치
    srcSize: Vector2(width, height), // 잘라낼 영역의 크기
  );
}
