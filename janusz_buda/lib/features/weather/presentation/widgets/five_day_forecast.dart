import 'package:flutter/material.dart';

import 'package:weatherapp/features/weather/domain/entities/entities.dart';
import 'package:weatherapp/features/weather/presentation/widgets/temperature.dart';
import 'package:weatherapp/features/weather/presentation/widgets/temperature_range.dart';

class FiveDayForecast extends StatelessWidget {
  final List<FiveDay>? forecast;

  const FiveDayForecast({
    Key? key,
    this.forecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: (forecast != null)
          ? forecast!.map((FiveDay day) => _day(day)).toList()
          : <Widget>[Container()],
      ),
    );
  }

  Widget _day(FiveDay day) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            day.day,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Temperature(value: day.main.temp),
              ),
              Column(
                children: <Widget>[
                  TemperatureRange(prefix: "\u25b2", value: day.main.tempMax, size: 10),
                  TemperatureRange(prefix: "\u25bc", value: day.main.tempMin, size: 10),
                ],
              )
            ],
          ),
          Text(
            day.weather.description,
            style: const TextStyle(
              fontSize: 12,
            )
          ),
        ],
      ),
    );
}