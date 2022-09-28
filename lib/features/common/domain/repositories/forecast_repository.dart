import 'package:weatherapp/features/common/domain/entities/forecast.dart';

abstract class ForecastRepository {
  Future<Forecast> getCurrentForecast();
  Future<List<Forecast>> getFiveDayForecast();
}
