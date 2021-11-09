import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weatherapp/features/weather/domain/entities/entities.dart';
import 'package:weatherapp/features/weather/domain/usecases/get_current_weather.dart';

class WeatherScreenViewModel with ChangeNotifier {
  final GetCurrentWeather _getCurrentWeather;

  Forecast? current;
  String dateTime = "";

  WeatherScreenViewModel({
    required GetCurrentWeather getCurrentWeather
  }) : _getCurrentWeather = getCurrentWeather;

  Future<void> fetchWeather() async {
    if (current == null) {

      current = await _getCurrentWeather();
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

}