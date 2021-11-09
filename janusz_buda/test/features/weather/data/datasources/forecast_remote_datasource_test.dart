import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/features/weather/data/datasources/forecast_remote_datasource.dart';
import 'package:weatherapp/features/weather/data/models/forecast_model.dart';

import '../../../../test_data/json_reader.dart';
import '../../../../test_data/models.dart' as tm;

class MockHttpClient extends Mock implements http.Client { }

void main() {
  late MockHttpClient mockHttpClient;
  late ForecastRemoteDatasourceImpl sut;

  setUp(() {
    mockHttpClient = MockHttpClient();
    sut = ForecastRemoteDatasourceImpl(baseUrl: "", key: "", city: "", client: mockHttpClient);

    registerFallbackValue(Uri.parse(""));
  });

  void mockHttpClientStatus200() {
    when(() => mockHttpClient.get(any())).thenAnswer((_) async => http.Response(reader("current"), 200));
  }

  test('should return forecast model when status code is 200', () async {
    mockHttpClientStatus200();

    final ForecastModel result = await sut.getCurrentForecast();

    expect(result, tm.forecastModel);
  });
}