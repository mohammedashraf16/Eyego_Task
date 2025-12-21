import 'package:eyego_task/features/products/presentation/manager/product_cubit.dart';
import 'package:eyego_task/features/products/presentation/screens/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (bottomSheetContext) => BlocProvider.value(
      value: context.read<ProductCubit>(),
      child: FilterBottomSheet(
        currentFilter: context.read<ProductCubit>().currentFilter,
      ),
    ),
  );
}
