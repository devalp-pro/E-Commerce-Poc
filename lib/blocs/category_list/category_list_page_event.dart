part of 'category_list_page_bloc.dart';

abstract class CategoryListPageEvent extends Equatable {
  const CategoryListPageEvent();
}

class CategoryListPageStarted extends CategoryListPageEvent {
  final Category category;

  const CategoryListPageStarted(this.category);

  @override
  List<Object> get props => [category];
}
