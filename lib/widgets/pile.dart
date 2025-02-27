import 'package:flame/components.dart';

// Pile 클래스: 솔리테어 게임의 메인 플레이 영역
// 카드를 색상이 번갈아가며 내림차순으로 쌓을 수 있는 7개의 기둥을 표현
class Pile extends PositionComponent {
  @override
  bool get debugMode => true; // 개발 중 컴포넌트의 경계를 시각화하기 위한 디버그 모드 활성화
}
