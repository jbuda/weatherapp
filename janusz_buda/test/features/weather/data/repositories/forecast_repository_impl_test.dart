import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:weatherapp/features/weather/domain/entities/entities.dart';
import 'package:weatherapp/features/weather/data/datasources/forecast_remote_datasource.dart';
import 'package:weatherapp/features/weather/data/repositories/forecast_repository_impl.dart';

import '../../../../test_data/models.dart' as tm;

class RemoteDatasourceMock extends Mock implements ForecastRemoteDatasource { }

void main() {
  late ForecastRepositoryImpl sut;
  late RemoteDatasourceMock remoteDatasourceMock;
  Forecast forecast = tm.forecastModel;

  setUp(() {
    remoteDatasourceMock = RemoteDatasourceMock();

    sut = ForecastRepositoryImpl(remoteDatasource: remoteDatasourceMock);
  });

  test('should return remote data when request is successful', () async {
    when(() => remoteDatasourceMock.getCurrentForecast()).thenAnswer((_) async => tm.forecastModel);

    final result = await sut.getCurrentForecast();

    expect(result, forecast);
  });
}