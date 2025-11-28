import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

Future<void> main() async {
  testWidgets('toggles sandwich size between footlong and six-inch',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    final switchFinder = find.byKey(const Key('sandwich_size_switch'));
    expect(switchFinder, findsOneWidget);

    expect(find.textContaining('footlong sandwich'), findsOneWidget);
    expect(find.textContaining('six-inch sandwich'), findsNothing);

    await tester.tap(switchFinder);
    await tester.pump();

    expect(find.textContaining('six-inch sandwich'), findsOneWidget);
    expect(find.textContaining('footlong sandwich'), findsNothing);

    await tester.tap(switchFinder);
    await tester.pump();

    expect(find.textContaining('footlong sandwich'), findsOneWidget);
  });

  testWidgets('toggles toasted option', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    final toastedSwitchFinder = find.byKey(const Key('toasted_switch'));
    expect(toastedSwitchFinder, findsOneWidget);

    await tester.tap(toastedSwitchFinder);
    await tester.pump();

    expect(find.byKey(const Key('toasted_switch')), findsOneWidget);
  });
}
