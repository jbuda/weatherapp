import 'package:flutter_test/flutter_test.dart';

import 'package:weatherapp/features/weather/presentation/widgets/widgets.dart';

void main() {
  testWidgets('temperature widget display a celsius value', (WidgetTester tester) async {
    await tester.pumpWidget(const Temperature(value: 33));

    final valueFinder = find.text("33\u2103");

    expect(valueFinder, findsOneWidget);
  });
}