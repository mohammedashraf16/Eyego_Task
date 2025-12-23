import 'package:eyego_task/core/services/get_it_service.dart';
import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/features/auth/domain/entity/user_entity.dart';
import 'package:eyego_task/features/products/presentation/manager/product_cubit.dart';
import 'package:eyego_task/features/products/presentation/screens/widgets/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final UserEntity? user;

  const HomeScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductCubit>()..eitherFailureOrSuccessProducts(),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            context.read<ProductCubit>().eitherFailureOrSuccessProducts();
          }

          final hasActiveFilters = context
              .read<ProductCubit>()
              .currentFilter
              .hasActiveFilters;

          if (state is ProductFailure) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.kPrimaryColor,
                title: const Text(
                  'Products',
                  style: TextStyle(
                    color: AppColors.kWhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        context
                            .read<ProductCubit>()
                            .eitherFailureOrSuccessProducts();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kPrimaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return HomeScreenBody(
            hasActiveFilters: hasActiveFilters,
            userName: user?.name ?? 'User',
          );
        },
      ),
    );
  }
}
