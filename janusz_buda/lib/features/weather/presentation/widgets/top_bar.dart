import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/features/weather/presentation/widgets/top_bar_button.dart';
import 'package:weatherapp/features/weather/presentation/viewmodels/weather_screen_viewmodel.dart';

class TopBar extends StatelessWidget {
  final String lastUpdate;

  const TopBar({
    Key? key,
    required this.lastUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModelProvider = Provider.of<WeatherScreenViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(lastUpdate),
                const Text(
                  "London, UK",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          TopBarButton(icon: Icons.refresh, onPressed: () => viewModelProvider.resetWeather()),
          TopBarButton(icon: Icons.map, onPressed: () => print("hello there map")),
        ],
      ),
    );
  }
}