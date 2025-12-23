import 'package:eyego_task/config/router/route_generator.dart';
import 'package:eyego_task/config/router/routes.dart';
import 'package:eyego_task/core/database/cache/cache_helper.dart';
import 'package:eyego_task/core/services/get_it_service.dart';
import 'package:eyego_task/core/services/my_bloc_observer.dart';
import 'package:eyego_task/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper().init();
  setupServiceLocator();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    String? token = sl<CacheHelper>().getData(key: "token");
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        home: child,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: token == null ? Routes.loginScreen : Routes.homeScreen,
      ),
    );
  }
}
