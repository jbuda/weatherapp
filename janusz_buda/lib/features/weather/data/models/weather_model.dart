import 'package:weatherapp/features/weather/domain/entities/entities.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required String description,
  }) : super(
    description: description,
  );

  factory WeatherModel.fromJson(List<dynamic> json) =>
      WeatherModel(
        description: json.first["description"] as String,
      );
}