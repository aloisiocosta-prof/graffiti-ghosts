import 'package:flutter_test/flutter_test.dart';

import 'package:graffiti_ghosts/main.dart';

void main() {
  testWidgets('renders fortress selection and starts the raid', (tester) async {
    await tester.pumpWidget(const GraffitiGhostsApp());

    expect(find.text('GRAFFITI GHOSTS'), findsAtLeastNWidgets(1));
    expect(find.text('THE NEON VAULT'), findsAtLeastNWidgets(1));
    expect(find.text('ENTER FORTRESS'), findsAtLeastNWidgets(1));

    final enterButton = find.text('ENTER FORTRESS');
    await tester.ensureVisible(enterButton);
    await tester.tap(enterButton);
    await tester.pumpAndSettle();

    expect(find.text('NEON VAULT / RAID 01'), findsAtLeastNWidgets(1));
    expect(find.text('GRAFFITI'), findsAtLeastNWidgets(1));
    expect(find.text('WALL-GRAB'), findsAtLeastNWidgets(1));
    expect(find.text('SLIDE'), findsAtLeastNWidgets(1));
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

    expect(find.text('DETECTED — the guard is in pursuit. Select the revealed alternative route to escape.'), findsAtLeastNWidgets(1));
    expect(find.text('ESCAPE'), findsAtLeastNWidgets(1));
  });

  testWidgets('critical raid controls have semantic labels', (tester) async {
    await tester.pumpWidget(const GraffitiGhostsApp());
    final enterButton = find.text('ENTER FORTRESS');
    await tester.ensureVisible(enterButton);
    await tester.tap(enterButton);
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('GRAFFITI'), findsAtLeastNWidgets(1));
    expect(find.bySemanticsLabel('JUMP'), findsAtLeastNWidgets(1));
    expect(find.bySemanticsLabel('WALL-GRAB'), findsAtLeastNWidgets(1));
    expect(find.bySemanticsLabel('SLIDE'), findsAtLeastNWidgets(1));
  });
}
