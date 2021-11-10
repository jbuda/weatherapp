import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weatherapp/features/weather/data/models/forecast_model.dart';
import 'package:weatherapp/core/exceptions.dart';

abstract class ForecastLocalDatasource {
  Future<ForecastModel> getLastCurrentForecast();
  Future<void> cacheCurrentForecast(ForecastModel forecastToCache);
}

class ForecastLocalDatasourceImpl implements ForecastLocalDatasource {
  final SharedPreferences sharedPreferences;
  final String cachedCurrentForecastKey = "CACHED_CURRENT_FORECAST";

  const ForecastLocalDatasourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<ForecastModel> getLastCurrentForecast() {
    final jsonString = sharedPreferences.getString(cachedCurrentForecastKey);

    if (jsonString != null) {
      final decoded = json.decode(jsonString) as Map<String, dynamic>;
      return Future.value(ForecastModel.fromJson(decoded));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCurrentForecast(ForecastModel forecastToCache) {
    return sharedPreferences.setString(
      cachedCurrentForecastKey,
      json.encode(forecastToCache.toJson())
    );
  }
}