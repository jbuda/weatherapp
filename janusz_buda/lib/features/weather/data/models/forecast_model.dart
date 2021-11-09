import 'package:weatherapp/features/weather/domain/entities/entities.dart';
import 'package:weatherapp/features/weather/data/models/models.dart';

class ForecastModel extends Forecast {
  const ForecastModel({
    required int dt,
    required Weather weather,
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
}