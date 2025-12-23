import 'package:eyego_task/config/router/routes.dart';
import 'package:eyego_task/core/functions/build_error_dialog.dart';
import 'package:eyego_task/core/functions/show_custom_toast.dart';
import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/core/widgets/custom_progress_hud.dart';
import 'package:eyego_task/features/auth/presentation/manager/register_cubit/cubit/register_cubit.dart';
import 'package:eyego_task/features/auth/presentation/screens/widgets/register_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreenBodyBlocConsumer extends StatelessWidget {
  const RegisterScreenBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacementNamed(
            context,
            Routes.homeScreen,
            arguments: state.userEntity,
          );
          showCustomToast(
            message: "Account created successfully",
            color: AppColors.kGreenColor,
          );
        }
        if (state is RegisterFailure) {
          buildErrorDialog(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is RegisterLoading ? true : false,
          child: RegisterScreenBody(),
        );
      },
    );
  }
}
