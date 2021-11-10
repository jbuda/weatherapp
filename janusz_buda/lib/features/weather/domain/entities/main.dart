import 'package:equatable/equatable.dart';

class Main extends Equatable {
  final num temp;
  final num tempMin;
  final num tempMax;
  final num humidity;

  const Main({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
  });

  @override
  List<Object> get props => [temp, tempMin, tempMax, humidity];
}