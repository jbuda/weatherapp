import 'package:flutter_test/flutter_test.dart';

import 'package:weatherapp/features/weather/presentation/widgets/widgets.dart';

void main() {
  testWidgets('temperature range widget display a max temp value with units', (WidgetTester tester) async {
    await tester.pumpWidget(const TemperatureRange(prefix: "\u25b2", size: 0, value: 33));

    final valueFinder = find.text("\u25b2 33\u2103");

    expect(valueFinder, findsOneWidget);
  });

  testWidgets('temperature range widget display a min temp value with units', (WidgetTester tester) async {
    await tester.pumpWidget(const TemperatureRange(prefix: "\u25bc", size: 0, value: 12));

    final valueFinder = find.text("\u25bc 12\u2103");

    expect(valueFinder, findsOneWidget);
  });
}