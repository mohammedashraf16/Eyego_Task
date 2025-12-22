import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/features/products/data/models/product_filter.dart';
import 'package:eyego_task/features/products/presentation/manager/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatefulWidget {
  final ProductFilter currentFilter;

  const FilterBottomSheet({super.key, required this.currentFilter});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String? selectedCategory;
  late double? minPrice;
  late double? maxPrice;
  late double? minRating;
  late String? sortBy;

  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.currentFilter.category;
    minPrice = widget.currentFilter.minPrice;
    maxPrice = widget.currentFilter.maxPrice;
    minRating = widget.currentFilter.minRating;
    sortBy = widget.currentFilter.sortBy;

    if (minPrice != null) {
      minPriceController.text = minPrice!.toStringAsFixed(0);
    }
    if (maxPrice != null) {
      maxPriceController.text = maxPrice!.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.read<ProductCubit>().getAvailableCategories();

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Products',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, size: 24.sp),
                ),
              ],
            ),
            Divider(height: 30.h),
            Text(
              'Category',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                ChoiceChip(
                  label: Text('All', style: TextStyle(fontSize: 12.sp)),
                  selected: selectedCategory == null,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => selectedCategory = null);
                    }
                  },
                  selectedColor: AppColors.kPrimaryColor,
                  labelStyle: TextStyle(
                    color: selectedCategory == null
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                ...categories.map(
                  (category) => ChoiceChip(
                    label: Text(category, style: TextStyle(fontSize: 12.sp)),
                    selected: selectedCategory == category,
                    onSelected: (selected) {
                      setState(
                        () => selectedCategory = selected ? category : null,
                      );
                    },
                    selectedColor: AppColors.kPrimaryColor,
                    labelStyle: TextStyle(
                      color: selectedCategory == category
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),
            const Divider(),
            Text(
              'Price Range',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: minPriceController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      labelText: 'Min Price',
                      labelStyle: TextStyle(fontSize: 12.sp),
                      prefixText: '\$',
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      minPrice = double.tryParse(value);
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: maxPriceController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      labelText: 'Max Price',
                      labelStyle: TextStyle(fontSize: 12.sp),
                      prefixText: '\$',
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      maxPrice = double.tryParse(value);
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),
            const Divider(),
            Text(
              'Minimum Rating',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 8.w,
              children: [
                for (int i = 5; i >= 1; i--)
                  ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$i', style: TextStyle(fontSize: 12.sp)),
                        Icon(Icons.star, size: 16.sp, color: Colors.amber),
                        Text(' & up', style: TextStyle(fontSize: 12.sp)),
                      ],
                    ),
                    selected: minRating == i.toDouble(),
                    onSelected: (selected) {
                      setState(
                        () => minRating = selected ? i.toDouble() : null,
                      );
                    },
                    selectedColor: AppColors.kPrimaryColor,
                    labelStyle: TextStyle(
                      color: minRating == i.toDouble()
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
              ],
            ),

            SizedBox(height: 20.h),
            const Divider(),
            Text(
              'Sort By',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                ChoiceChip(
                  label: Text(
                    'Price: Low to High',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  selected: sortBy == 'price_asc',
                  onSelected: (selected) {
                    setState(() => sortBy = selected ? 'price_asc' : null);
                  },
                  selectedColor: AppColors.kPrimaryColor,
                  labelStyle: TextStyle(
                    color: sortBy == 'price_asc' ? Colors.white : Colors.black,
                  ),
                ),
                ChoiceChip(
                  label: Text(
                    'Price: High to Low',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  selected: sortBy == 'price_desc',
                  onSelected: (selected) {
                    setState(() => sortBy = selected ? 'price_desc' : null);
                  },
                  selectedColor: AppColors.kPrimaryColor,
                  labelStyle: TextStyle(
                    color: sortBy == 'price_desc' ? Colors.white : Colors.black,
                  ),
                ),
                ChoiceChip(
                  label: Text(
                    'Highest Rating',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  selected: sortBy == 'rating',
                  onSelected: (selected) {
                    setState(() => sortBy = selected ? 'rating' : null);
                  },
                  selectedColor: AppColors.kPrimaryColor,
                  labelStyle: TextStyle(
                    color: sortBy == 'rating' ? Colors.white : Colors.black,
                  ),
                ),
                ChoiceChip(
                  label: Text('Name (A-Z)', style: TextStyle(fontSize: 12.sp)),
                  selected: sortBy == 'title',
                  onSelected: (selected) {
                    setState(() => sortBy = selected ? 'title' : null);
                  },
                  selectedColor: AppColors.kPrimaryColor,
                  labelStyle: TextStyle(
                    color: sortBy == 'title' ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),

            SizedBox(height: 30.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<ProductCubit>().clearFilter();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      side: const BorderSide(color: AppColors.kPrimaryColor),
                    ),
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final filter = ProductFilter(
                        category: selectedCategory,
                        minPrice: minPrice,
                        maxPrice: maxPrice,
                        minRating: minRating,
                        sortBy: sortBy,
                      );
                      context.read<ProductCubit>().applyFilter(filter);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
