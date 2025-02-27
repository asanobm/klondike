import 'package:flame/components.dart';

// Stock 클래스: 솔리테어 게임에서 남은 카드를 보관하는 덱
// 플레이어가 새로운 카드를 뽑을 수 있는 메인 카드 더미를 표현
class Stock extends PositionComponent {
  @override
  bool get debugMode => true; // 개발 중 컴포넌트의 경계를 시각화하기 위한 디버그 모드 활성화
}
