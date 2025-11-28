import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

void main() {
  testWidgets('toggles sandwich size between footlong and six-inch', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const App());

    expect(find.textContaining('footlong sandwich'), findsOneWidget);
    expect(find.textContaining('six-inch sandwich'), findsNothing);

    // Tap the size switch
    final sizeSwitch = find.byType(Switch).at(0);
    await tester.tap(sizeSwitch);
    await tester.pumpAndSettle();

    expect(find.textContaining('six-inch sandwich'), findsOneWidget);
    expect(find.textContaining('footlong sandwich'), findsNothing);

    // Toggle back
    await tester.tap(sizeSwitch);
    await tester.pumpAndSettle();

    expect(find.textContaining('footlong sandwich'), findsOneWidget);
  });

  testWidgets('toggles toasted option', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // Find the switches by Keys defined in the OrderScreen.
    final sizeSwitchFinder = find.byKey(const Key('sandwich_size_switch'));
    final toastedSwitchFinder = find.byKey(const Key('toasted_switch'));

    expect(sizeSwitchFinder, findsOneWidget);
    expect(toastedSwitchFinder, findsOneWidget);

    // Ensure widgets are visible before tapping to avoid hit-test warnings.
    await tester.ensureVisible(sizeSwitchFinder);
    await tester.tap(sizeSwitchFinder);
    await tester.pumpAndSettle();

    expect(find.textContaining('six-inch sandwich'), findsOneWidget);

    // Ensure toasted switch visible and toggle it.
    await tester.ensureVisible(toastedSwitchFinder);
    await tester.tap(toastedSwitchFinder);
    await tester.pumpAndSettle();

    expect(toastedSwitchFinder, findsOneWidget);
  });
}
