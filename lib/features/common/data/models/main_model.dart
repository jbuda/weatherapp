import 'package:weatherapp/features/common/domain/entities/entities.dart';

class MainModel extends Main {
  const MainModel({
    required num temp,
    required num tempMin,
    required num tempMax,
    required num humidity,
  }) : super(
          temp: temp,
          tempMin: tempMin,
          tempMax: tempMax,
          humidity: humidity,
        );

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
        temp: json['temp'] as num,
        tempMin: json["temp_min"] as num,
        tempMax: json["temp_max"] as num,
        humidity: json["humidity"] as num,
      );
}
