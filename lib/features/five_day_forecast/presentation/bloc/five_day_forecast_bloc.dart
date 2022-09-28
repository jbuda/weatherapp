import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/features/common/domain/entities/entities.dart';
import 'package:weatherapp/features/five_day_forecast/domain/usecases/get_five_day_forecast.dart';

part 'five_day_forecast_event.dart';
part 'five_day_forecast_state.dart';

class FiveDayForecastBloc
    extends Bloc<FiveDayForecastEvent, FiveDayForecastState> {
  FiveDayForecastBloc({
    required GetFiveDayForecast getFiveDayForecast,
  })  : _getFiveDayForecast = getFiveDayForecast,
        super(const FiveDayForecastState()) {
    on<FetchFiveDayForecast>(_onFetchFiveDayForecast);
  }

  final GetFiveDayForecast _getFiveDayForecast;

  Future<void> _onFetchFiveDayForecast(
      FetchFiveDayForecast event, Emitter<FiveDayForecastState> emit) async {
    emit(const FiveDayForecastLoading());

    final forecasts = await _getFiveDayForecast();
    final fiveDays = forecasts
        .where((item) => _filterMiddayForecasts(item.dt))
        .map((item) => FiveDay(
            day: _getDayOfWeek(item.dt),
            weather: item.weather,
            main: item.main))
        .toList();

    emit(FiveDayForecastLoaded(forecasts: fiveDays));
  }

  bool _filterMiddayForecasts(int? timestamp) {
    if (timestamp != null) {
      final dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      final hour = DateFormat('HH').format(dt);
      return ["12", "13"].contains(hour);
    }

    return false;
  }

  String _getDayOfWeek(int timestamp) {
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('EEE').format(dt).toString();
  }
}
