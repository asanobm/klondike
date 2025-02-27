import 'package:flame/components.dart';

// Waste 클래스: 솔리테어 게임에서 Stock에서 뽑은 카드가 임시로 놓이는 영역
// 여기에 있는 카드만 다른 영역으로 이동시킬 수 있음
class Waste extends PositionComponent {
  @override
  bool get debugMode => true; // 개발 중 컴포넌트의 경계를 시각화하기 위한 디버그 모드 활성화
}
