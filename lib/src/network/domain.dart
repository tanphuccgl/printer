import 'package:printer/src/network/repositories/product/product_repository.dart';
import 'package:printer/src/network/repositories/product/product_repository_impl.dart';

class Domain {
  static Domain? _internal;
  factory Domain() {
    _internal ??= Domain._();

    return _internal!;
  }
  late ProductRepository product;

  Domain._() {
    product = ProductRepositoryImpl();
  }
}
