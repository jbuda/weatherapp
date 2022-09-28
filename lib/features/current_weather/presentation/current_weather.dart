import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/features/common/domain/entities/entities.dart';
import 'package:weatherapp/features/common/widgets/widgets.dart';
import 'package:weatherapp/features/current_weather/presentation/bloc/current_weather_bloc.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather(
      {Key? key, required CurrentWeatherBloc currentWeatherBloc})
      : _currentWeatherBloc = currentWeatherBloc,
        super(key: key);

  final CurrentWeatherBloc _currentWeatherBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _currentWeatherBloc,
      child: CurrentWeatherView(currentWeatherBloc: _currentWeatherBloc),
    );
  }
}

class CurrentWeatherView extends StatefulWidget {
  const CurrentWeatherView({Key? key, required this.currentWeatherBloc})
      : super(key: key);

  final CurrentWeatherBloc currentWeatherBloc;

  @override
  State<CurrentWeatherView> createState() => _CurrentWeatherViewState();
}

class _CurrentWeatherViewState extends State<CurrentWeatherView> {
  @override
  void initState() {
    super.initState();
    widget.currentWeatherBloc.add(const FetchCurrentWeather());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
        builder: (BuildContext context, CurrentWeatherState state) {
      if (state is CurrentWeatherLoading) {
        return const Loader();
      } else if (state is CurrentWeatherLoaded) {
        return _buildLoadedView(state.forecast, state.lastUpdate);
      } else {
        return Container();
      }
    });
  }

  Widget _buildLoadedView(Forecast current, String lastUpdate) => Column(
        children: [
          TopBar(
              refreshWeather: _onFetchWeather,
              lastUpdate: lastUpdate,
              error: ''),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      children: <Widget>[
                        _currentTemperature(current.main.temp),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TemperatureRange(
                                prefix: "\u25b2",
                                value: current.main.tempMax,
                                size: 20),
                            TemperatureRange(
                                prefix: "\u25bc",
                                value: current.main.tempMin,
                                size: 20),
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Divider(
                        thickness: 6,
                      ),
                    ),
                    Text(
                      current.weather.description,
                      style: const TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "${current.main.humidity}% humidity",
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget _currentTemperature(num? temperature) => Expanded(
        child: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: "${temperature?.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 120,
                ),
              ),
              const TextSpan(
                text: "\u2103",
                style: TextStyle(
                  fontSize: 34,
                ),
              ),
            ],
          ),
        ),
      );

  void _onFetchWeather() {
    widget.currentWeatherBloc.add(const FetchCurrentWeather());
  }
}
