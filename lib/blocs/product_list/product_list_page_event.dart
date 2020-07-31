part of 'product_list_page_bloc.dart';

abstract class ProductListPageEvent extends Equatable {
  const ProductListPageEvent();
}

class ProductListPageStarted extends ProductListPageEvent {
  final Category category;

  const ProductListPageStarted(this.category);

  @override
  List<Object> get props => [category];
}
