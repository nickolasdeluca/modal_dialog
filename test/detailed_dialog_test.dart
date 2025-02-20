import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_app.dart';

void main() {
  testWidgets(
    'Shows a detailed dialog with a title, message, details of that message'
    ' and a button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Home(),
        ),
      );

      final buttons = find.byType(ElevatedButton);

      final button = find.descendant(
        of: buttons,
        matching: find.text("Detailed message dialog"),
      );

      await tester.tap(button);

      await tester.pump();

      final titleFinder = find.text("This is a short message");
      final messageFinder =
          find.text("This is larger message that explains the title");
      final visibleTextFinder = find.text("Detailed message").hitTestable();
      final hiddenTextFinder = find
          .text(
              "This is a detailed message that contains more information about the title and message")
          .hitTestable();
      final buttonTextFinder = find.text("Alright!");

      expect(titleFinder, findsOneWidget);
      expect(messageFinder, findsOneWidget);
      expect(visibleTextFinder, findsOneWidget);
      expect(hiddenTextFinder, findsNothing);
      expect(buttonTextFinder, findsOneWidget);

      final hiddenMessageContainer = find.byType(AnimatedCrossFade);

      await tester.tap(hiddenMessageContainer);

      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(hiddenTextFinder, findsOneWidget);

      await tester.tap(hiddenMessageContainer);

      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(hiddenTextFinder, findsNothing);
    },
  );
}
