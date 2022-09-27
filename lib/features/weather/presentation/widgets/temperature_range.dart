import 'package:flutter/material.dart';

class TemperatureRange extends StatelessWidget {
  final String prefix;
  final num? value;
  final double size;

  const TemperatureRange({
    Key? key,
    required this.prefix,
    this.value,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Text(
          "$prefix ${value?.toStringAsFixed(0)}\u2103",
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: size,
          ),
      );
}