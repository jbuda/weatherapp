import 'package:weatherapp/features/weather/domain/entities/entities.dart';

class FiveDay {
  final String day;
  final Weather weather;
  final Main main;

  const FiveDay({
    required this.day,
    required this.weather,
    required this.main,
  });
}