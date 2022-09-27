import 'package:weatherapp/core/usecase.dart';
import 'package:weatherapp/features/weather/domain/entities/entities.dart';
import 'package:weatherapp/features/weather/domain/repositories/forecast_repository.dart';

class GetFiveDayForecast extends UseCase<List<Forecast>> {
  final ForecastRepository repository;

  GetFiveDayForecast({
    required this.repository,
  });

  @override
  Future<List<Forecast>> call() async => await repository.getFiveDayForecast();
}