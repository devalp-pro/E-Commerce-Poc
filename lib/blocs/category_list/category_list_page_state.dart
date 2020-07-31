part of 'category_list_page_bloc.dart';

abstract class CategoryListPageState extends Equatable {
  const CategoryListPageState();
}

class CategoryListPageLoading extends CategoryListPageState {
  @override
  List<Object> get props => [];
}

class CategoryListPageLoaded extends CategoryListPageState {
  final Map<String, dynamic> catListContent;

  const CategoryListPageLoaded(this.catListContent);

  @override
  List<Object> get props => [catListContent];
}

class CategoryListPageError extends CategoryListPageState {
  @override
  List<Object> get props => [];
}
