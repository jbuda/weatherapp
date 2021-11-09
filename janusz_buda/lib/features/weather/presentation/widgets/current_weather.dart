import 'package:flutter/material.dart';
import 'package:weatherapp/features/weather/domain/entities/entities.dart';

class CurrentWeather extends StatelessWidget {
  final Forecast? current;

  const CurrentWeather({
    Key? key,
    this.current,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Spacer(),
            Row(
              children: <Widget>[
                _currentTemperature(current?.main.temp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _rangeTemperature("\u25b2", current?.main.tempMax),
                    _rangeTemperature("\u25bc", current?.main.tempMin),
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Divider(thickness: 6,),
            ),
            Text(
              current?.weather.description ?? "",
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "${current?.main.humidity}% humidity",
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
      ),
    );
  }

  Widget _currentTemperature(double? temperature) =>
      Expanded(
        child: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: "${temperature?.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 120,
                ),
              ),
              const TextSpan(
                text: "\u2103",
                style: TextStyle(
                  fontSize: 34,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _rangeTemperature(String prefix, double? temperature) =>
      Text(
          "$prefix ${temperature?.toStringAsFixed(0)}\u2103",
          style: const TextStyle(
            fontSize: 20,
          )
      );
}