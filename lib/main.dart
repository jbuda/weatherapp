import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/features/weather/presentation/viewmodels/weather_screen_viewmodel.dart';
import 'package:weatherapp/features/weather/presentation/weather_screen.dart';
import 'package:weatherapp/core/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final viewModel = await init();
  runApp(WeatherApp(viewModel: viewModel));
}

class WeatherApp extends StatelessWidget {
  final WeatherScreenViewModel viewModel;

  const WeatherApp({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: viewModel),
          ],
          child: const SafeArea(
            child: WeatherScreen()
          ),
        ),
      )
    );
  }
}
