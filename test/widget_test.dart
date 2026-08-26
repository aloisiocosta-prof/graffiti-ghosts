import 'package:flutter_test/flutter_test.dart';

import 'package:graffiti_ghosts/main.dart';

void main() {
  testWidgets('shows the documented entry point before a raid starts', (tester) async {
    await tester.pumpWidget(const GraffitiGhostsApp());

    expect(find.text('GRAFFITI GHOSTS'), findsOneWidget);
    expect(find.text('THE NEON VAULT'), findsOneWidget);
    expect(find.text('ENTER FORTRESS'), findsOneWidget);
  });
}
