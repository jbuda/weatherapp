import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/core/exceptions.dart';
import 'package:weatherapp/features/common/data/models/forecast_model.dart';

abstract class ForecastLocalDatasource {
  Future<ForecastModel> getLastCurrentForecast();
  Future<List<ForecastModel>> getLastFiveDayForecast();
  Future<void> cacheCurrentForecast(ForecastModel forecastToCache);
  Future<void> cacheFiveDayForecast(List<ForecastModel> fiveDayForecastToCache);
}

class ForecastLocalDatasourceImpl implements ForecastLocalDatasource {
  final SharedPreferences sharedPreferences;
  final String cachedCurrentForecastKey = "CACHED_CURRENT_FORECAST";
  final String cachedFiveDayForecastKey = "CACHED_FIVE_DAY_FORECAST";

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
        cachedCurrentForecastKey, json.encode(forecastToCache.toJson()));
  }

  @override
  Future<List<ForecastModel>> getLastFiveDayForecast() {
    final jsonString = sharedPreferences.getString(cachedFiveDayForecastKey);

    if (jsonString != null) {
      final decoded = json.decode(jsonString) as List<dynamic>;

      return Future.value(decoded
          .map((dynamic item) =>
              ForecastModel.fromJson(item as Map<String, dynamic>))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheFiveDayForecast(
      List<ForecastModel> fiveDayForecastToCache) {
    final encoded = fiveDayForecastToCache
        .map((ForecastModel item) => item.toJson())
        .toList();

    return sharedPreferences.setString(
        cachedFiveDayForecastKey, json.encode(encoded));
  }
}
