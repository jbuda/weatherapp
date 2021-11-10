import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

import 'package:weatherapp/core/network.dart';

import 'package:weatherapp/features/weather/data/datasources/forecast_remote_datasource.dart';
import 'package:weatherapp/features/weather/data/datasources/forecast_local_datasource.dart';
import 'package:weatherapp/features/weather/data/repositories/forecast_repository_impl.dart';
import 'package:weatherapp/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weatherapp/features/weather/domain/usecases/get_five_day_forecast.dart';
import 'package:weatherapp/features/weather/presentation/viewmodels/weather_screen_viewmodel.dart';

// configuration
const String baseUrl = "https://api.openweathermap.org/data/2.5/";
const String key = "be257b28a7ece664a1abeffeb139078a";
const String city = "London,uk";
const String mapUrl = "https://openweathermap.org/weathermap?basemap=map&cities=false&layer=temperature&lat=51&lon=0&zoom=10";

Future<WeatherScreenViewModel> init() async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final NetworkImpl networkImpl = NetworkImpl(Connectivity());

  // datasources
  final forecastRemoteDatasource = ForecastRemoteDatasourceImpl(baseUrl: baseUrl, key: key, city: city, client: http.Client());
  final forecastLocalDatasource = ForecastLocalDatasourceImpl(sharedPreferences: sharedPreferences);

  // repository
  final forecastRepository = ForecastRepositoryImpl(remoteDatasource: forecastRemoteDatasource, localDatasource: forecastLocalDatasource, network: networkImpl);

  // usecases
  final getCurrentWeatherUseCase = GetCurrentWeather(repository: forecastRepository);
  final getFiveDayForecast = GetFiveDayForecast(repository: forecastRepository);

  // viewmodel
  final weatherScreenViewModel = WeatherScreenViewModel(getCurrentWeather: getCurrentWeatherUseCase, getFiveDayForecast: getFiveDayForecast, mapUrl: mapUrl);

  return weatherScreenViewModel;
}

