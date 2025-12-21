import 'package:eyego_task/features/products/data/models/product_filter.dart';
import 'package:eyego_task/features/products/data/models/product_model.dart';
import 'package:eyego_task/features/products/data/models/sub_models/product.dart';
import 'package:eyego_task/features/products/domain/usecases/get_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUsecase getProductsUsecase;
  final SearchProductsUsecase searchProductsUsecase;

  ProductsModel? _allProducts;
  ProductFilter _currentFilter = ProductFilter();
  String? _currentSearchQuery;

  ProductCubit({
    required this.getProductsUsecase,
    required this.searchProductsUsecase,
  }) : super(ProductInitial());

  ProductFilter get currentFilter => _currentFilter;

  Future<void> eitherFailureOrSuccessProducts() async {
    emit(ProductLoading());
    _currentSearchQuery = null;
    _currentFilter = ProductFilter();

    final eitherFailureOrSuccess = await getProductsUsecase();
    eitherFailureOrSuccess.fold(
      (failure) => emit(ProductFailure(failure.errorMessage)),
      (productsModel) {
        _allProducts = productsModel;
        emit(ProductSuccess(productsModel));
      },
    );
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      await eitherFailureOrSuccessProducts();
      return;
    }

    emit(ProductLoading());
    _currentSearchQuery = query;
    _currentFilter = ProductFilter();

    final eitherFailureOrSuccess = await searchProductsUsecase(query);
    eitherFailureOrSuccess.fold(
      (failure) => emit(ProductFailure(failure.errorMessage)),
      (productsModel) {
        _allProducts = productsModel;
        emit(ProductSuccess(productsModel));
      },
    );
  }

  void applyFilter(ProductFilter filter) {
    if (_allProducts == null) return;

    _currentFilter = filter;

    var filteredProducts = List<Products>.from(_allProducts!.products ?? []);

    if (filter.category != null && filter.category!.isNotEmpty) {
      filteredProducts = filteredProducts
          .where(
            (product) =>
                product.category?.toLowerCase() ==
                filter.category!.toLowerCase(),
          )
          .toList();
    }

    if (filter.minPrice != null) {
      filteredProducts = filteredProducts
          .where((product) => (product.price ?? 0) >= filter.minPrice!)
          .toList();
    }

    if (filter.maxPrice != null) {
      filteredProducts = filteredProducts
          .where((product) => (product.price ?? 0) <= filter.maxPrice!)
          .toList();
    }

    if (filter.minRating != null) {
      filteredProducts = filteredProducts
          .where((product) => (product.rating ?? 0) >= filter.minRating!)
          .toList();
    }

    if (filter.sortBy != null) {
      switch (filter.sortBy) {
        case 'price_asc':
          filteredProducts.sort(
            (a, b) => (a.price ?? 0).compareTo(b.price ?? 0),
          );
          break;
        case 'price_desc':
          filteredProducts.sort(
            (a, b) => (b.price ?? 0).compareTo(a.price ?? 0),
          );
          break;
        case 'rating':
          filteredProducts.sort(
            (a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0),
          );
          break;
        case 'title':
          filteredProducts.sort(
            (a, b) => (a.title ?? '').compareTo(b.title ?? ''),
          );
          break;
      }
    }
    final filteredModel = ProductsModel(
      products: filteredProducts,
      total: filteredProducts.length,
      skip: 0,
      limit: filteredProducts.length,
    );

    emit(ProductSuccess(filteredModel));
  }

  void clearFilter() {
    if (_allProducts == null) return;

    _currentFilter = ProductFilter();
    emit(ProductSuccess(_allProducts!));
  }

  List<String> getAvailableCategories() {
    if (_allProducts == null || _allProducts!.products == null) return [];

    final categories = _allProducts!.products!
        .map((product) => product.category ?? '')
        .where((category) => category.isNotEmpty)
        .toSet()
        .toList();

    categories.sort();
    return categories;
  }
}
