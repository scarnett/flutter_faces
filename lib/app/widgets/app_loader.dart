import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final Color color;

  const AppLoader({
    Key? key,
    this.color: Colors.blue,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      );
}
