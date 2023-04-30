import 'package:menteck_app/src/core/domain/model/product_model.dart';

abstract class IProductRepository {
  Future<ProductRes> getProducts();
}
