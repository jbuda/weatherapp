import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:weatherapp/features/weather/data/models/forecast_model.dart';

abstract class ForecastRemoteDatasource {
  Future<ForecastModel> getCurrentForecast();
  Future<List<ForecastModel>> getFiveDayForecast();
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

  @override
  Future<List<ForecastModel>> getFiveDayForecast() async {
    final url = Uri.parse('${baseUrl}forecast').replace(query: 'q=$city&appid=$key&units=metric');
    final http.Response response = await client.get(url);
    final decoded = json.decode(response.body) as Map<String, dynamic>;

    final items = decoded["list"] as List<dynamic>;

    return items.map((dynamic item) => ForecastModel.fromJson(item as Map<String, dynamic>)).toList();
  }
}