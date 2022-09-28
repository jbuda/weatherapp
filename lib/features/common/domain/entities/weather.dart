import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String description;

  const Weather({
    required this.description,
  });

  @override
  List<Object> get props => [description];
}