import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/features/products/presentation/manager/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showSearchDialog(BuildContext context) {
  final TextEditingController searchController = TextEditingController();

  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Search Products'),
      content: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          hintText: 'Enter product name...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        autofocus: true,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            context.read<ProductCubit>().searchProducts(value);
            Navigator.of(dialogContext).pop();
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (searchController.text.isNotEmpty) {
              context.read<ProductCubit>().searchProducts(
                searchController.text,
              );
              Navigator.of(dialogContext).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kPrimaryColor,
            foregroundColor: AppColors.kWhiteColor,
          ),
          child: const Text('Search'),
        ),
      ],
    ),
  );
}
