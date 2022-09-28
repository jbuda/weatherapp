part of 'five_day_forecast_bloc.dart';

class FiveDayForecastState extends Equatable {
  const FiveDayForecastState();

  @override
  List<Object> get props => <Object>[];
}

class FiveDayForecastLoading extends FiveDayForecastState {
  const FiveDayForecastLoading();
}

class FiveDayForecastLoaded extends FiveDayForecastState {
  const FiveDayForecastLoaded({
    required this.forecasts,
  });

  final List<FiveDay> forecasts;

  @override
  List<Object> get props => <Object>[forecasts];
}
