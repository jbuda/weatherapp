import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:weatherapp/features/weather/presentation/widgets/widgets.dart';

void main() {
  testWidgets('top bar button shows correct icon', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(textDirection: TextDirection.ltr, child: TopBarButton(icon: Icons.refresh, onPressed: () { })));

    final iconTypeFinder = find.byType(Icon);
    final iconFinder = find.byIcon(Icons.refresh);

    expect(iconTypeFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
  });
}