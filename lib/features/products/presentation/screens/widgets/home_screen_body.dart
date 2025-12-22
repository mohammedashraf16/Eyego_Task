import 'package:eyego_task/core/functions/show_filter_bottom_sheet.dart';
import 'package:eyego_task/core/functions/show_search_dialog.dart';
import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/features/products/presentation/manager/product_cubit.dart';
import 'package:eyego_task/features/products/presentation/screens/widgets/custom_skeletonizer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key, required this.hasActiveFilters});

  final bool hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            bottom: AppBar(
              title: Text(
                "👋 Welcome, Mohammed",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.kGreyColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            backgroundColor: AppColors.kPrimaryColor,
            title: const Text(
              'Products',
              style: TextStyle(
                color: AppColors.kWhiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => showSearchDialog(context),
                icon: const Icon(
                  Icons.search,
                  color: AppColors.kWhiteColor,
                  size: 28,
                ),
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () => showFilterBottomSheet(context),
                    icon: const Icon(
                      Icons.filter_list,
                      color: AppColors.kWhiteColor,
                      size: 28,
                    ),
                  ),
                  if (hasActiveFilters)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 8,
                          minHeight: 8,
                        ),
                      ),
                    ),
                ],
              ),
              IconButton(
                onPressed: () {
                  context.read<ProductCubit>().eitherFailureOrSuccessProducts();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: AppColors.kWhiteColor,
                  size: 28,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              if (hasActiveFilters && state is ProductSuccess)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: AppColors.kPrimaryColor.withOpacity(0.1),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.filter_alt,
                        size: 20,
                        color: AppColors.kPrimaryColor,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Filters Active',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          context.read<ProductCubit>().clearFilter();
                        },
                        child: const Text('Clear All'),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: (state is ProductLoading || state is ProductSuccess)
                    ? CustomSkeletonizerWidget(
                        hasActiveFilters: hasActiveFilters,
                      )
                    : const Center(child: Text('Something went wrong!')),
              ),
            ],
          ),
        );
      },
    );
  }
}
