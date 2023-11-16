// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String productId;
  final ProductModel productModel;
  final List<ProductModel> list;
  final XFile? fileImage;

  const SearchState({
    this.productId = "",
    required this.productModel,
    this.list = const [],
    this.fileImage,
  });

  factory SearchState.ds() => SearchState(productModel: ProductModel.empty());

  @override
  List<Object?> get props => [
        productId,
        productModel,
        list,
        fileImage,
      ];

  SearchState copyWith({
    String? productId,
    ProductModel? productModel,
    List<ProductModel>? list,
    XFile? fileImage,
  }) {
    return SearchState(
      productId: productId ?? this.productId,
      productModel: productModel ?? this.productModel,
      list: list ?? this.list,
      fileImage: fileImage ?? this.fileImage,
    );
  }
}
