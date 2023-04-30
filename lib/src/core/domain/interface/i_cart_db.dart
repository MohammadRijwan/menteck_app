import 'package:menteck_app/src/core/domain/model/cart_item.dart';

abstract class ICartDb {
  Future<void> open();

  Future<void> close();

  Future<List<CartItem>> getCartItems();

  Future<void> addToCart(CartItem item);

  Future<void> updateCartItem(CartItem item);

  Future<void> deleteCartItem(int id);

  Future<int> getTotal();

  Future<int> getTotalItems();
}
