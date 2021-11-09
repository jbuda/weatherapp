import 'package:flutter/material.dart';
import 'package:weatherapp/features/weather/presentation/widgets/top_bar_button.dart';

class TopBar extends StatelessWidget {
  final String lastUpdate;

  const TopBar({
    Key? key,
    required this.lastUpdate,
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
              children: <Widget>[
                Text(lastUpdate),
                const Text(
                  "London, UK",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const TopBarButton(icon: Icons.refresh, onPressed: null),
          const TopBarButton(icon: Icons.map, onPressed: null),
        ],
      ),
    );
  }
}