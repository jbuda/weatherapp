import 'package:weatherapp/core/usecase.dart';
import 'package:weatherapp/features/weather/domain/entities/entities.dart';
import 'package:weatherapp/features/weather/domain/repositories/forecast_repository.dart';

class GetCurrentWeather extends UseCase<Forecast> {
  final ForecastRepository repository;

  GetCurrentWeather({
    required this.repository,
  });

  @override
  Future<Forecast> call() async => await repository.getCurrentForecast();
}