// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sort_bloc.dart';

class SortState extends Equatable {
  final String productId;
  final String shelfNumber;
  final String columnNumber;
  final String floorNumber;
  final LocationEnum location;
  const SortState({
    this.productId = "",
    this.shelfNumber = "",
    this.columnNumber = "",
    this.floorNumber = "",
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
    String? shelfNumber,
    String? columnNumber,
    String? floorNumber,
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
