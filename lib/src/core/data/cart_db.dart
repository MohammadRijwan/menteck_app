import 'dart:developer';

import 'package:menteck_app/src/core/domain/interface/i_cart_db.dart';
import 'package:menteck_app/src/core/domain/model/cart_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase extends ICartDb {
  static const String _databaseName = 'cart.db';
  static const int _databaseVersion = 1;

  static final CartDatabase instance = CartDatabase._();

  CartDatabase._();

  late Database _database;

  @override
  Future<void> open() async {
    final String path = join(await getDatabasesPath(), _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart_items (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            price INTEGER NOT NULL,
            quantity INTEGER NOT NULL,
            productId INTEGER NOT NULL,
            productImage TEXT NOT NULL       
          )
        ''');
      },
    );
  }

  @override
  Future<void> close() async {
    await _database.close();
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    try {
      final List<Map<String, dynamic>> maps =
          await _database.query('cart_items');
      return List.generate(
        maps.length,
        (i) => CartItem.fromMap(maps[i]),
      );
    } catch (e, stack) {
      log(e.toString());
      log(stack.toString());
      return [];
    }
  }

  @override
  Future<void> addToCart(CartItem item) async {
    await _database.insert(
      'cart_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  @override
  Future<void> updateCartItem(CartItem item) async {
    await _database.update(
      'cart_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<void> deleteCartItem(int id) async {
    await _database.delete(
      'cart_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> getTotal() async {
    final List<Map<String, dynamic>> result = await _database
        .rawQuery('SELECT SUM(price * quantity) as total FROM cart_items');
    return result[0]['total'] ?? 0;
  }

  @override
  Future<int> getTotalItems() async {
    final List<Map<String, dynamic>> result = await _database
        .rawQuery('SELECT SUM(quantity) as total_items FROM cart_items');
    return result[0]['total_items'] ?? 0;
  }
}
