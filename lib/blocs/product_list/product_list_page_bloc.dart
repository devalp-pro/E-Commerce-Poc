import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/categories_with_sub_category.dart';
import 'package:e_commerce_poc/repository/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'product_list_page_event.dart';

part 'product_list_page_state.dart';

class ProductListPageBloc extends Bloc<ProductListPageEvent, ProductListPageState> {
  final AppDatabase appDatabase;
  final ApiRepository apiRepository;

  ProductListPageBloc({@required this.appDatabase, @required this.apiRepository})
      : assert(appDatabase != null),
        assert(apiRepository != null),
        super(ProductListPageLoading());

  @override
  Stream<ProductListPageState> mapEventToState(
    ProductListPageEvent event,
  ) async* {
    if (event is ProductListPageStarted) {
      yield* _mapLoadParentCategoryList(event.category);
    }
  }

  Stream<ProductListPageState> _mapLoadParentCategoryList(Category category) async* {
    yield ProductListPageLoading();
    try {
      Map<String, dynamic> catListContent = Map();
      List<CategoriesWithSubCategory> parentCatList = await appDatabase.categoryDao.getCategoryWithSubCategory();
      catListContent["Menu"] = parentCatList;
//      catListContent["Products"] = await appDatabase.productDao.getProductsByCategoryId(category.id);
      yield ProductListPageLoaded(catListContent);
    } catch (ex) {
      debugPrint(ex);
      yield ProductListPageError();
    }
  }
}
