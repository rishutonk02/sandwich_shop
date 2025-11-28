import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

Future<void> main() async {
  // Test for sandwich size switch (Exercise 2, using Key for Exercise 3 fix)
  testWidgets('toggles sandwich size between footlong and six-inch',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // Exercise 3 Fix: Find the Switch using its unique key
    final switchFinder = find.byKey(const Key('sandwich_size_switch'));
    expect(switchFinder, findsOneWidget);

    // Assert (Initial State): Assuming default is 'footlong' in the item display
    expect(find.textContaining('footlong sandwich'), findsOneWidget);
    expect(find.textContaining('six-inch sandwich'), findsNothing);

    // Act: Tap the switch to toggle from 'footlong' to 'six-inch'
    await tester.tap(switchFinder);
    await tester.pump();

    // Assert: Verify the itemType display changes to 'six-inch'
    expect(find.textContaining('six-inch sandwich'), findsOneWidget);
    expect(find.textContaining('footlong sandwich'), findsNothing);

    // Act: Tap again to toggle back to 'footlong'
    await tester.tap(switchFinder);
    await tester.pump();

    // Assert: Verify the itemType display changes back to 'footlong'
    expect(find.textContaining('footlong sandwich'), findsOneWidget);
  });

  // Test for toasted switch (Exercise 3 verification)
  testWidgets('toggles toasted option', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // Find the new Switch using its unique key
    final toastedSwitchFinder = find.byKey(const Key('toasted_switch'));
    expect(toastedSwitchFinder, findsOneWidget);

    // Act: Tap to toggle
    await tester.tap(toastedSwitchFinder);
    await tester.pump();

    // Check that the switch still exists after interaction
    expect(find.byKey(const Key('toasted_switch')), findsOneWidget);
  });
}
