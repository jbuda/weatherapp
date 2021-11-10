import 'package:weatherapp/features/weather/domain/entities/entities.dart';
import 'package:weatherapp/features/weather/data/models/models.dart';

class ForecastModel extends Forecast {
  const ForecastModel({
    required int dt,
    required WeatherModel weather,
    required Main main,
  }) : super(
    dt: dt,
    weather: weather,
    main: main,
  );

  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
      ForecastModel(
        dt: json["dt"] as int,
        weather: WeatherModel.fromJson(json["weather"] as List<dynamic>),
        main: MainModel.fromJson(json["main"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        "dt": dt,
        "weather": [
          <String, dynamic>{
            "description": weather.description,
          }
        ],
        "main": <String, dynamic>{
          "temp": main.temp,
          "temp_min": main.tempMin,
          "temp_max": main.tempMax,
          "humidity": main.humidity
        },
      };
}