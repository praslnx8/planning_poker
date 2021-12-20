import 'package:flutter_test/flutter_test.dart';
import 'package:planning_poker/main.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    await tester.pumpWidget(PlanningPokerApp());
  });
}
