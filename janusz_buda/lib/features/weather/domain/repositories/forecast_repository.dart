import 'package:weatherapp/features/weather/domain/entities/forecast.dart';

abstract class ForecastRepository {
  Future<Forecast> getCurrentForecast();
  Future<List<Forecast>> getFiveDayForecast();
}