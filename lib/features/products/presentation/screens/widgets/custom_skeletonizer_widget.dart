import 'package:eyego_task/features/products/presentation/manager/product_cubit.dart';
import 'package:eyego_task/features/products/presentation/screens/widgets/custom_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomSkeletonizerWidget extends StatelessWidget {
  const CustomSkeletonizerWidget({super.key, required this.hasActiveFilters});

  final bool hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is ProductLoading,
          enableSwitchAnimation: true,
          child:
              state is ProductSuccess && state.productsModel.products!.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No products found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        hasActiveFilters
                            ? 'Try adjusting your filters'
                            : 'Try a different search',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: state is ProductSuccess
                      ? state.productsModel.products!.length
                      : 10,
                  itemBuilder: (context, index) {
                    final product = state is ProductSuccess
                        ? state.productsModel.products![index]
                        : null;
                    return CustomListViewItem(product: product);
                  },
                ),
        );
      },
    );
  }
}
