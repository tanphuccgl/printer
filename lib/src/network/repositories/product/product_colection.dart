import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:printer/src/network/data_sources/base_data_source.dart';
import 'package:printer/src/network/model/common/result.dart';
import 'package:printer/src/network/model/product_model.dart';

class ProductCollectionReference extends BaseCollectionReference<ProductModel> {
  ProductCollectionReference()
      : super(
          FirebaseFirestore.instance
              .collection("Products")
              .withConverter<ProductModel>(
                fromFirestore: ((snapshot, _) =>
                    ProductModel.fromDocument(snapshot)),
                toFirestore: (model, _) => model.toMap(),
              ),
        );

  Future<XResult<ProductModel>> getProduct(String id) async {
    try {
      var snapshot = await ref.where('id', isEqualTo: id).limit(1).get();

      var data = snapshot.docs.first.data();

      return XResult.success(data);
    } catch (e) {
      return XResult.exception(e);
    }
  }

  Future<XResult<List<ProductModel>>> getAllProduct() async {
    try {
      var snapshot = await ref.get();

      var data = snapshot.docs.map((e) => e.data()).toList();

      return XResult.success(data);
    } catch (e) {
      return XResult.exception(e);
    }
  }
}
