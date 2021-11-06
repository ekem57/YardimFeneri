import 'package:flutter/material.dart';
import 'package:yardimfeneri/UI/splash/splash_ui.dart';
import 'package:yardimfeneri/navigationpage/landingpage.dart';
import '../notfoundnavigationwidget.dart';
import '../routeconstants.dart';
import 'transitions/fade_route.dart';

class NavigationRouteManager {
  static Route<dynamic> onRouteGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.HOME:
        return _navigateToFadeDeafult(LandingPage(), settings);
      case RouteConstants.SPLASH:
        return _navigateToDeafult(SplashScreen(), settings);
      default:
        return MaterialPageRoute(builder: (_) => NotFoundNavigationWidget());
    }
  }

  NavigationRouteManager._init();

  static MaterialPageRoute _navigateToDeafult(
      Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => page, settings: settings);
  }

  static PageRoute _navigateToFadeDeafult(Widget page, RouteSettings settings) {
    return FadeRoute(page: page, settings: settings);
  }
}
