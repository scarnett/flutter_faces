import 'package:flutter/material.dart';

class AppRouteTransition extends PageRouteBuilder {
  final Widget page;

  AppRouteTransition({
    required this.page,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          opaque: false,
          transitionDuration: const Duration(milliseconds: 250),
          reverseTransitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            Animatable<Offset> tween = Tween(
              begin: Offset(0.0, 1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.fastOutSlowIn));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
