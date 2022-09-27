import 'package:weatherapp/core/network.dart';
import 'package:weatherapp/features/weather/data/datasources/forecast_local_datasource.dart';
import 'package:weatherapp/features/weather/data/datasources/forecast_remote_datasource.dart';
import 'package:weatherapp/features/weather/domain/entities/entities.dart';
import 'package:weatherapp/features/weather/domain/repositories/forecast_repository.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastRemoteDatasource remoteDatasource;
  final ForecastLocalDatasource localDatasource;
  final Network network;

  ForecastRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.network,
  });

  @override
  Future<Forecast> getCurrentForecast() async {
    if (await network.isConnected()) {
      final forecastModel = await remoteDatasource.getCurrentForecast();
      localDatasource.cacheCurrentForecast(forecastModel);

      return forecastModel;
    } else {
      return await localDatasource.getLastCurrentForecast();
    }
  }

  @override
  Future<List<Forecast>> getFiveDayForecast() async {
    if (await network.isConnected()) {
      final forecastModel = await remoteDatasource.getFiveDayForecast();
      localDatasource.cacheFiveDayForecast(forecastModel);

      return forecastModel;
    } else {
      return await localDatasource.getLastFiveDayForecast();
    }
  }
}
