import 'package:flutter_test/flutter_test.dart';
import 'package:gogothai/main.dart';

void main() {
  testWidgets('GoGoThaiApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GoGoThaiApp());

    // Verify that the title appears
    expect(find.text('GoGo'), findsWidgets);
  });
}
