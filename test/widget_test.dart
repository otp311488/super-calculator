
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_static_physics/main.dart';

void main() {
  testWidgets('HomePage is loaded', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the HomePage is loaded.
    expect(find.byType(HomePage), findsOneWidget);
  });
}
