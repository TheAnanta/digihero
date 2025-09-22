import 'package:flutter_test/flutter_test.dart';
import 'package:digihero/main.dart';

void main() {
  group('DigiHero App Tests', () {
    testWidgets('App starts and shows main screen',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const DigiHeroApp());

      // Verify that the app title is shown.
      expect(find.text('DigiHero'), findsOneWidget);
    });

    testWidgets('App shows start adventure button',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const DigiHeroApp());

      // Wait for animations to complete
      await tester.pumpAndSettle();

      // Verify that the start adventure button is shown.
      expect(find.text('START ADVENTURE'), findsOneWidget);
    });
  });
}
