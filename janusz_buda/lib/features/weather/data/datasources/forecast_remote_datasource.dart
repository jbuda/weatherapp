import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:weatherapp/features/weather/data/models/forecast_model.dart';

abstract class ForecastRemoteDatasource {
  Future<ForecastModel> getCurrentForecast();
}

class ForecastRemoteDatasourceImpl implements ForecastRemoteDatasource {
  final String baseUrl;
  final String key;
  final String city;
  final http.Client client;

  const ForecastRemoteDatasourceImpl({
    required this.baseUrl,
    required this.key,
    required this.city,
    required this.client,
  });

  @override
  Future<ForecastModel> getCurrentForecast() async {
    final url = Uri.parse('${baseUrl}weather').replace(query: 'q=$city&appid=$key&units=metric');
    final http.Response response = await client.get(url);
    final decoded = json.decode(response.body) as Map<String, dynamic>;

    return ForecastModel.fromJson(decoded);
  }
}