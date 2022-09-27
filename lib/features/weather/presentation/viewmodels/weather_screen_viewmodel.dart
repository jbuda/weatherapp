import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/core/exceptions.dart';

import 'package:weatherapp/features/weather/domain/entities/entities.dart';
import 'package:weatherapp/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weatherapp/features/weather/domain/usecases/get_five_day_forecast.dart';

class WeatherScreenViewModel with ChangeNotifier {
  final GetCurrentWeather _getCurrentWeather;
  final GetFiveDayForecast _getFiveDayForecast;
  final String _mapUrl;

  final platform = const MethodChannel('webview');

  Forecast? current;
  List<FiveDay>? forecast;
  String dateTime = "";
  String currentError = "";
  String forecastError = "";

  WeatherScreenViewModel({
    required GetCurrentWeather getCurrentWeather,
    required GetFiveDayForecast getFiveDayForecast,
    required String mapUrl,
  }) : _getCurrentWeather = getCurrentWeather, _getFiveDayForecast = getFiveDayForecast, _mapUrl = mapUrl;

  Future<void> fetchWeather() async {
    if (current == null && currentError == "") {

      try {
        current = await _getCurrentWeather();
      } on AppException catch(e)  {
        currentError = e.toString();
      }

      try {
        final forecasts = await _getFiveDayForecast();

        forecast = forecasts
            .where((item) => _filterMiddayForecasts(item.dt))
            .map((item) => FiveDay(day: _getDayOfWeek(item.dt), weather: item.weather, main: item.main)).toList();
      } on AppException catch(e)  {
        forecastError = e.toString();
      }

      dateTime = _formatLastUpdate(current?.dt);

      notifyListeners();
    }
  }

  Future<void> resetWeather() async {
    current = null;
    currentError = "";

    notifyListeners();
  }

  Future<void> openNativeView() async {
    try {
      final params = <String, dynamic>{"url": _mapUrl};

      await platform.invokeMethod<String>('startNativeView', params);
    } on PlatformException catch(e) {
      print(e.message);
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