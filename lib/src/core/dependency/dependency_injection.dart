import 'package:get_it/get_it.dart';
import 'package:menteck_app/src/core/data/product_repository.dart';

void setupDependencies() {
  GetIt.instance.registerSingleton<ProductRepository>(ProductRepository());
}
