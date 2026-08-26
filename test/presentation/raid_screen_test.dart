import 'package:flutter_test/flutter_test.dart';

import 'package:graffiti_ghosts/main.dart';

void main() {
  testWidgets('renders fortress selection and starts the raid', (tester) async {
    await tester.pumpWidget(const GraffitiGhostsApp());

    expect(find.text('GRAFFITI GHOSTS'), findsOneWidget);
    expect(find.text('THE NEON VAULT'), findsOneWidget);
    expect(find.text('ENTER FORTRESS'), findsOneWidget);

    final enterButton = find.text('ENTER FORTRESS');
    await tester.ensureVisible(enterButton);
    await tester.tap(enterButton);
    await tester.pumpAndSettle();

    expect(find.text('NEON VAULT / RAID 01'), findsOneWidget);
    expect(find.text('GRAFFITI'), findsOneWidget);
    expect(find.text('WALL-GRAB'), findsOneWidget);
    expect(find.text('SLIDE'), findsOneWidget);
  });

  testWidgets('movement enters chase and exposes alternative route action', (tester) async {
    await tester.pumpWidget(const GraffitiGhostsApp());
    final enterButton = find.text('ENTER FORTRESS');
    await tester.ensureVisible(enterButton);
    await tester.tap(enterButton);
    await tester.pumpAndSettle();

    for (var index = 0; index < 5; index++) {
      await tester.tap(find.text('JUMP'));
    }
    await tester.pumpAndSettle();

    expect(find.text('DETECTED — the guard is in pursuit. Select the revealed alternative route to escape.'), findsOneWidget);
    expect(find.text('ESCAPE'), findsOneWidget);
  });

  testWidgets('critical raid controls have semantic labels', (tester) async {
    await tester.pumpWidget(const GraffitiGhostsApp());
    final enterButton = find.text('ENTER FORTRESS');
    await tester.ensureVisible(enterButton);
    await tester.tap(enterButton);
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('GRAFFITI'), findsOneWidget);
    expect(find.bySemanticsLabel('JUMP'), findsOneWidget);
    expect(find.bySemanticsLabel('WALL-GRAB'), findsOneWidget);
    expect(find.bySemanticsLabel('SLIDE'), findsOneWidget);
  });
}
