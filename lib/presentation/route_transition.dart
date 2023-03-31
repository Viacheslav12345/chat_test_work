import 'package:flutter/material.dart';

class RouteTransition extends PageRouteBuilder {
  final Widget page;

  RouteTransition({required this.page, required String routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              //   FadeTransition(
              //   opacity: animation,
              //   child: child,
              // ),

              SlideTransition(
            position: animation.drive(
              Tween(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).chain(
                CurveTween(curve: Curves.easeOut),
              ),
            ),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        );
}
