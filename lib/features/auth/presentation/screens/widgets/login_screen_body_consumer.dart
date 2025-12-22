import 'package:eyego_task/config/router/routes.dart';
import 'package:eyego_task/core/functions/build_error_dialog.dart';
import 'package:eyego_task/core/functions/show_custom_toast.dart';
import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/core/widgets/custom_progress_hud.dart';
import 'package:eyego_task/features/auth/presentation/manager/login_cubit/cubit/login_cubit.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/login_screen_boody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenBodyBlocConsumer extends StatelessWidget {
  const LoginScreenBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, Routes.homeScreen);
          showCustomToast(
            message: "Logged In successfully",
            color: AppColors.kGreenColor,
          );
        }
        if (state is LoginFailure) {
          buildErrorDialog(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is LoginLoading ? true : false,
          child: LoginScreenBody(),
        );
      },
    );
  }
}
