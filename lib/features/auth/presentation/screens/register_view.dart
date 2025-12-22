import 'package:eyego_task/core/services/get_it_service.dart';
import 'package:eyego_task/features/auth/domain/repos/auth_repo.dart';
import 'package:eyego_task/features/auth/presentation/manager/register_cubit/cubit/register_cubit.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/register_screen_body_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(sl.get<AuthRepo>()),
      child: Scaffold(body: RegisterScreenBodyBlocConsumer()),
    );
  }
}
