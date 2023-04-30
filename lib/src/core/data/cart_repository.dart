// import 'package:sqflite/sqflite.dart';
//
// const String productCart = 'cart';
// const String productId = 'productId';
// const String cartId = '_id';
// const String productName = 'name';
// const String productQty = 'qty';
// const String productPrice = 'price';
// const String productUrl = 'url';
//
// class CartStorage {
//   int? id;
//   int? pId;
//   String? name;
//   double? price;
//   int? qty;
//   String? url;
//
//   Map<String, dynamic> toMap() {
//     var map = <String, dynamic>{
//       productName: name,
//       productQty: qty,
//       productPrice: price,
//       productId: pId,
//       productUrl: url,
//     };
//     if (id != null) {
//       map[cartId] = id;
//     }
//     return map;
//   }
//
//   CartStorage.fromMap(Map<String, dynamic> map) {
//     id = map[cartId];
//     pId = map[productId];
//     name = map[productName];
//     qty = map[productQty];
//     price = map[productPrice];
//     url = map[productUrl];
//   }
// }
//
// class TodoProvider {
//   late Database db;
//
//   Future open(String path) async {
//     db = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//       await db.execute('''
// create table $productCart (
//   $cartId integer primary key autoincrement,
//   $productId integer not null,
//   $productName text not null,
//   $productQty integer not null,
//   $productPrice double not null,
//   $productUrl text not null)
// ''');
//     });
//   }
//
//   Future<CartStorage> insert(CartStorage todo) async {
//     todo.id = await db.insert(productCart, todo.toMap());
//     return todo;
//   }
//
//   Future<CartStorage?> getTodo(int id) async {
//     List<Map<String, dynamic>> maps = await db.query(productCart,
//         columns: [cartId, productId, productQty, productName, productUrl],
//         where: '$cartId = ?',
//         whereArgs: [id]);
//     if (maps.isNotEmpty) {
//       return CartStorage.fromMap(maps.first);
//     }
//     return null;
//   }
//
//   Future<int> delete(int id) async {
//     return await db.delete(productCart, where: '$cartId = ?', whereArgs: [id]);
//   }
//
//   Future<int> update(CartStorage todo) async {
//     return await db.update(productCart, todo.toMap(),
//         where: '$cartId = ?', whereArgs: [todo.id]);
//   }
//
//   Future close() async => db.close();
// }
