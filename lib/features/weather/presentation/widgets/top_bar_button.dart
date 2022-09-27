import 'package:flutter/material.dart';

class TopBarButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const TopBarButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      TextButton(
        onPressed: () => onPressed(),
        child: Icon(icon),
        style: TextButton.styleFrom(
          primary: Colors.black,
          backgroundColor: Colors.grey.shade200,
          padding: EdgeInsets.zero,
          minimumSize: const Size(40, 40),
        ),
      );
}