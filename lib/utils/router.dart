import 'package:flutter/material.dart';
import 'package:minerva_investimentos/views/home_view.dart';
import 'package:minerva_investimentos/views/log_in_view.dart';


const String homeRoute = 'homeRoute';
const String loginRoute = 'login';
const String splashRoute = 'splash';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LogInView());
      //case reLoginRoute:
      //  return MaterialPageRoute(builder: (_) => ReLoginView());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeView());
      //case splashRoute:
      //  return MaterialPageRoute(
      //    builder: (_) => SplashView(),
       // );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('BUG: Rota não definida para ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}