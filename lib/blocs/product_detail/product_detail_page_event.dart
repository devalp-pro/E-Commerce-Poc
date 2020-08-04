part of 'product_detail_page_bloc.dart';

abstract class ProductDetailPageEvent extends Equatable {
  const ProductDetailPageEvent();
}

class ProductDetailPageStarted extends ProductDetailPageEvent {
  final Product product;

  const ProductDetailPageStarted(this.product);

  @override
  List<Object> get props => [product];
}
class ProductDetailPageUpdateSize extends ProductDetailPageEvent {
  final Variant variant;
  final Product product;

  const ProductDetailPageUpdateSize(this.variant, this.product);

  @override
  List<Object> get props => [variant];
}