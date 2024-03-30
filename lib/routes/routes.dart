import 'package:final_project_mobile/pages/home.dart';
import 'package:final_project_mobile/pages/login.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String pageHome = '/';
  static const String login = '/login';

  static final GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case pageHome:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
