import 'package:weatherapp/features/weather/data/models/models.dart';

const weatherModel = WeatherModel(description: "clear sky");
const mainModel = MainModel(temp: 282.55, tempMin: 280.37, tempMax: 284.26, humidity: 100);
const forecastModel = ForecastModel(dt: 1560350645, weather: weatherModel, main: mainModel);