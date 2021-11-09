import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/features/weather/presentation/weather_screen.dart';
import 'package:weatherapp/core/injection_container.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: weatherScreenViewModel),
          ],
          child: const SafeArea(
            child: WeatherScreen()
          ),
        ),
      )
    );
  }
}
