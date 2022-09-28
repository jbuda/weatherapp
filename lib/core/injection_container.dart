import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/core/network.dart';
import 'package:weatherapp/features/common/data/datasources/forecast_local_datasource.dart';
import 'package:weatherapp/features/common/data/datasources/forecast_remote_datasource.dart';
import 'package:weatherapp/features/common/data/repositories/forecast_repository_impl.dart';
import 'package:weatherapp/features/current_weather/domain/usecases/get_current_weather.dart';
import 'package:weatherapp/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:weatherapp/features/five_day_forecast/domain/usecases/get_five_day_forecast.dart';
import 'package:weatherapp/features/five_day_forecast/presentation/bloc/five_day_forecast_bloc.dart';

// configuration
const String baseUrl = "https://api.openweathermap.org/data/2.5/";
const String key = "be257b28a7ece664a1abeffeb139078a";
const String city = "London,uk";

class DiContainer {
  DiContainer(
      {required this.currentWeatherBloc, required this.fiveDayForecastBloc});

  final CurrentWeatherBloc currentWeatherBloc;
  final FiveDayForecastBloc fiveDayForecastBloc;
}

Future<DiContainer> init() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final NetworkImpl networkImpl = NetworkImpl(Connectivity());

  // datasources
  final forecastRemoteDatasource = ForecastRemoteDatasourceImpl(
      baseUrl: baseUrl, key: key, city: city, client: http.Client());
  final forecastLocalDatasource =
      ForecastLocalDatasourceImpl(sharedPreferences: sharedPreferences);

  // repository
  final forecastRepository = ForecastRepositoryImpl(
      remoteDatasource: forecastRemoteDatasource,
      localDatasource: forecastLocalDatasource,
      network: networkImpl);

  // usecases
  final getCurrentWeatherUseCase =
      GetCurrentWeather(repository: forecastRepository);
  final getFiveDayForecast = GetFiveDayForecast(repository: forecastRepository);

  // bloc
  final currentWeatherBloc =
      CurrentWeatherBloc(getCurrentWeather: getCurrentWeatherUseCase);
  final fiveDayForecastBloc =
      FiveDayForecastBloc(getFiveDayForecast: getFiveDayForecast);

  final diContainer = DiContainer(
    currentWeatherBloc: currentWeatherBloc,
    fiveDayForecastBloc: fiveDayForecastBloc,
  );

  return diContainer;
}
