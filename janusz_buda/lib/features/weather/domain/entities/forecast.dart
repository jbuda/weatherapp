import 'package:equatable/equatable.dart';

import 'main.dart';
import 'weather.dart';

class Forecast extends Equatable {
  final int dt;
  final Weather weather;
  final Main main;

  const Forecast({
    required this.dt,
    required this.weather,
    required this.main,
  });

  @override
  List<Object> get props => [dt, weather, main];
}