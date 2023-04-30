import 'dart:developer';

class CartItem {
  final int id;
  final int productId;
  final String name;
  final int price;
  final int quantity;

  final String productImage;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productImage,
  });

  int get total => price * quantity;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'productImage': productImage,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static CartItem fromMap(Map<String, dynamic> map) {
    log(map.toString(), name: 'CartItem.fromMap');
    return CartItem(
      id: map['id'],
      productId: map['productId'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      productImage: map['productImage'],
    );
  }
}
