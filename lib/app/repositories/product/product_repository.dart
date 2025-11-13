import 'package:delivery_app/app/models/product_model.dart';

abstract interface class ProductRepository {
  Future<List<ProductModel>> finaAllProduct();
}
