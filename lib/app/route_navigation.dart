import 'package:flutter/material.dart';

class RouteNavigation {
  RouteNavigation._();
  static Future<void> push(BuildContext context, Widget view) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => view,
        ),
      );

  static Future<void> pushWithTransition(BuildContext context, Widget view) => Navigator.push(
        context,
        _createRoute(view),
      );
}

Route _createRoute(Widget view) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return view;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1);
      const end = Offset.zero; // equivalent to  OffSet(0,0) and represents the origin of a coordinate space
      const cubicCurveType = Curves.easeIn;

      final curveBetween = CurveTween(curve: cubicCurveType);

      final animateBetween = Tween(
        begin: begin,
        end: end,
      ).chain(curveBetween);

      final Animation<Offset> offsetAnimation = animation.drive<Offset>(animateBetween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}


// What is PageRouteBuilder

