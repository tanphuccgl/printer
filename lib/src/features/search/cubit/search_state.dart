// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String productId;
  final ProductModel productModel;
  final List<ProductModel> list;

  const SearchState({
    this.productId = "",
    required this.productModel,
    this.list = const [],
  });

  factory SearchState.ds() => SearchState(productModel: ProductModel.empty());

  @override
  List<Object?> get props => [
        productId,
        productModel,
        list,
      ];

  SearchState copyWith({
    String? productId,
    ProductModel? productModel,
    List<ProductModel>? list,
  }) {
    return SearchState(
      productId: productId ?? this.productId,
      productModel: productModel ?? this.productModel,
      list: list ?? this.list,
    );
  }
}
