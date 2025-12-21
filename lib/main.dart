import 'package:eyego_task/config/router/route_generator.dart';
import 'package:eyego_task/config/router/routes.dart';
import 'package:eyego_task/core/database/cache/cache_helper.dart';
import 'package:eyego_task/core/services/get_it_service.dart';
import 'package:eyego_task/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.getRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.loginScreen,
      home: LoginView(),
    );
  }
}
