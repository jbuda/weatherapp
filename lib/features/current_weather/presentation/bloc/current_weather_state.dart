part of 'current_weather_bloc.dart';

class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();

  @override
  List<Object> get props => <Object>[];
}

class CurrentWeatherLoading extends CurrentWeatherState {
  const CurrentWeatherLoading();
}

class CurrentWeatherLoaded extends CurrentWeatherState {
  const CurrentWeatherLoaded({
    required this.forecast,
    required this.lastUpdate,
  });

  final Forecast forecast;
  final String lastUpdate;

  @override
  List<Object> get props => <Object>[forecast, lastUpdate];
}
