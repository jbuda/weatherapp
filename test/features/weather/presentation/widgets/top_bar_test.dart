import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/features/current_forecast/domain/usecases/get_current_weather.dart';
import 'package:weatherapp/features/five_day_forecast/domain/usecases/get_five_day_forecast.dart';
import 'package:weatherapp/features/weather/presentation/viewmodels/weather_screen_viewmodel.dart';
import 'package:weatherapp/features/weather/presentation/widgets/widgets.dart';

class MockGetCurrentWeather extends Mock implements GetCurrentWeather {}

class MockGetFiveDayForecast extends Mock implements GetFiveDayForecast {}

void main() {
  late MockGetCurrentWeather mockGetCurrentWeather;
  late MockGetFiveDayForecast mockGetFiveDayForecast;
  late WeatherScreenViewModel viewModel;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    mockGetFiveDayForecast = MockGetFiveDayForecast();

    viewModel = WeatherScreenViewModel(
        getCurrentWeather: mockGetCurrentWeather,
        getFiveDayForecast: mockGetFiveDayForecast,
        mapUrl: "");
  });

  testWidgets('two buttons on top bar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: viewModel),
          ],
          child: const Directionality(
              textDirection: TextDirection.ltr,
              child: TopBar(lastUpdate: "", error: ""))),
    );

    final iconTypeFinder = find.byType(TopBarButton);

    expect(iconTypeFinder, findsNWidgets(2));
  });
}
