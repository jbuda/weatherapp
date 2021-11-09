import 'package:http/http.dart' as http;

import 'package:weatherapp/features/weather/data/datasources/forecast_remote_datasource.dart';
import 'package:weatherapp/features/weather/data/repositories/forecast_repository_impl.dart';
import 'package:weatherapp/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weatherapp/features/weather/presentation/viewmodels/weather_screen_viewmodel.dart';

const String baseUrl = "https://api.openweathermap.org/data/2.5/";
const String key = "be257b28a7ece664a1abeffeb139078a";
const String city = "London,uk";

final forecastRemoteDatasource = ForecastRemoteDatasourceImpl(baseUrl: baseUrl, key: key, city: city, client: http.Client());
final forecastRepository = ForecastRepositoryImpl(remoteDatasource: forecastRemoteDatasource);
final getCurrentWeatherUseCase = GetCurrentWeather(repository: forecastRepository);

final weatherScreenViewModel = WeatherScreenViewModel(getCurrentWeather: getCurrentWeatherUseCase);