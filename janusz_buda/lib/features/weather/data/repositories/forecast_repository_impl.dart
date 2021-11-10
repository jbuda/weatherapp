import 'package:weatherapp/features/weather/data/datasources/forecast_remote_datasource.dart';
import 'package:weatherapp/features/weather/domain/entities/entities.dart';
import 'package:weatherapp/features/weather/domain/repositories/forecast_repository.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastRemoteDatasource remoteDatasource;

  ForecastRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  Future<Forecast> getCurrentForecast() async {
    return await remoteDatasource.getCurrentForecast();
  }

  @override
  Future<List<Forecast>> getFiveDayForecast() async {
    return await remoteDatasource.getFiveDayForecast();
  }
}