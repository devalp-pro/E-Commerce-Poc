part of 'product_list_page_bloc.dart';

abstract class ProductListPageState extends Equatable {
  const ProductListPageState();
}

class ProductListPageLoading extends ProductListPageState {
  @override
  List<Object> get props => [];
}

class ProductListPageLoaded extends ProductListPageState {
  final Map<String, dynamic> productListContent;

  const ProductListPageLoaded(this.productListContent);

  @override
  List<Object> get props => [productListContent];
}

class ProductListPageError extends ProductListPageState {
  @override
  List<Object> get props => [];
}
