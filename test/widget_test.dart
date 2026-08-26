import 'package:flutter_test/flutter_test.dart';

import 'package:graffiti_ghosts/main.dart';

void main() {
  testWidgets('renders the raid HUD', (tester) async {
    await tester.pumpWidget(const GraffitiGhostsApp());

    expect(find.text('GRAFFITI GHOSTS'), findsOneWidget);
    expect(find.text('TIME'), findsOneWidget);
    expect(find.text('TREASURE'), findsOneWidget);
    expect(find.text('GRAFFITI'), findsOneWidget);
  });
}
