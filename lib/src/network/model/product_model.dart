// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:printer/src/network/model/common/base_model.dart';
import 'package:printer/src/utils/utils.dart';

enum LocationEnum {
  inside,
  outside;

  static LocationEnum fromString(String? type) {
    switch (type) {
      case "inside":
        return LocationEnum.inside;
      case "outside":
        return LocationEnum.outside;
    }
    return LocationEnum.inside;
  }

  String get nameOf {
    switch (this) {
      case LocationEnum.inside:
        return "inside";
      case LocationEnum.outside:
        return "outside";
    }
  }

  String get label {
    switch (this) {
      case LocationEnum.inside:
        return "trong";
      case LocationEnum.outside:
        return "ngoài";
    }
  }
}

class ProductModel extends BaseModel {
  final String name;
  final LocationEnum location;
  final String image;
  final String shelfNumber;
  final String columnNumber;
  final String floorNumber;

  ProductModel({
    String? id,
    this.location = LocationEnum.inside,
    Timestamp? createAt,
    Timestamp? updateAt,
    required this.name,
    this.image = "",
    this.shelfNumber = '',
    this.columnNumber = '',
    this.floorNumber = '',
  }) : super(id: id ?? "", createAt: createAt, updateAt: updateAt);

  factory ProductModel.empty() {
    return ProductModel(
      id: "",
      location: LocationEnum.inside,
      name: "",
      image: "",
      shelfNumber: '',
      columnNumber: '',
      floorNumber: '',
    );
  }

  factory ProductModel.template() {
    return ProductModel(
      id: "id",
      location: LocationEnum.inside,
      name: "",
      image: "",
      shelfNumber: '',
      columnNumber: '',
      floorNumber: '',
    );
  }

  factory ProductModel.fromDocument(DocumentSnapshot document) {
    return ProductModel.fromMap(
      document.data() as Map<String, dynamic>,
      id: document.id,
    );
  }

  static ProductModel fromMap(Map map, {String? id}) {
    return ProductModel(
      id: id ?? map['id'],
      location: map["location"] == null
          ? LocationEnum.inside
          : LocationEnum.fromString(map["location"]),
      createAt: Utils.convertMapToTimestamp(map['createAt'] ?? 0),
      updateAt: Utils.convertMapToTimestamp(map['updateAt'] ?? 0),
      name: map['name'] ?? "",
      image: map['image'] ?? "",
      columnNumber: map['columnNumber'] ?? 0,
      floorNumber: map['floorNumber'] ?? 0,
      shelfNumber: map['shelfNumber'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "location": location.nameOf,
      "createAt": createAt,
      "updateAt": updateAt,
      "name": name,
      "image": image,
      "columnNumber": columnNumber,
      "floorNumber": floorNumber,
      "shelfNumber": shelfNumber,
    };
  }

  ProductModel copyWith({
    String? name,
    LocationEnum? location,
    String? image,
    String? shelfNumber,
    String? columnNumber,
    String? floorNumber,
    String? id,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      image: image ?? this.image,
      shelfNumber: shelfNumber ?? this.shelfNumber,
      columnNumber: columnNumber ?? this.columnNumber,
      floorNumber: floorNumber ?? this.floorNumber,
    );
  }
}
