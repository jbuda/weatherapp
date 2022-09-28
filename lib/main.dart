import 'package:flutter/material.dart';
import 'package:weatherapp/core/injection_container.dart';
import 'package:weatherapp/features/weather/presentation/weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final diContainer = await init();
  runApp(WeatherApp(diContainer: diContainer));
}

class WeatherApp extends StatelessWidget {
  final DiContainer diContainer;

  const WeatherApp({
    Key? key,
    required this.diContainer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Scaffold(
        /*body: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: viewModel),
          ],*/
        body: SafeArea(
            child: WeatherScreen(
          diContainer: diContainer,
        )),
      ),
      // )
    );
  }
}
