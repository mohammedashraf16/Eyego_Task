import 'package:eyego_task/features/products/data/models/product_model.dart';
import 'package:eyego_task/features/products/domain/usecases/get_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUsecase getProductsUsecase;
  ProductCubit({required this.getProductsUsecase}) : super(ProductInitial());
  Future<void> eitherFailureOrSuccessProducts() async {
    emit(ProductLoading());
    final eitherFailureOrSuccess = await getProductsUsecase();
    eitherFailureOrSuccess.fold(
      (failure) => emit(ProductFailure(failure.errorMessage)),
      (productsModel) => emit(ProductSuccess(productsModel)),
    );
  }
}
