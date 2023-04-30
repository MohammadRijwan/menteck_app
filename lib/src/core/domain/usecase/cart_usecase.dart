import 'package:menteck_app/src/core/data/cart_db.dart';
import 'package:menteck_app/src/core/domain/interface/i_cart_db.dart';
import 'package:menteck_app/src/core/domain/model/cart_item.dart';
import 'package:menteck_app/src/feature/cart/bloc/cart_event.dart';

class CartUseCase {
  late ICartDb _repository;

  CartUseCase() {
    _repository = CartDatabase.instance;
    open();
  }

  Future<void> open() async {
    await _repository.open();
  }

  Future<void> close() async {
    await _repository.close();
  }

  Future<String> addToCart({required CartItem item}) async {
    try {
      await _repository.addToCart(item);
      return 'Product added successfully';
    } catch (e) {
      return 'Product already in your cart';
    }
  }

  Future<void> deleteCartItem(DeleteProductEvent event) async {
    await _repository.deleteCartItem(event.product.id);
  }

  Future<void> updateCartItem({required CartItem item}) async {
    await _repository.updateCartItem(item);
  }

  Future<List<CartItem>> getCartItems() async {
    return await _repository.getCartItems();
  }

  Future<int> getCartItemsCount() async {
    return await _repository.getTotalItems();
  }

  Future<int> getGrandTotal() async {
    return await _repository.getTotal();
  }
}
