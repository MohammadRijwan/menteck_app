import 'dart:convert';

import 'package:http/http.dart';
import 'package:menteck_app/src/core/domain/interface/i_product_repository.dart';
import 'package:menteck_app/src/core/domain/model/product_model.dart';
import 'package:menteck_app/src/core/utils/apiend_points.dart';

class ProductRepository extends IProductRepository {
  final int perPage = 5;
  @override
  Future<List<Product>> getProducts({required int page}) async {
    List<Product> products = [];
    Response response = await post(
      Uri.parse(ApiEndPoints.products),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz'
      },
      body: json.encode({"page": page, "perPage": perPage}),
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      ProductRes? productRes = ProductRes.fromJson(result);
      if (productRes.products!.isNotEmpty) {
        for (var product in productRes.products!) {
          products.add(product);
        }
      }
    } else {
      throw Exception(response.reasonPhrase);
    }
    return products;
  }
}
