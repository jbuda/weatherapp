part of 'five_day_forecast_bloc.dart';

abstract class FiveDayForecastEvent extends Equatable {
  const FiveDayForecastEvent();

  @override
  List<Object> get props => <Object>[];
}

class FetchFiveDayForecast extends FiveDayForecastEvent {
  const FetchFiveDayForecast();

  @override
  List<Object> get props => <Object>[];
}
