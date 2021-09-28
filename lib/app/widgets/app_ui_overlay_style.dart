import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppUiOverlayStyle extends StatelessWidget {
  final Widget? child;

  AppUiOverlayStyle({
    this.child,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor:
              Theme.of(context).colorScheme.secondary.withOpacity(0.3),
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: child!,
      );
}
