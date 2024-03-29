import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherapp/core/network.dart';

import 'package:weatherapp/features/weather/domain/entities/entities.dart';
import 'package:weatherapp/features/weather/data/datasources/forecast_remote_datasource.dart';
import 'package:weatherapp/features/weather/data/datasources/forecast_local_datasource.dart';
import 'package:weatherapp/features/weather/data/repositories/forecast_repository_impl.dart';

import '../../../../test_data/models.dart' as tm;

class RemoteDatasourceMock extends Mock implements ForecastRemoteDatasource { }
class LocalDatasourceMock extends Mock implements ForecastLocalDatasource { }
class NetworkMock extends Mock implements Network { }

void main() {
  late ForecastRepositoryImpl sut;
  late RemoteDatasourceMock remoteDatasourceMock;
  late LocalDatasourceMock localDatasourceMock;
  late NetworkMock networkMock;

  Forecast forecast = tm.forecastModel;

  setUp(() {
    remoteDatasourceMock = RemoteDatasourceMock();
    localDatasourceMock = LocalDatasourceMock();
    networkMock = NetworkMock();

    sut = ForecastRepositoryImpl(remoteDatasource: remoteDatasourceMock, localDatasource: localDatasourceMock, network: networkMock);
  });

  test('should return remote data when request is successful', () async {
    when(() => networkMock.isConnected()).thenAnswer((_) async => true);
    when(() => localDatasourceMock.cacheCurrentForecast(tm.forecastModel)).thenAnswer((_) => Future.value());
    when(() => remoteDatasourceMock.getCurrentForecast()).thenAnswer((_) async => tm.forecastModel);

    final result = await sut.getCurrentForecast();

    expect(result, forecast);
  });
}