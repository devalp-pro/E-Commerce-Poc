import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/categories_with_sub_category.dart';
import 'package:e_commerce_poc/database/model/product_with_details.dart';
import 'package:e_commerce_poc/database/model/products.dart';
import 'package:e_commerce_poc/repository/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'product_detail_page_event.dart';

part 'product_detail_page_state.dart';

class ProductDetailPageBloc extends Bloc<ProductDetailPageEvent, ProductDetailPageState> {
  final AppDatabase appDatabase;
  final ApiRepository apiRepository;

  ProductDetailPageBloc({@required this.appDatabase, @required this.apiRepository})
      : assert(appDatabase != null),
        assert(apiRepository != null),
        super(ProductDetailPageLoading());

  @override
  Stream<ProductDetailPageState> mapEventToState(
    ProductDetailPageEvent event,
  ) async* {
    if (event is ProductDetailPageStarted) {
      yield* _mapLoadParentProduct(event.product);
    } else if (event is ProductDetailPageUpdateSize) {
      yield* _mapLoadProductSizeByColor(event.variant, event.product);
    }
  }

  Stream<ProductDetailPageState> _mapLoadParentProduct(Product product) async* {
    yield ProductDetailPageLoading();
    try {
      Map<String, dynamic> catListContent = Map();
      List<CategoriesWithSubCategory> parentCatList = await appDatabase.categoryDao.getCategoryWithSubCategory();
      catListContent["Menu"] = parentCatList;
      ProductWithDetails productWithDetails = await appDatabase.productDao.getProductWithDetail(product.id);
      yield ProductDetailPageLoaded(catListContent, productWithDetails);
    } catch (ex) {
      debugPrint(ex);
      yield ProductDetailPageError();
    }
  }

  Stream<ProductDetailPageState> _mapLoadProductSizeByColor(Variant variant, Product product) async* {
    yield ProductDetailPageLoading();
    try {
      Map<String, dynamic> catListContent = Map();
      List<CategoriesWithSubCategory> parentCatList = await appDatabase.categoryDao.getCategoryWithSubCategory();
      catListContent["Menu"] = parentCatList;
      ProductWithDetails productWithDetails = await appDatabase.productDao.getProductWithDetail(product.id, variant: variant);
      yield ProductDetailPageLoaded(catListContent, productWithDetails);
    } catch (ex) {
      debugPrint(ex);
      yield ProductDetailPageError();
    }
  }
}
