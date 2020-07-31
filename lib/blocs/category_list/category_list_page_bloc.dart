import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/categories_with_sub_category.dart';
import 'package:e_commerce_poc/repository/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'category_list_page_event.dart';

part 'category_list_page_state.dart';

class CategoryListPageBloc extends Bloc<CategoryListPageEvent, CategoryListPageState> {
  final AppDatabase appDatabase;
  final ApiRepository apiRepository;

  CategoryListPageBloc({@required this.appDatabase, @required this.apiRepository})
      : assert(appDatabase != null),
        assert(apiRepository != null),
        super(CategoryListPageLoading());

  @override
  Stream<CategoryListPageState> mapEventToState(
    CategoryListPageEvent event,
  ) async* {
    if (event is CategoryListPageStarted) {
      yield* _mapLoadParentCategoryList(event.category);
    }
  }

  Stream<CategoryListPageState> _mapLoadParentCategoryList(Category category) async* {
    yield CategoryListPageLoading();
    try {
      Map<String, dynamic> catListContent = Map();
      List<CategoriesWithSubCategory> parentCatList = await appDatabase.categoryDao.getCategoryWithSubCategory();
      catListContent["Menu"] = parentCatList;
      catListContent["Categories"] = await appDatabase.categoryDao.getCategoryById(category.id);
      yield CategoryListPageLoaded(catListContent);
    } catch (ex) {
      debugPrint(ex);
      yield CategoryListPageError();
    }
  }
}
