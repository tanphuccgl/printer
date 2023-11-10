import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:printer/src/network/data_sources/base_data_source.dart';
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
}
