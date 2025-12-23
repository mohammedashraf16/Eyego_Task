import 'package:eyego_task/config/router/router_transitions.dart';
import 'package:eyego_task/config/router/routes.dart';
import 'package:eyego_task/features/auth/domain/entity/user_entity.dart';
import 'package:eyego_task/features/auth/presentation/screens/login_screen.dart';
import 'package:eyego_task/features/auth/presentation/screens/register_view.dart';
import 'package:eyego_task/features/products/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return RouterTransitions.buildScale(LoginScreen());
      case Routes.registerScreen:
        return RouterTransitions.buildScale(RegisterScreen());
      case Routes.homeScreen:
        final user = settings.arguments as UserEntity?;
        return RouterTransitions.buildFade(HomeScreen(user: user));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
