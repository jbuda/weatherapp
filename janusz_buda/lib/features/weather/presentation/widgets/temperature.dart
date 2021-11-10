import 'package:flutter/material.dart';

class Temperature extends StatelessWidget {
  final num? value;

  const Temperature({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Text(
          "${value?.toStringAsFixed(0)}\u2103",
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 28,
          )
      );
}