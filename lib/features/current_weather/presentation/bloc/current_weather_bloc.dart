import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/features/common/domain/entities/entities.dart';
import 'package:weatherapp/features/current_weather/domain/usecases/get_current_weather.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  CurrentWeatherBloc({
    required GetCurrentWeather getCurrentWeather,
  })  : _getCurrentWeather = getCurrentWeather,
        super(const CurrentWeatherState()) {
    on<FetchCurrentWeather>(_onFetchCurrentWeather);
  }

  final GetCurrentWeather _getCurrentWeather;

  Future<void> _onFetchCurrentWeather(
      FetchCurrentWeather event, Emitter<CurrentWeatherState> emit) async {
    emit(const CurrentWeatherLoading());

    final forecast = await _getCurrentWeather();
    final lastUpdate = _formatLastUpdate(forecast.dt);

    emit(CurrentWeatherLoaded(forecast: forecast, lastUpdate: lastUpdate));
  }

  String _formatLastUpdate(int? timestamp) {
    if (timestamp != null) {
      final dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return DateFormat('h:mma, EEE MMM d').format(dt);
    }

    return "";
  }
}
