import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menteck_app/src/core/domain/usecase/product_usecase.dart';
import 'package:menteck_app/src/feature/product/bloc/product_event.dart';
import 'package:menteck_app/src/feature/product/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUseCase _productUsecase;

  ProductBloc(this._productUsecase) : super(ProductLoadingState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final productRes = await _productUsecase.getProducts();
        emit(ProductLoadedState(productRes));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });
    on<AddProductEvent>((event, emit) async {
      final productRes = await _productUsecase.getProducts();
      var result = await _productUsecase.addProduct(event);
      emit(AddedProductState(result!));
      emit(ProductLoadedState(productRes));
    });
  }
  @override
  Future<void> close() {
    _productUsecase.close();
    return super.close();
  }
}
