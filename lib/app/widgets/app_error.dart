import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final Color iconColor;
  final double iconSize;

  const AppError({
    Key? key,
    this.iconColor: Colors.red,
    this.iconSize: 100.0,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      Center(
        child: Icon(
          Icons.error,
          color: iconColor,
          size: iconSize,
        ),
      );
}
