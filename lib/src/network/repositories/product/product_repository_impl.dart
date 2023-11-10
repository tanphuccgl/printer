import 'package:printer/src/network/model/common/result.dart';
import 'package:printer/src/network/model/product_model.dart';
import 'package:printer/src/network/repositories/product/product_colection.dart';
import 'package:printer/src/network/repositories/product/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final reference = ProductCollectionReference();

  @override
  Future<XResult<ProductModel>> createProduct(ProductModel data) async {
    return reference.add(data);
  }
}