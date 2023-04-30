import 'dart:convert';

import 'package:http/http.dart';
import 'package:menteck_app/src/core/domain/interface/i_product_repository.dart';
import 'package:menteck_app/src/core/domain/model/product_model.dart';
import 'package:menteck_app/src/core/utils/apiend_points.dart';

class ProductRepository extends IProductRepository {
  @override
  Future<ProductRes> getProducts() async {
    Response response = await get(Uri.parse(ApiEndPoints.products));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return ProductRes.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
