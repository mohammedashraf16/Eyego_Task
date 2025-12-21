class ProductFilter {
  final String? category;
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final String? sortBy;

  ProductFilter({
    this.category,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.sortBy,
  });

  ProductFilter copyWith({
    String? category,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    String? sortBy,
  }) {
    return ProductFilter(
      category: category ?? this.category,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  bool get hasActiveFilters =>
      category != null ||
      minPrice != null ||
      maxPrice != null ||
      minRating != null ||
      sortBy != null;

  ProductFilter clear() {
    return ProductFilter();
  }
}
