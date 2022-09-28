import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/features/common/domain/entities/entities.dart';
import 'package:weatherapp/features/common/widgets/widgets.dart';
import 'package:weatherapp/features/five_day_forecast/presentation/bloc/five_day_forecast_bloc.dart';

class FiveDayForecast extends StatelessWidget {
  const FiveDayForecast(
      {Key? key, required FiveDayForecastBloc fiveDayForecastBloc})
      : _fiveDayForecastBloc = fiveDayForecastBloc,
        super(key: key);

  final FiveDayForecastBloc _fiveDayForecastBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _fiveDayForecastBloc,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              child: const Text("5 Day Forecast",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              color: Colors.grey.shade100,
              height: 100,
              child: FiveDayForecastView(
                  fiveDayForecastBloc: _fiveDayForecastBloc),
            ),
          ]),
    );
  }
}

class FiveDayForecastView extends StatefulWidget {
  const FiveDayForecastView({Key? key, required this.fiveDayForecastBloc})
      : super(key: key);

  final FiveDayForecastBloc fiveDayForecastBloc;

  @override
  State<FiveDayForecastView> createState() => _FiveDayForecastViewState();
}

class _FiveDayForecastViewState extends State<FiveDayForecastView> {
  @override
  void initState() {
    super.initState();
    widget.fiveDayForecastBloc.add(const FetchFiveDayForecast());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiveDayForecastBloc, FiveDayForecastState>(
        builder: (BuildContext context, FiveDayForecastState state) {
      if (state is FiveDayForecastLoading) {
        return const Loader();
      } else if (state is FiveDayForecastLoaded) {
        return _buildLoadedView(state.forecasts);
      } else {
        return Container();
      }
    });
  }

  Widget _buildLoadedView(List<FiveDay> forecasts) => ListView(
        scrollDirection: Axis.horizontal,
        children: forecasts.map((FiveDay day) => _day(day)).toList(),
      );

  Widget _day(FiveDay day) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              day.day,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Temperature(value: day.main.temp),
                ),
                Column(
                  children: <Widget>[
                    TemperatureRange(
                        prefix: "\u25b2", value: day.main.tempMax, size: 10),
                    TemperatureRange(
                        prefix: "\u25bc", value: day.main.tempMin, size: 10),
                  ],
                )
              ],
            ),
            Text(day.weather.description,
                style: const TextStyle(
                  fontSize: 12,
                )),
          ],
        ),
      );
}
