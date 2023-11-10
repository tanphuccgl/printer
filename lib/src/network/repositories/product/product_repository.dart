import 'package:printer/src/network/model/common/result.dart';
import 'package:printer/src/network/model/product_model.dart';

abstract class ProductRepository {
  Future<XResult<ProductModel>> createProduct(ProductModel data);

  Future<XResult<bool>> updateProduct({
    required String productId,
    required Map<String, dynamic> item,
  });
}
