import 'package:printer/src/network/model/common/result.dart';
import 'package:printer/src/network/model/product_model.dart';
import 'package:printer/src/network/repositories/product/product_colection.dart';
import 'package:printer/src/network/repositories/product/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final reference = ProductCollectionReference();

  @override
  Future<XResult<ProductModel>> createProduct(ProductModel data) async {
    return reference.set(data);
  }

  @override
  Future<XResult<bool>> updateProduct({
    required String productId,
    required Map<String, dynamic> item,
  }) async =>
      reference.update(productId, item);

  @override
  Future<XResult<ProductModel>> getProduct(String id) async {
    return reference.getProduct(id);
  }

  @override
  Future<XResult<String>> deleteProduct(String id) async {
    return reference.remove(id);
  }

  @override
  Future<XResult<List<ProductModel>>> getAllProduct() async {
    return reference.getAllProduct();
  }
}
