import 'package:get_it/get_it.dart';
import 'package:menteck_app/src/core/data/product_repository.dart';
import 'package:menteck_app/src/core/domain/interface/i_product_repository.dart';
import 'package:menteck_app/src/core/domain/model/cart_item.dart';
import 'package:menteck_app/src/core/domain/model/product_model.dart';
import 'package:menteck_app/src/feature/product/bloc/product_event.dart';

import 'cart_usecase.dart';

class ProductUseCase {
  late IProductRepository _repository;
  late CartUseCase _cartUsecase;

  ProductUseCase({IProductRepository? repository}) {
    _repository = repository ?? GetIt.instance.get<ProductRepository>();
    _cartUsecase = CartUseCase();
    open();
  }

  Future<void> open() async {
    await _cartUsecase.open();
  }

  Future<void> close() async {
    await _cartUsecase.close();
  }

  Future<ProductRes> getProducts() async {
    return _repository.getProducts();
  }

  Future<String?> addProduct(AddProductEvent event) async {
    var res = await _cartUsecase.addToCart(
        item: CartItem(
            id: event.product.id!,
            productId: event.product.id!,
            name: event.product.title!,
            price: event.product.price!,
            quantity: 1,
            productImage: event.product.featuredImage!));
    return res;
  }
}
