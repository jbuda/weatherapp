import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherapp/features/current_forecast/domain/usecases/get_current_weather.dart';
import 'package:weatherapp/features/weather/domain/repositories/forecast_repository.dart';

import '../../../../test_data/models.dart' as tm;

class MockForecastRepository extends Mock implements ForecastRepository {}

void main() {
  late GetCurrentWeather sut;
  late MockForecastRepository mockForecastRepository;

  setUp(() {
    mockForecastRepository = MockForecastRepository();
    sut = GetCurrentWeather(repository: mockForecastRepository);
  });

  test('should get forecast from the repository', () async {
    when(() => mockForecastRepository.getCurrentForecast())
        .thenAnswer((_) async => tm.forecastModel);

    final result = await sut();

    expect(result, tm.forecastModel);
    verify(() => mockForecastRepository.getCurrentForecast());
    verifyNoMoreInteractions(mockForecastRepository);
  });
}
