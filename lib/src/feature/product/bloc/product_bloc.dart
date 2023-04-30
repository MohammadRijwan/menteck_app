import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menteck_app/src/core/domain/model/product_model.dart';
import 'package:menteck_app/src/core/domain/usecase/product_usecase.dart';
import 'package:menteck_app/src/feature/product/bloc/product_event.dart';
import 'package:menteck_app/src/feature/product/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUseCase _productUsecase;

  ProductBloc(this._productUsecase) : super(ProductLoadingState()) {
    List<Product> products = [];
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        products = await _productUsecase.getProducts(page: 1);
        emit(ProductLoadedState(products));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });
    on<AddProductEvent>((event, emit) async {
      var result = await _productUsecase.addProduct(event);
      emit(AddedProductState(result!));
      emit(ProductLoadedState(products));
    });
  }
  @override
  Future<void> close() {
    _productUsecase.close();
    return super.close();
  }

  void fetchProduct() {
    print("Fetching product");
  }
}
