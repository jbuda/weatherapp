import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/features/weather/presentation/viewmodels/weather_screen_viewmodel.dart';

import 'package:weatherapp/features/weather/presentation/widgets/widgets.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<WeatherScreenViewModel>(context).fetchWeather();

    final viewModelProvider = Provider.of<WeatherScreenViewModel>(context);

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TopBar(lastUpdate: viewModelProvider.dateTime),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: CurrentWeather(current: viewModelProvider.current),
            ),
          ),
          Container(
            color: Colors.grey.shade100,
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: const Text(
              "5 Day Forecast",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )
            ),
          ),
          FiveDayForecast(forecast: viewModelProvider.forecast),
        ],
      ),
    );
  }
}