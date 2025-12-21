import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/features/products/data/models/product_filter.dart';
import 'package:eyego_task/features/products/presentation/manager/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Products',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(height: 30),

            // Category Filter
            const Text(
              'Category',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('All'),
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
                    label: Text(category),
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

            const SizedBox(height: 20),
            const Divider(),

            // Price Range Filter
            const Text(
              'Price Range',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: minPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Min Price',
                      prefixText: '\$',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      minPrice = double.tryParse(value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: maxPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Max Price',
                      prefixText: '\$',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      maxPrice = double.tryParse(value);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),

            // Rating Filter
            const Text(
              'Minimum Rating',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                for (int i = 5; i >= 1; i--)
                  ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$i'),
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const Text(' & up'),
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

            const SizedBox(height: 20),
            const Divider(),

            // Sort By
            const Text(
              'Sort By',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Price: Low to High'),
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
                  label: const Text('Price: High to Low'),
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
                  label: const Text('Highest Rating'),
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
                  label: const Text('Name (A-Z)'),
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

            const SizedBox(height: 30),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<ProductCubit>().clearFilter();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.kPrimaryColor),
                    ),
                    child: const Text(
                      'Clear All',
                      style: TextStyle(color: AppColors.kPrimaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
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
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Apply Filters'),
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
