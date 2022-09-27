import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:weatherapp/features/weather/data/models/models.dart';

import '../../../../test_data/json_reader.dart';
import '../../../../test_data/models.dart' as tm;

void main() {
  test('should return a valid forecast model from test_data', () {
    final Map<String, dynamic> jsonMap = json.decode(reader('current')) as Map<String, dynamic>;
    final result = ForecastModel.fromJson(jsonMap);

    expect(result, tm.forecastModel);
  });
}