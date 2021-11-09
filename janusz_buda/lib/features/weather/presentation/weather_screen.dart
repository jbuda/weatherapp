import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/features/weather/presentation/viewmodels/weather_screen_viewmodel.dart';

import 'package:weatherapp/features/weather/presentation/widgets/widgets.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<WeatherScreenViewModel>(context).fetchWeather();

    final current = Provider.of<WeatherScreenViewModel>(context).current;
    final dateTime = Provider.of<WeatherScreenViewModel>(context).dateTime;

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          TopBar(lastUpdate: dateTime),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: CurrentWeather(current: current),
            ),
          ),
          const FiveDayForecast(),
        ],
      ),
    );
  }
}