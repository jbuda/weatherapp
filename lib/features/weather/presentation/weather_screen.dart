import 'package:flutter/material.dart';
import 'package:weatherapp/core/injection_container.dart';
import 'package:weatherapp/features/current_weather/presentation/current_weather.dart';
import 'package:weatherapp/features/five_day_forecast/presentation/five_day_forecast.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key, required DiContainer diContainer})
      : _diContainer = diContainer,
        super(key: key);

  final DiContainer _diContainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: CurrentWeather(
                currentWeatherBloc: _diContainer.currentWeatherBloc),
          ),
          FiveDayForecast(
              fiveDayForecastBloc: _diContainer.fiveDayForecastBloc),
        ],
      ),
    );
  }
}
