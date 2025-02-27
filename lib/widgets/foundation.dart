import 'package:flame/components.dart';

// Foundation 클래스: 솔리테어 게임에서 최종적으로 카드를 쌓는 영역
// 각 무늬(스페이드, 하트, 다이아몬드, 클럽)별로 에이스부터 킹까지 순서대로 쌓음
class Foundation extends PositionComponent {
  @override
  bool get debugMode => true; // 개발 중 컴포넌트의 경계를 시각화하기 위한 디버그 모드 활성화
}
