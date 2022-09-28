import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/features/common/widgets/widgets.dart';

class TopBar extends StatelessWidget {
  final Function refreshWeather;
  final String lastUpdate;
  final String error;
  final platform = const MethodChannel('webview');

  const TopBar({
    Key? key,
    required this.refreshWeather,
    required this.lastUpdate,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          TopBarButton(icon: Icons.refresh, onPressed: () => refreshWeather()),
          TopBarButton(icon: Icons.map, onPressed: () => _openNativeView()),
        ],
      ),
    );
  }

  List<Widget> _information() {
    if (error != "") {
      return <Widget>[
        Text(
          error,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
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

  void _openNativeView() async {
    try {
      const mapUrl =
          "https://openweathermap.org/weathermap?basemap=map&cities=false&layer=temperature&lat=51&lon=0&zoom=10";
      final params = <String, dynamic>{"url": mapUrl};

      await platform.invokeMethod<String>('startNativeView', params);
    } on PlatformException catch (_) {
      // handle error
    }
  }
}
