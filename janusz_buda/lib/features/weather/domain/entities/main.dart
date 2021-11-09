import 'package:equatable/equatable.dart';

class Main extends Equatable {
  final double temp;
  final double tempMin;
  final double tempMax;
  final int humidity;

  const Main({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
  });

  @override
  List<Object> get props => [temp, tempMin, tempMax, humidity];
}