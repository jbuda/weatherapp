part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();

  @override
  List<Object> get props => <Object>[];
}

class FetchCurrentWeather extends CurrentWeatherEvent {
  const FetchCurrentWeather();

  @override
  List<Object> get props => <Object>[];
}
