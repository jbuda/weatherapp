import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weatherapp/features/weather/domain/entities/entities.dart';
import 'package:weatherapp/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weatherapp/features/weather/domain/usecases/get_five_day_forecast.dart';

class WeatherScreenViewModel with ChangeNotifier {
  final GetCurrentWeather _getCurrentWeather;
  final GetFiveDayForecast _getFiveDayForecast;

  Forecast? current;
  List<FiveDay>? forecast;
  String dateTime = "";

  WeatherScreenViewModel({
    required GetCurrentWeather getCurrentWeather,
    required GetFiveDayForecast getFiveDayForecast
  }) : _getCurrentWeather = getCurrentWeather, _getFiveDayForecast = getFiveDayForecast;

  Future<void> fetchWeather() async {
    if (current == null) {

      current = await _getCurrentWeather();

      final forecasts = await _getFiveDayForecast();

      forecast = forecasts
          .where((item) => _filterMiddayForecasts(item.dt))
          .map((item) => FiveDay(day: _getDayOfWeek(item.dt), weather: item.weather, main: item.main)).toList();

      dateTime = _formatLastUpdate(current?.dt);

      notifyListeners();
    }
  }

  String _formatLastUpdate(int? timestamp) {
    if (timestamp != null) {
      final dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return DateFormat('h:mma, EEE MMM d').format(dt);
    }

    return "";
  }

  bool _filterMiddayForecasts(int? timestamp) {
    if (timestamp != null) {
      final dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return DateFormat('HH').format(dt) == "12";
    }

    return false;
  }

  String _getDayOfWeek(int timestamp) {
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('EEE').format(dt).toString();
  }

}