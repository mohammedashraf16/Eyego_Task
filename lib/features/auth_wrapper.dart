import 'package:eyego_task/core/services/get_it_service.dart';
import 'package:eyego_task/features/auth/domain/repos/auth_repo.dart';
import 'package:eyego_task/features/auth/presentation/manager/cubit/auth_check_cubit.dart';
import 'package:eyego_task/features/auth/presentation/screens/login_screen.dart';
import 'package:eyego_task/features/products/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCheckCubit(sl<AuthRepo>())..checkAuthStatus(),
      child: BlocBuilder<AuthCheckCubit, AuthCheckState>(
        builder: (context, state) {
          if (state is AuthCheckLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state is AuthCheckAuthenticated) {
            return HomeScreen(user: state.user);
          }

          return LoginScreen();
        },
      ),
    );
  }
}
