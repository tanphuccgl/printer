// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sort_bloc.dart';

class SortState extends Equatable {
  final String productId;
  final int shelfNumber;
  final int columnNumber;
  final int floorNumber;
  final LocationEnum location;
  const SortState({
    this.productId = "",
    this.shelfNumber = 0,
    this.columnNumber = 0,
    this.floorNumber = 0,
    this.location = LocationEnum.inside,
  });

  @override
  List<Object?> get props => [
        productId,
        shelfNumber,
        columnNumber,
        floorNumber,
        location,
      ];

  SortState copyWith({
    String? productId,
    int? shelfNumber,
    int? columnNumber,
    int? floorNumber,
    LocationEnum? location,
  }) {
    return SortState(
      productId: productId ?? this.productId,
      shelfNumber: shelfNumber ?? this.shelfNumber,
      columnNumber: columnNumber ?? this.columnNumber,
      floorNumber: floorNumber ?? this.floorNumber,
      location: location ?? this.location,
    );
  }
}
