import 'package:eyego_task/core/database/cache/cache_helper.dart';
import 'package:eyego_task/core/services/get_it_service.dart';
import 'package:eyego_task/features/products/presentation/manager/product_cubit.dart';
import 'package:eyego_task/features/products/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) =>
            sl<ProductCubit>()..eitherFailureOrSuccessProducts(),
        child: const HomeScreen(),
      ),
    );
  }
}
