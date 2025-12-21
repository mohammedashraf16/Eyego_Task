part of 'product_cubit.dart';

sealed class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final ProductsModel productsModel;
  ProductSuccess(this.productsModel);
}

class ProductFailure extends ProductState {
  final String errorMessage;
  ProductFailure(this.errorMessage);
}
