import 'package:eyego_task/config/router/routes.dart';
import 'package:eyego_task/core/functions/show_custom_toast.dart';
import 'package:eyego_task/core/functions/show_filter_bottom_sheet.dart';
import 'package:eyego_task/core/functions/show_search_dialog.dart';
import 'package:eyego_task/core/services/get_it_service.dart';
import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/features/auth/domain/repos/auth_repo.dart';
import 'package:eyego_task/features/auth/presentation/manager/login_cubit/cubit/login_cubit.dart';
import 'package:eyego_task/features/products/presentation/manager/product_cubit.dart';
import 'package:eyego_task/features/products/presentation/screens/widgets/custom_skeletonizer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenBody extends StatelessWidget {
  final bool hasActiveFilters;
  final String userName;

  const HomeScreenBody({
    super.key,
    required this.hasActiveFilters,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(sl.get<AuthRepo>()),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.kPrimaryColor,
              onPressed: () {
                context.read<LoginCubit>().logout();
                Navigator.pushReplacementNamed(context, Routes.loginScreen);
                showCustomToast(
                  message: "Logged out successfully",
                  color: AppColors.kGreenColor,
                );
              },
              foregroundColor: AppColors.kScaffoldColor,
              child: Icon(Icons.logout),
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 110.h,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadiusGeometry.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              backgroundColor: AppColors.kPrimaryColor,
              flexibleSpace: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Products',
                            style: TextStyle(
                              color: AppColors.kWhiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.sp,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => showSearchDialog(context),
                                icon: Icon(
                                  Icons.search,
                                  color: AppColors.kWhiteColor,
                                  size: 24.sp,
                                ),
                              ),
                              Stack(
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        showFilterBottomSheet(context),
                                    icon: Icon(
                                      Icons.filter_list,
                                      color: AppColors.kWhiteColor,
                                      size: 24.sp,
                                    ),
                                  ),
                                  if (hasActiveFilters)
                                    Positioned(
                                      right: 8.w,
                                      top: 8.h,
                                      child: Container(
                                        width: 8.w,
                                        height: 8.h,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<ProductCubit>()
                                      .eitherFailureOrSuccessProducts();
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  color: AppColors.kWhiteColor,
                                  size: 24.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        bottom: 8.h,
                      ),
                      child: Text(
                        "👋 Welcome, $userName",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.kWhiteColor.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                if (hasActiveFilters && state is ProductSuccess)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    color: AppColors.kPrimaryColor.withOpacity(0.1),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_alt,
                          size: 20.sp,
                          color: AppColors.kPrimaryColor,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Filters Active',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            context.read<ProductCubit>().clearFilter();
                          },
                          child: Text(
                            'Clear All',
                            style: TextStyle(fontSize: 14.sp),
                          ),
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
      ),
    );
  }
}
