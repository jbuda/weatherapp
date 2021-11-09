import 'package:weatherapp/features/weather/domain/entities/entities.dart';

class MainModel extends Main {
  const MainModel({
    required double temp,
    required double tempMin,
    required double tempMax,
    required int humidity,
  }) : super(
    temp: temp,
    tempMin: tempMin,
    tempMax: tempMax,
    humidity: humidity,
  );

  factory MainModel.fromJson(Map<String, dynamic> json) =>
      MainModel(
        temp: json['temp'] as double,
        tempMin: json["temp_min"] as double,
        tempMax: json["temp_max"] as double,
        humidity: json["humidity"] as int,
      );
}