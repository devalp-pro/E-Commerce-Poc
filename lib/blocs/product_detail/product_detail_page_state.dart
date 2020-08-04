part of 'product_detail_page_bloc.dart';

abstract class ProductDetailPageState extends Equatable {
  const ProductDetailPageState();
}

class ProductDetailPageLoading extends ProductDetailPageState {
  @override
  List<Object> get props => [];
}

class ProductDetailPageLoaded extends ProductDetailPageState {
  final Map<String, dynamic> productListContent;
  final ProductWithDetails productWithDetails;

  const ProductDetailPageLoaded(this.productListContent, this.productWithDetails);

  @override
  List<Object> get props => [productListContent];
}

class ProductDetailPageError extends ProductDetailPageState {
  @override
  List<Object> get props => [];
}
