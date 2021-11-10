import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/features/weather/presentation/widgets/widgets.dart';
import 'package:weatherapp/features/weather/presentation/viewmodels/weather_screen_viewmodel.dart';

class TopBar extends StatelessWidget {
  final String lastUpdate;
  final String error;

  const TopBar({
    Key? key,
    required this.lastUpdate,
    required this.error,
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
              children: _information(),
            ),
          ),
          TopBarButton(icon: Icons.refresh, onPressed: () => viewModelProvider.resetWeather()),
          TopBarButton(icon: Icons.map, onPressed: () => viewModelProvider.openNativeView()),
        ],
      ),
    );
  }

  List<Widget> _information() {
    if (error != "") {
      return <Widget>[
        Text(
          error,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red
          ),
        ),
      ];
    } else {
      return <Widget>[
        Text(lastUpdate),
        const Text(
          "London, UK",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ];
    }
  }
}