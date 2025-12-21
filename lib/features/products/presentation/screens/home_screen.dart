import 'package:cached_network_image/cached_network_image.dart';
import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/features/products/presentation/manager/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial) {
          context.read<ProductCubit>().eitherFailureOrSuccessProducts();
        }

        if (state is ProductFailure) {
          return Scaffold(body: Center(child: Text(state.errorMessage)));
        }
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
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: AppColors.kWhiteColor,
                  size: 30,
                ),
              ),
            ],
          ),
          body: (state is ProductLoading || state is ProductSuccess)
              ? Skeletonizer(
                  enabled: state is ProductLoading,
                  enableSwitchAnimation: true,
                  child: ListView.builder(
                    itemCount: state is ProductSuccess
                        ? state.productsModel.products!.length
                        : 10,
                    itemBuilder: (context, index) {
                      final product = state is ProductSuccess
                          ? state.productsModel.products![index]
                          : null;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.kBordersideColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: product?.thumbnail != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                        child: CachedNetworkImage(
                                          width: 150,
                                          imageUrl: product!.thumbnail!,
                                          placeholder: (context, url) =>
                                              Container(
                                                color: Colors.grey[300],
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      )
                                    : Container(
                                        width: 120,
                                        height: 150,
                                        color: Colors.grey[300],
                                      ),
                                title: Text(
                                  product?.title ?? 'Title Placeholder',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '\$${product?.price ?? '00.00'}',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : const Center(child: Text('Something went wrong!')),
        );
      },
    );
  }
}
